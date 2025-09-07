import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import '../actions/auth_actions.dart';

/// Authentication state following functional programming patterns
class AuthState extends BaseAsyncState<AuthUser> {
  const AuthState({
    required super.isLoading,
    required super.data,
    required super.error,
    required this.isAuthenticated,
    required this.authToken,
  });

  final bool isAuthenticated;
  final Option<String> authToken;

  /// Initial state factory
  factory AuthState.initial() {
    return const AuthState(
      isLoading: false,
      data: None(),
      error: None(),
      isAuthenticated: false,
      authToken: None(),
    );
  }

  /// Loading state factory
  factory AuthState.loading() {
    return const AuthState(
      isLoading: true,
      data: None(),
      error: None(),
      isAuthenticated: false,
      authToken: None(),
    );
  }

  /// Authenticated state factory
  factory AuthState.authenticated(AuthUser user, String token) {
    return AuthState(
      isLoading: false,
      data: Some(user),
      error: const None(),
      isAuthenticated: true,
      authToken: Some(token),
    );
  }

  /// Error state factory
  factory AuthState.error(Exception error) {
    return AuthState(
      isLoading: false,
      data: const None(),
      error: Some(error),
      isAuthenticated: false,
      authToken: const None(),
    );
  }

  /// Copy with method for immutable updates
  AuthState copyWith({
    bool? isLoading,
    Option<AuthUser>? data,
    Option<Exception>? error,
    bool? isAuthenticated,
    Option<String>? authToken,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      authToken: authToken ?? this.authToken,
    );
  }

  @override
  String get stateType => 'AuthState';

  @override
  List<Object?> get props => [
    isLoading,
    data,
    error,
    isAuthenticated,
    authToken,
  ];

  @override
  String toString() => 'AuthState('
      'isLoading: $isLoading, '
      'isAuthenticated: $isAuthenticated, '
      'hasData: ${data.isSome()}, '
      'hasError: ${error.isSome()}'
      ')';
}
