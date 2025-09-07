import '../app_state.dart';
import 'auth_reducer.dart';
import 'booking_reducer.dart';
import 'dashboard_reducer.dart';
import 'cleaner_reducer.dart';
import 'ui_reducer.dart';

/// Main app reducer that combines all feature reducers
AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer.reduce(state.authState, action),
    bookingState: bookingReducer(state.bookingState, action),
    dashboardState: dashboardReducer.reduce(state.dashboardState, action),
    cleanerState: cleanerReducer(state.cleanerState, action),
    uiState: uiReducer.reduce(state.uiState, action),
  );
}
