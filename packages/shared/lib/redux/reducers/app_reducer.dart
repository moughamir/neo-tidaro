import '../app_state.dart';
import 'auth_reducer.dart';
import 'dashboard_reducer.dart';

import 'ui_reducer.dart';

/// Main app reducer that combines all feature reducers
AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer.reduce(state.authState, action),
    dashboardState: dashboardReducer.reduce(state.dashboardState, action),
    uiState: uiReducer.reduce(state.uiState, action),
  );
}
