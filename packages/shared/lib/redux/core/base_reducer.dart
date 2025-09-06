import 'base_action.dart';
import 'base_state.dart';

/// Base reducer interface following SOLID principles
/// All Redux reducers must implement this interface
abstract class BaseReducer<S extends BaseState> {
  const BaseReducer();

  /// Reduce action to new state
  S reduce(S state, BaseAction action);

  /// Handle async actions with functional programming
  S handleAsyncAction<T>(
    S state,
    BaseAction action,
    String actionType,
    S Function() onRequest,
    S Function(T data) onSuccess,
    S Function(Exception error) onFailure,
  ) {
    return switch (action.type) {
      '${actionType}_REQUEST' => onRequest(),
      '${actionType}_SUCCESS' =>
        action is SuccessAction<T> ? onSuccess(action.data) : state,
      '${actionType}_FAILURE' =>
        action is FailureAction ? onFailure(action.error) : state,
      _ => state,
    };
  }
}

/// Async state reducer with functional patterns
abstract class BaseAsyncReducer<S extends BaseAsyncState<T>, T>
    extends BaseReducer<S> {
  const BaseAsyncReducer();

  /// Create loading state
  S createLoadingState();

  /// Create success state with data
  S createSuccessState(T data);

  /// Create error state
  S createErrorState(Exception error);

  /// Handle async operations with Either pattern
  S handleAsync(S state, BaseAction action, String actionType) {
    return handleAsyncAction<T>(
      state,
      action,
      actionType,
      createLoadingState,
      createSuccessState,
      createErrorState,
    );
  }
}

/// Reducer utilities following DRY principles
class ReducerUtils {
  const ReducerUtils._();

  /// Combine multiple reducers
  static S combineReducers<S extends BaseState>(
    S state,
    BaseAction action,
    List<BaseReducer<S>> reducers,
  ) {
    return reducers.fold(state, (currentState, reducer) {
      return reducer.reduce(currentState, action);
    });
  }

  /// Create a reducer from a map of action handlers
  static BaseReducer<S> createReducer<S extends BaseState>(
    Map<String, S Function(S state, BaseAction action)> handlers,
  ) {
    return _MapBasedReducer(handlers);
  }
}

/// Internal map-based reducer implementation
class _MapBasedReducer<S extends BaseState> extends BaseReducer<S> {
  const _MapBasedReducer(this.handlers);

  final Map<String, S Function(S state, BaseAction action)> handlers;

  @override
  S reduce(S state, BaseAction action) {
    final handler = handlers[action.type];
    return handler?.call(state, action) ?? state;
  }
}
