import 'package:redux/redux.dart';

import '../app_state.dart';
import '../middleware/logging_middleware.dart';
import '../reducers/app_reducer.dart';

/// Creates and configures the Redux store
Store<AppState> createStore({bool enableLogging = false}) {
  final List<Middleware<AppState>> middleware = [];

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
