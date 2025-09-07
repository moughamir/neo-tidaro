import 'package:shared/utils/type_defs.dart';

/// Base interface for authentication services.
///
/// This defines the standard operations that any authentication service should provide.
/// Implementations will depend on the specific authentication provider (Supabase, Firebase, etc.).
abstract class AuthService {
  /// Signs up a new user with email and password.
  ResultFuture<dynamic> signUpWithPassword({
    required String email,
    required String password,
    Map<String, dynamic>? userData,
  });

  /// Signs in an existing user with email and password.
  ResultFuture<dynamic> signInWithPassword({
    required String email,
    required String password,
  });

  /// Signs in with a provider (OAuth).
  ResultFuture<dynamic> signInWithProvider(String provider);

  /// Signs out the current user.
  ResultFuture<void> signOut();

  /// Sends a password reset email.
  ResultFuture<void> resetPassword(String email);

  /// Returns the current authenticated user, if any.
  dynamic get currentUser;

  /// Returns whether the user is currently authenticated.
  bool get isAuthenticated;

  /// Stream of authentication state changes.
  Stream<dynamic> get authStateChanges;
}
