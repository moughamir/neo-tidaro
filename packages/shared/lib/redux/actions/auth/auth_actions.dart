/// Authentication Actions
abstract class AuthAction<T> {}

/// Redux actions for authentication
class AuthActions {
  // Sign in actions
  static const String signInRequest = 'AUTH_SIGN_IN_REQUEST';
  static const String signInSuccess = 'AUTH_SIGN_IN_SUCCESS';
  static const String signInFailure = 'AUTH_SIGN_IN_FAILURE';

  // Sign up actions
  static const String signUpRequest = 'AUTH_SIGN_UP_REQUEST';
  static const String signUpSuccess = 'AUTH_SIGN_UP_SUCCESS';
  static const String signUpFailure = 'AUTH_SIGN_UP_FAILURE';

  // Sign out actions
  static const String signOutRequest = 'AUTH_SIGN_OUT_REQUEST';
  static const String signOutSuccess = 'AUTH_SIGN_OUT_SUCCESS';
  static const String signOutFailure = 'AUTH_SIGN_OUT_FAILURE';

  // Password reset actions
  static const String resetPasswordRequest = 'AUTH_RESET_PASSWORD_REQUEST';
  static const String resetPasswordSuccess = 'AUTH_RESET_PASSWORD_SUCCESS';
  static const String resetPasswordFailure = 'AUTH_RESET_PASSWORD_FAILURE';

  // User state actions
  static const String userChanged = 'AUTH_USER_CHANGED';
  static const String checkAuthStatus = 'AUTH_CHECK_STATUS';
  static const String clearError = 'AUTH_CLEAR_ERROR';
}




/// Action classes

