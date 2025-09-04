import '../app_state.dart';

/// Selectors for UI state
class UiSelectors {
  /// Get loading status
  static bool isLoading(AppState state) => state.uiState.isLoading;

  /// Get counter value
  static int getCounter(AppState state) => state.uiState.counter;

  /// Get UI error
  static String? getError(AppState state) => state.uiState.error;

  /// Get success message
  static String? getSuccessMessage(AppState state) => state.uiState.successMessage;

  /// Check if UI has error
  static bool hasError(AppState state) => state.uiState.error != null;

  /// Check if UI has success message
  static bool hasSuccessMessage(AppState state) => state.uiState.successMessage != null;
}
