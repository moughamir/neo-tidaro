
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:kui/kui.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// A comprehensive service class to interact with Supabase.
///
/// This service provides a singleton instance for easy access to Supabase functionalities
/// including Authentication, Database (CRUD), Realtime, Storage, GraphQL,
/// and helpers for invoking Edge Functions (RPC) for services like Redis and Mail.
class SupabaseService {
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
    KuiVerb.info('SupabaseService initialized successfully.', tag: 'SupabaseService');
  }

  // --- Authentication Wrappers ---
  /// Signs up a new user with email and password.
  ResultFuture<User> signUpWithPassword({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) {
    return safeAsyncCall(
      () async {
        final response = await auth.signUp(
          email: email,
          password: password,
          data: data,
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
  ResultVoid signOut() {
    return safeAsyncCall(
      () => auth.signOut(),
      context: 'Signing out user',
      tag: 'SupabaseService',
    );
  }

  /// Sends a password reset email.
  ResultVoid resetPassword(String email) {
    return safeAsyncCall(
      () => auth.resetPasswordForEmail(email),
      context: 'Sending password reset email',
      tag: 'SupabaseService',
    );
  }

  // --- Database (CRUD) ---
  /// Fetches multiple rows from a table.
  ResultFuture<List<Map<String, dynamic>>> getTableData({
    required String table,
    Map<String, dynamic> equals = const {},
    String? orderBy,
    bool ascending = true,
    int? limit,
  }) {
    return safeAsyncCall(
      () {
        var query = _client.from(table).select();
        equals.forEach((key, value) {
          query = query.eq(key, value);
        });
        if (orderBy != null) {
          query = query.order(orderBy, ascending: ascending);
        }
        if (limit != null) {
          query = query.limit(limit);
        }
        return query;
      },
      context: 'Fetching data from table: $table',
      tag: 'SupabaseService',
    );
  }

  /// Fetches a single row from a table.
  ResultFuture<Map<String, dynamic>> getSingleTableData({
    required String table,
    Map<String, dynamic> equals = const {},
  }) {
    return safeAsyncCall(
      () {
        var query = _client.from(table).select();
        equals.forEach((key, value) {
          query = query.eq(key, value);
        });
        return query.single();
      },
      context: 'Fetching single row from table: $table',
      tag: 'SupabaseService',
    );
  }

  /// Inserts data into a table.
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
  ResultFuture<List<Map<String, dynamic>>> updateTableData({
    required String table,
    required Map<String, dynamic> data,
    required String where,
  }) {
    return safeAsyncCall(
      () => _client.from(table).update(data).match({'id': where}).select(),
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
        final response = await _client.from('profiles').update(data).eq('user_id', userId).select().single();
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
  String getPublicUrl({required String bucket, required String path}) {
    return _client.storage.from(bucket).getPublicUrl(path);
  }

  // --- Realtime ---
  /// Subscribes to a table for realtime updates.
  /// Returns a stream of `PostgresChangePayload`.
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
        final url = '${_client.supabaseUrl}/graphql/v1';
        final headers = {
          'Content-Type': 'application/json',
          'apikey': _client.supabaseKey,
          'Authorization': 'Bearer ${_client.auth.currentSession?.accessToken}',
        };
        final body = {'query': query};

        return await http.post(Uri.parse(url), headers: headers, body: body);
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
  ResultFuture<dynamic> callRedisFunction(String command, Map<String, dynamic> args) {
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
}

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
    KuiVerb.error('$context failed', tag: tag, error: e.message);
    return Left(Failure.auth(e.message));
  } on PostgrestException catch (e) {
    KuiVerb.error('$context failed', tag: tag, error: e.message);
    return Left(Failure.server(e.message, code: int.tryParse(e.code ?? '')));
  } catch (e, stackTrace) {
    KuiVerb.error('$context failed', tag: tag, error: e, stackTrace: stackTrace);
    return Left(Failure.unexpected(e.toString()));
  }
}
