import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:shared/utils/failures/failure.dart';
import 'package:shared/utils/type_defs.dart';

import '../utils/logger.dart';
import 'interfaces/auth_service.dart';
import 'interfaces/database_service.dart';
import 'interfaces/storage_service.dart';
import 'interfaces/remote_data_source.dart';

/// A comprehensive service class to interact with Supabase.
///
/// This service provides a singleton instance for easy access to Supabase functionalities
/// including Authentication, Database (CRUD), Realtime, Storage, GraphQL,
/// and helpers for invoking Edge Functions (RPC) for services like Redis and Mail.
///
/// The service implements multiple interfaces to ensure proper abstraction and
/// adherence to SOLID principles, allowing for dependency inversion.
class SupabaseService
    implements AuthService, DatabaseService, StorageService, RemoteDataSource {
  // --- Singleton Setup ---
  static final SupabaseService _instance = SupabaseService._internal();
  factory SupabaseService() => _instance;
  SupabaseService._internal();

  // --- Properties ---
  late final SupabaseClient _client;
  final Map<String, dynamic> _inMemoryCache = {};

  // --- Getters ---
  /// The main Supabase client instance.
  SupabaseClient get client => _client;

  /// The currently authenticated user, if any.
  User? get currentUser => _client.auth.currentUser;

  /// The GoTrue client for authentication operations.
  GoTrueClient get auth => _client.auth;

  // --- Initialization ---
  /// Initializes the Supabase client. This must be called once at app startup.
  static Future<void> init(String url, String anonKey) async {
    await Supabase.initialize(url: url, anonKey: anonKey);
    _instance._client = Supabase.instance.client;
    CoreLogger.network('SupabaseService initialized successfully');
  }

  // --- Authentication Wrappers ---
  /// Signs up a new user with email and password.
  @override
  ResultFuture<User> signUpWithPassword({
    required String email,
    required String password,
    Map<String, dynamic>? userData,
  }) {
    return safeAsyncCall(
      () async {
        final response = await auth.signUp(
          email: email,
          password: password,
          data: userData,
        );
        if (response.user == null) {
          throw const AuthException('Sign up failed: No user returned.');
        }
        return response.user!;
      },
      context: 'Signing up user',
      tag: 'SupabaseService',
    );
  }

  /// Signs in a user with email and password.
  @override
  ResultFuture<User> signInWithPassword({
    required String email,
    required String password,
  }) {
    return safeAsyncCall(
      () async {
        final response = await auth.signInWithPassword(
          email: email,
          password: password,
        );
        if (response.user == null) {
          throw const AuthException('Sign in failed: Invalid credentials.');
        }
        return response.user!;
      },
      context: 'Signing in user',
      tag: 'SupabaseService',
    );
  }

  /// Signs out the current user.
  @override
  ResultVoid signOut() {
    return safeAsyncCall(
      () => auth.signOut(),
      context: 'Signing out user',
      tag: 'SupabaseService',
    );
  }

  /// Sends a password reset email.
  @override
  ResultVoid resetPassword(String email) {
    return safeAsyncCall(
      () => auth.resetPasswordForEmail(email),
      context: 'Sending password reset email',
      tag: 'SupabaseService',
    );
  }

  // --- Database (CRUD) ---
  /// Fetches multiple rows from a table.
  @override
  ResultFuture<List<Map<String, dynamic>>> getTableData({
    required String table,
    Map<String, dynamic> equals = const {},
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) {
    return safeAsyncCall(
      () async {
        var query = _client.from(table).select();
        
        // Apply filters first (while still PostgrestFilterBuilder)
        equals.forEach((key, value) {
          query = query.eq(key, value);
        });
        
        // Apply transformations (order, limit) that change the type
        dynamic transformedQuery = query;
        if (orderBy != null) {
          transformedQuery = transformedQuery.order(orderBy, ascending: ascending);
        }
        if (limit != null) {
          transformedQuery = transformedQuery.limit(limit);
        }
        
        final result = await transformedQuery;
        return List<Map<String, dynamic>>.from(result);
      },
      context: 'Fetching data from table: $table',
      tag: 'SupabaseService',
    );
  }

  /// Fetches a single row from a table.
  @override
  ResultFuture<Map<String, dynamic>> getSingleTableData({
    required String table,
    Map<String, dynamic> equals = const {},
  }) {
    return safeAsyncCall(
      () async {
        var query = _client.from(table).select();
        
        // Apply filters (while still PostgrestFilterBuilder)
        equals.forEach((key, value) {
          query = query.eq(key, value);
        });
        
        final result = await query.single();
        return Map<String, dynamic>.from(result);
      },
      context: 'Fetching single row from table: $table',
      tag: 'SupabaseService',
    );
  }

  /// Inserts data into a table.
  @override
  ResultFuture<List<Map<String, dynamic>>> insertTableData({
    required String table,
    required List<Map<String, dynamic>> data,
  }) {
    return safeAsyncCall(
      () => _client.from(table).insert(data).select(),
      context: 'Inserting data into table: $table',
      tag: 'SupabaseService',
    );
  }

  /// Updates data in a table.
  @override
  ResultFuture<List<Map<String, dynamic>>> updateTableData({
    required String table,
    required Map<String, dynamic> data,
    required Map<String, dynamic> where,
  }) {
    return safeAsyncCall(
      () {
        var query = _client.from(table).update(data);
        where.forEach((key, value) {
          query = query.eq(key, value);
        });
        return query.select();
      },
      context: 'Updating data in table: $table',
      tag: 'SupabaseService',
    );
  }

  /// Updates the current user's profile in the `profiles` table.
  ResultFuture<User> updateProfile({required Map<String, dynamic> data}) {
    return safeAsyncCall(
      () async {
        final userId = currentUser?.id;
        if (userId == null) {
          throw const AuthException('Not authenticated');
        }
        await _client
            .from('profiles')
            .update(data)
            .eq('user_id', userId)
            .select()
            .single();
        // This doesn't return a User object, so we return the current user.
        // A better approach might be to return the profile data.
        return currentUser!;
      },
      context: 'Updating user profile',
      tag: 'SupabaseService',
    );
  }

  // --- RPC (Edge Functions) ---
  /// Calls a Supabase Edge Function (RPC).
  ResultFuture<dynamic> callFunction({
    required String functionName,
    Map<String, dynamic>? params,
  }) {
    return safeAsyncCall(
      () => _client.rpc(functionName, params: params),
      context: 'Calling function: $functionName',
      tag: 'SupabaseService',
    );
  }

  // --- Storage ---
  /// Uploads a file to a Supabase storage bucket.
  @override
  ResultFuture<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
  }) {
    return safeAsyncCall(
      () => _client.storage.from(bucket).upload(path, file),
      context: 'Uploading file to bucket: $bucket',
      tag: 'SupabaseService',
    );
  }

  /// Gets the public URL of a file in a storage bucket.
  @override
  String getPublicUrl({required String bucket, required String path}) {
    return _client.storage.from(bucket).getPublicUrl(path);
  }

  // --- Realtime ---
  /// Subscribes to a table for realtime updates.
  /// Returns a stream of `PostgresChangePayload`.
  @override
  Stream<List<Map<String, dynamic>>> subscribeToTable({required String table}) {
    return _client.from(table).stream(primaryKey: ['id']);
  }

  /// Gets a specific RealtimeChannel.
  RealtimeChannel getChannel(String name) {
    return _client.channel(name);
  }

  // --- GraphQL ---
  /// Executes a GraphQL query against the Supabase GraphQL endpoint.
  ResultFuture<http.Response> queryGraphQL(String query) {
    return safeAsyncCall(
      () async {
        // Note: GraphQL endpoint construction requires project URL and anon key
        // These should be passed as parameters or stored during initialization
        throw UnimplementedError(
          'GraphQL endpoint requires project-specific configuration',
        );
      },
      context: 'Executing GraphQL query',
      tag: 'SupabaseService',
    );
  }

  // --- Caching ---
  /// Retrieves a value from the in-memory cache.
  T? getFromCache<T>(String key) {
    return _inMemoryCache[key] as T?;
  }

  /// Saves a value to the in-memory cache.
  void saveToCache<T>(String key, T value) {
    _inMemoryCache[key] = value;
  }

  /// Removes a value from the in-memory cache.
  void invalidateCache(String key) {
    _inMemoryCache.remove(key);
  }

  /// Clears the entire in-memory cache.
  void clearCache() {
    _inMemoryCache.clear();
  }

  // --- Redis Helper (via Edge Function) ---
  /// Calls an Edge Function designed to interact with a Redis instance (e.g., Upstash).
  ///
  /// **Setup:**
  /// 1. Create an Edge Function in your Supabase project (e.g., `redis-handler`).
  /// 2. This function should securely connect to your Redis instance.
  /// 3. The function should accept a command (e.g., 'GET', 'SET') and arguments.
  ResultFuture<dynamic> callRedisFunction(
    String command,
    Map<String, dynamic> args,
  ) {
    return callFunction(
      functionName: 'redis-handler',
      params: {'command': command, 'args': args},
    );
  }

  // --- Mail Helper (via Edge Function) ---
  /// Calls an Edge Function to send an email.
  ///
  /// **Setup:**
  /// 1. Create an Edge Function (e.g., `send-email`).
  /// 2. This function should use a mail service provider (e.g., SendGrid, Resend)
  ///    with API keys stored securely as Supabase secrets.
  /// 3. The function should accept parameters like `to`, `subject`, and `body`.
  ResultFuture<void> sendEmail({
    required String to,
    required String subject,
    required String body,
  }) {
    return callFunction(
      functionName: 'send-email',
      params: {'to': to, 'subject': subject, 'body': body},
    );
  }

  // --- Required methods from RemoteDataSource ---
  @override
  ResultFuture<dynamic> get(String endpoint, {Map<String, dynamic>? params}) {
    return safeAsyncCall(
      () async {
        var query = _client.from(endpoint).select();
        if (params != null) {
          params.forEach((key, value) {
            query = query.eq(key, value);
          });
        }
        return query;
      },
      context: 'GET: $endpoint',
      tag: 'SupabaseService',
    );
  }

  @override
  ResultFuture<dynamic> post(String endpoint, {Map<String, dynamic>? body}) {
    return safeAsyncCall(
      () => _client.from(endpoint).insert(body ?? {}).select(),
      context: 'POST: $endpoint',
      tag: 'SupabaseService',
    );
  }

  @override
  ResultFuture<dynamic> put(String endpoint, {Map<String, dynamic>? body}) {
    if (body == null || !body.containsKey('id')) {
      return Future.value(
        Left(Failure.validation('ID is required for PUT operations')),
      );
    }
    final id = body['id'];
    body.remove('id');

    return safeAsyncCall(
      () => _client.from(endpoint).update(body).eq('id', id).select(),
      context: 'PUT: $endpoint',
      tag: 'SupabaseService',
    );
  }

  @override
  ResultFuture<dynamic> delete(
    String endpoint, {
    Map<String, dynamic>? params,
  }) {
    return safeAsyncCall(
      () {
        var query = _client.from(endpoint).delete();
        if (params != null) {
          params.forEach((key, value) {
            query = query.eq(key, value);
          });
        }
        return query.select();
      },
      context: 'DELETE: $endpoint',
      tag: 'SupabaseService',
    );
  }

  // --- Additional required methods from interfaces ---
  @override
  ResultFuture<User> signInWithProvider(String provider) {
    return safeAsyncCall(
      () async {
        // Supabase OAuth with redirect URL - this is platform-specific
        final response = await auth.signInWithOAuth(
          _mapStringToProvider(provider),
          redirectTo: 'io.supabase.flutterquickstart://login-callback/',
        );
        if (!response) {
          throw const AuthException('Provider authentication failed');
        }
        // OAuth requires redirect flow, return current user if available
        final user = auth.currentUser;
        if (user == null) {
          throw const AuthException('No user found after OAuth flow');
        }
        return user;
      },
      context: 'Sign in with provider: $provider',
      tag: 'SupabaseService',
    );
  }

  /// Maps string provider to Supabase OAuthProvider
  OAuthProvider _mapStringToProvider(String provider) {
    switch (provider.toLowerCase()) {
      case 'google':
        return OAuthProvider.google;
      case 'github':
        return OAuthProvider.github;
      case 'apple':
        return OAuthProvider.apple;
      case 'facebook':
        return OAuthProvider.facebook;
      case 'twitter':
        return OAuthProvider.twitter;
      case 'discord':
        return OAuthProvider.discord;
      default:
        return OAuthProvider.github;
    }
  }

  @override
  ResultFuture<void> deleteTableData({
    required String table,
    required Map<String, dynamic> where,
  }) {
    return safeAsyncCall(
      () {
        var query = _client.from(table).delete();
        where.forEach((key, value) {
          query = query.eq(key, value);
        });
        return query;
      },
      context: 'Deleting from table: $table',
      tag: 'SupabaseService',
    );
  }

  @override
  ResultFuture<dynamic> executeQuery(
    String query, {
    Map<String, dynamic>? params,
  }) {
    return safeAsyncCall(
      () => _client.rpc(query, params: params),
      context: 'Executing custom query',
      tag: 'SupabaseService',
    );
  }

  @override
  ResultFuture<File> downloadFile({
    required String bucket,
    required String path,
    required String destinationPath,
  }) {
    return safeAsyncCall(
      () async {
        final bytes = await _client.storage.from(bucket).download(path);
        final file = File(destinationPath);
        await file.writeAsBytes(bytes);
        return file;
      },
      context: 'Downloading file from bucket: $bucket, path: $path',
      tag: 'SupabaseService',
    );
  }

  @override
  ResultFuture<void> deleteFile({
    required String bucket,
    required String path,
  }) {
    return safeAsyncCall(
      () => _client.storage.from(bucket).remove([path]),
      context: 'Deleting file from bucket: $bucket, path: $path',
      tag: 'SupabaseService',
    );
  }

  @override
  ResultFuture<List<String>> listFiles({
    required String bucket,
    String? prefix,
  }) {
    return safeAsyncCall(
      () => _client.storage.from(bucket).list(path: prefix),
      context: 'Listing files in bucket: $bucket',
      tag: 'SupabaseService',
    ).then(
      (result) => result.fold(
        (l) => Left(l),
        (r) => Right(r.map((item) => item.name).toList()),
      ),
    );
  }

  @override
  bool get isAuthenticated => currentUser != null;

  @override
  Stream<User?> get authStateChanges =>
      _client.auth.onAuthStateChange.map((event) => event.session?.user);

  // --- Helper methods ---
  /// A generic async call wrapper that catches exceptions and returns an `Either`.
  ///
  /// This utility function simplifies error handling for async operations by
  /// wrapping them in a try-catch block and returning a `Failure` on error
  /// or the successful result `T` on success.
  ResultFuture<T> safeAsyncCall<T>(
    Future<T> Function() future, {
    String context = 'An operation',
    String tag = 'SafeAsyncCall',
  }) async {
    try {
      return Right(await future());
    } on AuthException catch (e) {
      CoreLogger.error('$context failed', error: e.message, tag: 'SUPABASE');
      return Left(ValidationFailure(e.message));
    } on PostgrestException catch (e) {
      CoreLogger.error('$context failed', error: e.message, tag: 'SUPABASE');
      return Left(Failure.server(e.message, code: int.tryParse(e.code ?? '')));
    } catch (e, stackTrace) {
      CoreLogger.error(
        '$context failed',
        error: e,
        stackTrace: stackTrace,
        tag: 'SUPABASE',
      );
      return Left(Failure.unexpected(e.toString()));
    }
  }
}
