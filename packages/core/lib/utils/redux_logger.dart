import 'package:shared/redux/redux.dart';
import 'logger.dart';

/// Adapters to use CoreLogger with shared Redux middleware without
/// introducing a dependency from `shared` -> `core`.
///
/// Usage in your Store setup:
/// final middleware = <BaseMiddleware<AppState>>[
///   reduxLoggingMiddleware<AppState>(),
///   reduxErrorHandlingMiddleware<AppState>(),
/// ];

/// Logging middleware wired to CoreLogger.
LoggingMiddleware<S> reduxLoggingMiddleware<S extends BaseState>() {
  return LoggingMiddleware<S>(
    logger: (String message) => CoreLogger.debug(message),
  );
}

/// Error-handling middleware wired to CoreLogger.
ErrorHandlingMiddleware<S> reduxErrorHandlingMiddleware<S extends BaseState>({
  bool shouldCatch = true,
}) {
  return ErrorHandlingMiddleware<S>(
    shouldCatch: shouldCatch,
    onError: (Exception error, BaseAction action) {
      CoreLogger.error(
        'Redux error on action ${action.type}: ${error.toString()}',
        error: error,
      );
    },
  );
}
