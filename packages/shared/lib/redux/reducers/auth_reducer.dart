import 'package:domain/domain.dart';
import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import '../actions/auth_actions.dart';
import '../states/auth_state.dart';

/// Authentication reducer following functional programming patterns
class AuthReducer extends BaseAsyncReducer<AuthState, User> {
  const AuthReducer();

  @override
  AuthState reduce(AuthState state, BaseAction action) {
    return switch (action.type) {
      // Sign in flow
      AuthActionTypes.signIn => handleAsync(
        state,
        action,
        AuthActionTypes.signIn,
      ),

      // Sign up flow
      AuthActionTypes.signUp => handleAsync(
        state,
        action,
        AuthActionTypes.signUp,
      ),

      // Sign out flow
      AuthActionTypes.signOut => handleAsync(
        state,
        action,
        AuthActionTypes.signOut,
      ),

      // Reset password flow
      AuthActionTypes.resetPassword => handleAsync(
        state,
        action,
        AuthActionTypes.resetPassword,
      ),

      // Social sign in flow
      AuthActionTypes.socialSignIn => handleAsync(
        state,
        action,
        AuthActionTypes.socialSignIn,
      ),

      // Phone sign in flow
      AuthActionTypes.phoneSignIn => handleAsync(
        state,
        action,
        AuthActionTypes.phoneSignIn,
      ),

      // Clear error
      AuthActionTypes.clearError => state.copyWith(error: const None()),

      // Check auth status
      AuthActionTypes.checkAuthStatus => _handleCheckAuthStatus(state, action),

      // Default case
      _ => state,
    };
  }

  @override
  AuthState createLoadingState() => AuthState.loading();

  @override
  AuthState createSuccessState(User data) {
    // For successful authentication, we need a token
    // This should be handled by middleware to provide the token
    return AuthState.authenticated(data, 'token_from_middleware');
  }

  @override
  AuthState createErrorState(Exception error) => AuthState.error(error);

  /// Handle check auth status action
  AuthState _handleCheckAuthStatus(AuthState state, BaseAction action) {
    // This is a synchronous action that doesn't change loading state
    // The actual auth check should be handled by middleware
    return state;
  }
}

/// Create auth reducer instance
final authReducer = const AuthReducer();
