import '../actions/auth_actions.dart';
import '../actions/dashboard_auth_actions.dart';
import '../auth/auth_state.dart';

/// Reducer for authentication state
AuthState authReducer(AuthState state, dynamic action) {
  // Handle dashboard auth loading actions
  if (action is DashboardAuthLoadingAction) {
    return state.copyWith(
      isLoading: action.isLoading,
      error: action.isLoading ? null : state.error,
    );
  }

  // Handle dashboard auth success
  if (action is DashboardAuthSuccessAction) {
    return state.copyWith(
      isAuthenticated: true,
      isLoading: false,
      user: action.user,
      error: null,
    );
  }

  // Handle dashboard auth failure
  if (action is DashboardAuthFailureAction) {
    return state.copyWith(
      isAuthenticated: false,
      isLoading: false,
      error: action.error,
    );
  }

  // Handle dashboard logout
  if (action is DashboardLogoutAction) {
    return const AuthState.initial();
  }

  // Handle legacy auth actions
  if (action is LoginStartAction || action is SignUpStartAction || action is ResetPasswordStartAction) {
    return state.copyWith(
      isLoading: true,
      error: null,
    );
  }

  if (action is LoginSuccessAction || action is SignUpSuccessAction) {
    return state.copyWith(
      isAuthenticated: true,
      isLoading: false,
      user: action.user,
      error: null,
    );
  }

  if (action is LoginFailureAction || action is SignUpFailureAction || action is ResetPasswordFailureAction) {
    return state.copyWith(
      isAuthenticated: false,
      isLoading: false,
      user: null,
      error: action.error,
    );
  }

  if (action is ResetPasswordSuccessAction) {
    return state.copyWith(
      isLoading: false,
      error: null,
    );
  }

  if (action is LogoutAction) {
    return const AuthState.initial();
  }

  return state;
}
