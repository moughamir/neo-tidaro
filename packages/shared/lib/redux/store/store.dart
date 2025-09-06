import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:redux/redux.dart';

import '../app_state.dart';
import '../middleware/logging_middleware.dart';
import '../middleware/dashboard_middleware.dart';
import '../middleware/housekeeping_middleware.dart';
import '../reducers/app_reducer.dart';

/// Creates and configures the Redux store
Store<AppState> createStore({bool enableLogging = kDebugMode}) {
  final List<Middleware<AppState>> middleware = [];

  // Add dashboard middleware
  middleware.addAll(createDashboardMiddleware());

  // Add housekeeping middleware
  middleware.addAll(createHousekeepingMiddleware());

  // Add logging middleware in debug mode
  if (enableLogging) {
    middleware.addAll(createLoggingMiddleware<AppState>());
  }

  return Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: middleware,
  );
}
