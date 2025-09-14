// ignore_for_file: always_specify_types

import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Authentication service for TiDash application
/// Provides authentication functionality using Supabase
class TiDashAuthService {
  TiDashAuthService(this._supabaseService);
  final SupabaseServiceInterface _supabaseService;

  /// Get the current authenticated user
  User? get currentUser => _supabaseService.currentUser;

  /// Check if user is authenticated
  bool get isAuthenticated => _supabaseService.isAuthenticated;

  /// Stream of authentication state changes
  Stream<User?> get authStateChanges => _supabaseService.authStateChanges;

  /// Sign in with email and password
  ResultFuture<User> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    CoreLogger.auth('Attempting sign in', details: email);

    final Result<User> result = await _supabaseService.signInWithPassword(
      email: email,
      password: password,
    );

    return result.fold(
      (Failure failure) {
        CoreLogger.auth('Sign in failed', details: failure.message);
        return Left(failure);
      },
      (User user) {
        CoreLogger.auth('Sign in successful', details: user.email);
        return Right(user);
      },
    );
  }

  /// Sign up with email and password
  ResultFuture<User> signUpWithEmailAndPassword({
    required String email,
    required String password,
    Map<String, dynamic>? metadata,
  }) async {
    CoreLogger.auth('Attempting sign up', details: email);

    final Result<User> result = await _supabaseService.signUpWithPassword(
      email: email,
      password: password,
      userData: metadata,
    );

    return result.fold(
      (Failure failure) {
        CoreLogger.auth('Sign up failed', details: failure.message);
        return Left<Failure, User>(failure);
      },
      (User user) {
        CoreLogger.auth('Sign up successful', details: user.email);
        return Right(user);
      },
    );
  }

  /// Sign in with OAuth provider (Google, GitHub, etc.)
  ResultFuture<User> signInWithProvider(String provider) async {
    CoreLogger.auth('Attempting OAuth sign in', details: provider);

    final Result<User> result = await _supabaseService.signInWithProvider(
      provider,
    );

    return result.fold(
      (Failure failure) {
        CoreLogger.auth('OAuth sign in failed', details: failure.message);
        return Left(failure);
      },
      (User user) {
        CoreLogger.auth('OAuth sign in successful', details: user.email);
        return Right(user);
      },
    );
  }

  /// Send password reset email
  ResultVoid resetPassword(String email) async {
    CoreLogger.auth('Sending password reset', details: email);

    final Result<void> result = await _supabaseService.resetPassword(email);

    return result.fold(
      (Failure failure) {
        CoreLogger.auth('Password reset failed', details: failure.message);
        return Left(failure);
      },
      (_) {
        CoreLogger.auth('Password reset email sent', details: email);
        return const Right(null);
      },
    );
  }

  /// Sign out current user
  ResultVoid signOut() async {
    final String userEmail = currentUser?.email ?? 'Unknown';
    CoreLogger.auth('Attempting sign out', details: userEmail);

    final Result<void> result = await _supabaseService.signOut();

    return result.fold(
      (Failure failure) {
        CoreLogger.auth('Sign out failed', details: failure.message);
        return Left(failure);
      },
      (_) {
        CoreLogger.auth('Sign out successful', details: userEmail);
        return const Right(null);
      },
    );
  }

  /// Update user profile
  ResultFuture<User> updateProfile(Map<String, dynamic> profileData) async {
    CoreLogger.auth('Updating user profile');

    final Result<User> result = await _supabaseService.updateProfile(
      data: profileData,
    );

    return result.fold(
      (Failure failure) {
        CoreLogger.auth('Profile update failed', details: failure.message);
        return Left(failure);
      },
      (User user) {
        CoreLogger.auth('Profile update successful');
        return Right(user);
      },
    );
  }

  /// Get user profile data
  ResultFuture<Map<String, dynamic>> getUserProfile() async {
    if (!isAuthenticated) {
      return Left(Failure.validation('User not authenticated'));
    }

    CoreLogger.auth('Fetching user profile');

    final Result<Map<String, dynamic>> result = await _supabaseService
        .getSingleTableData(
          table: 'profiles',
          equals: <String, dynamic>{'user_id': currentUser!.id},
        );

    return result.fold(
      (Failure failure) {
        CoreLogger.auth('Profile fetch failed', details: failure.message);
        return Left(failure);
      },
      (Map<String, dynamic> profile) {
        CoreLogger.auth('Profile fetch successful');
        return Right(profile);
      },
    );
  }
}
