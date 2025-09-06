import '../app_state.dart';
import 'auth_reducer.dart';
import 'ui_reducer.dart';
import 'dashboard_reducer.dart';

/// Main app reducer that combines all feature reducers
AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
    uiState: uiReducer(state.uiState, action),
    dashboardState: dashboardReducer(state.dashboardState, action),
  );
}
