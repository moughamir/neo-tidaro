import '../app_state.dart';

/// Selectors for authentication state
class AuthSelectors {
  /// Get authentication status
  static bool isAuthenticated(AppState state) => state.authState.isAuthenticated;

  /// Get loading status
  static bool isLoading(AppState state) => state.authState.isLoading;

  /// Get current user
  static dynamic getCurrentUser(AppState state) => state.authState.user;

  /// Get authentication error
  static String? getError(AppState state) => state.authState.error;

  /// Check if user has error
  static bool hasError(AppState state) => state.authState.error != null;
}
