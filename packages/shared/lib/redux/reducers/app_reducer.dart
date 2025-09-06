import 'package:shared/redux/housekeeping/housekeeping.dart';

import '../app_state.dart';
import '../auth/auth_reducer.dart';
import '../ui/ui_reducer.dart';
import 'dashboard_reducer.dart';

/// Main app reducer that combines all feature reducers
AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
    dashboardState: dashboardReducer(state.dashboardState, action),
    uiState: uiReducer(state.uiState, action),
    housekeepingState: housekeepingReducer(state.housekeepingState, action),
  );
}
