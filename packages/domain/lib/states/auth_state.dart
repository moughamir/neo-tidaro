import '../entities/entities.dart';
import '../enums/authentication_state_type.dart';

/// Domain-pure authentication state
class AuthState {
  final User? currentUser;
  final AuthSession? session;
  final AuthenticationStateType status;
  final bool isLoading;
  final String? error;

  const AuthState({
    this.currentUser,
    this.session,
    required this.status,
    required this.isLoading,
    this.error,
  });

  factory AuthState.initial() => const AuthState(
    status: AuthenticationStateType.unauthenticated,
    isLoading: false,
  );

  bool get isAuthenticated => status == AuthenticationStateType.authenticated;
}
