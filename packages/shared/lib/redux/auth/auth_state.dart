import 'package:equatable/equatable.dart';

/// Authentication state for the application
class AuthState extends Equatable {
  const AuthState({
    required this.isAuthenticated,
    required this.isLoading,
    this.user,
    this.error,
  });

  final bool isAuthenticated;
  final bool isLoading;
  final dynamic user; // User model from core package
  final String? error;

  /// Initial state factory
  const AuthState.initial()
      : isAuthenticated = false,
        isLoading = false,
        user = null,
        error = null;

  /// Copy with method for immutable updates
  AuthState copyWith({
    bool? isAuthenticated,
    bool? isLoading,
    dynamic user,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isLoading: isLoading ?? this.isLoading,
      user: user ?? this.user,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [isAuthenticated, isLoading, user, error];

  @override
  String toString() => 'AuthState(isAuthenticated: $isAuthenticated, isLoading: $isLoading, user: $user, error: $error)';
}
