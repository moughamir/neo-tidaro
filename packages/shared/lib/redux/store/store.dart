import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:redux/redux.dart';

import '../app_state.dart';
import '../middleware/logging_middleware.dart';
import '../middleware/dashboard_middleware.dart';
// housekeeping_middleware.dart removed due to domain model conflicts
import '../reducers/app_reducer.dart';
import '../core/base_action.dart';

/// Creates and configures the Redux store
Store<AppState> createStore({
  bool enableLogging = kDebugMode,
  void Function(String message)? logger,
  void Function(Exception error, BaseAction action)? onError,
  bool catchErrors = true,
}) {
  final List<Middleware<AppState>> middleware = <Middleware<AppState>>[];

  // Add dashboard middleware
  middleware.addAll(createDashboardMiddleware());

  // housekeeping middleware removed due to domain model conflicts

  // Error handling (first to wrap downstream middleware)
  middleware.add((Store<AppState> store, dynamic action, NextDispatcher next) {
    if (!catchErrors) {
      next(action);
      return;
    }
    try {
      next(action);
    } catch (error) {
      final Exception ex = error is Exception
          ? error
          : Exception(error.toString());
      // Callback if provided
      if (onError != null && action is BaseAction) {
        onError(ex, action);
      }
      // Dispatch failure action if BaseAction
      if (action is BaseAction) {
        store.dispatch(ActionCreators.failure(action.type, ex));
      }
    }
  });

  // Add logging middleware in debug mode
  if (enableLogging) {
    middleware.addAll(createLoggingMiddleware<AppState>(logger: logger));
  }

  return Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: middleware,
  );
}
