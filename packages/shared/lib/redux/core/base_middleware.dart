import 'package:redux/redux.dart';
import 'base_action.dart';
import 'base_state.dart';

/// Base middleware interface following SOLID principles
/// All Redux middleware must implement this interface
abstract class BaseMiddleware<S extends BaseState> {
  const BaseMiddleware();

  /// Process action and optionally dispatch new actions
  void call(Store<S> store, BaseAction action, NextDispatcher next);

  /// Compose with another middleware
  BaseMiddleware<S> compose(BaseMiddleware<S> other) {
    return _ComposedMiddleware([this, other]);
  }
}

/// Async middleware for handling side effects
abstract class AsyncMiddleware<S extends BaseState> extends BaseMiddleware<S> {
  const AsyncMiddleware();

  @override
  void call(Store<S> store, BaseAction action, NextDispatcher next) {
    // Always pass the action through first
    next(action);

    // Handle async operations
    if (action is BaseAsyncAction) {
      handleAsync(store, action);
    }
  }

  /// Handle async action with functional programming
  Future<void> handleAsync(Store<S> store, BaseAsyncAction action) async {
    final result = await action.execute();

    result.fold(
      (error) => store.dispatch(ActionCreators.failure(action.type, error)),
      (data) => store.dispatch(ActionCreators.success(action.type, data)),
    );
  }
}

/// Logging middleware for debugging
class LoggingMiddleware<S extends BaseState> extends BaseMiddleware<S> {
  const LoggingMiddleware({this.logger});

  final void Function(String message)? logger;

  @override
  void call(Store<S> store, BaseAction action, NextDispatcher next) {
    final message = 'Action: ${action.type}, Payload: ${action.payload}';
    logger?.call(message) ?? print(message);

    next(action);

    final newState = store.state;
    final stateMessage = 'New State: ${newState.stateType}';
    logger?.call(stateMessage) ?? print(stateMessage);
  }
}

/// Error handling middleware
class ErrorHandlingMiddleware<S extends BaseState> extends BaseMiddleware<S> {
  const ErrorHandlingMiddleware({
    this.onError,
    this.shouldCatch = true,
    this.rethrowAfterDispatch = false,
  });

  final void Function(Exception error, BaseAction action)? onError;
  final bool shouldCatch;
  final bool rethrowAfterDispatch;

  @override
  void call(Store<S> store, BaseAction action, NextDispatcher next) {
    if (!shouldCatch) {
      next(action);
      return;
    }

    try {
      next(action);
    } catch (error) {
      final exception = error is Exception
          ? error
          : Exception(error.toString());
      onError?.call(exception, action);

      // Dispatch error action
      store.dispatch(ActionCreators.failure(action.type, exception));

      if (rethrowAfterDispatch) {
        // Rethrow to allow upper layers or devtools to capture
        // ignore: only_throw_errors
        throw exception;
      }
    }
  }
}

/// Throttling middleware to prevent rapid dispatches
class ThrottlingMiddleware<S extends BaseState> extends BaseMiddleware<S> {
  ThrottlingMiddleware({required this.duration, this.actionTypes = const []})
    : _lastDispatch = {};

  final Duration duration;
  final List<String> actionTypes;
  final Map<String, DateTime> _lastDispatch;

  @override
  void call(Store<S> store, BaseAction action, NextDispatcher next) {
    // If no specific action types, throttle all
    final shouldThrottle =
        actionTypes.isEmpty || actionTypes.contains(action.type);

    if (!shouldThrottle) {
      next(action);
      return;
    }

    final now = DateTime.now();
    final lastTime = _lastDispatch[action.type];

    if (lastTime == null || now.difference(lastTime) >= duration) {
      _lastDispatch[action.type] = now;
      next(action);
    }
    // Ignore if within throttle period
  }
}

/// Middleware utilities following DRY principles
class MiddlewareUtils {
  const MiddlewareUtils._();

  /// Create middleware from function
  static BaseMiddleware<S> create<S extends BaseState>(
    void Function(Store<S> store, BaseAction action, NextDispatcher next)
    middleware,
  ) {
    return _FunctionMiddleware(middleware);
  }

  /// Combine multiple middleware
  static BaseMiddleware<S> combine<S extends BaseState>(
    List<BaseMiddleware<S>> middleware,
  ) {
    return _ComposedMiddleware(middleware);
  }

  /// Create conditional middleware
  static BaseMiddleware<S> conditional<S extends BaseState>(
    bool Function(BaseAction action) condition,
    BaseMiddleware<S> middleware,
  ) {
    return _ConditionalMiddleware(condition, middleware);
  }

  /// Create action type filter middleware
  static BaseMiddleware<S> forActionTypes<S extends BaseState>(
    List<String> actionTypes,
    BaseMiddleware<S> middleware,
  ) {
    return conditional<S>(
      (action) => actionTypes.contains(action.type),
      middleware,
    );
  }
}

/// Internal implementations

class _FunctionMiddleware<S extends BaseState> extends BaseMiddleware<S> {
  const _FunctionMiddleware(this.middleware);

  final void Function(Store<S> store, BaseAction action, NextDispatcher next)
  middleware;

  @override
  void call(Store<S> store, BaseAction action, NextDispatcher next) {
    middleware(store, action, next);
  }
}

class _ComposedMiddleware<S extends BaseState> extends BaseMiddleware<S> {
  const _ComposedMiddleware(this.middleware);

  final List<BaseMiddleware<S>> middleware;

  @override
  void call(Store<S> store, BaseAction action, NextDispatcher next) {
    void executeMiddleware(int index) {
      if (index >= middleware.length) {
        next(action);
        return;
      }

      middleware[index].call(
        store,
        action,
        (_) => executeMiddleware(index + 1),
      );
    }

    executeMiddleware(0);
  }
}

class _ConditionalMiddleware<S extends BaseState> extends BaseMiddleware<S> {
  const _ConditionalMiddleware(this.condition, this.middleware);

  final bool Function(BaseAction action) condition;
  final BaseMiddleware<S> middleware;

  @override
  void call(Store<S> store, BaseAction action, NextDispatcher next) {
    if (condition(action)) {
      middleware.call(store, action, next);
    } else {
      next(action);
    }
  }
}
