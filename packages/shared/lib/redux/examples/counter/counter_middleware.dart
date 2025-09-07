import 'package:redux/redux.dart';
import '../../core/base_action.dart';
import '../../core/base_middleware.dart';
import 'counter_actions.dart';
import 'counter_state.dart';

/// Concrete async middleware that
/// - dispatches REQUEST
/// - executes async action
/// - dispatches SUCCESS/FAILURE via BaseAsyncAction handling
class CounterAsyncMiddleware extends AsyncMiddleware<CounterState> {
  const CounterAsyncMiddleware();

  @override
  void call(Store<CounterState> store, BaseAction action, NextDispatcher next) {
    // Always forward the action first
    next(action);

    if (action is IncrementAsyncAction) {
      // Dispatch REQUEST so reducers can set loading
      store.dispatch(ActionCreators.request(IncrementAsyncAction.baseType));
      // Then execute and emit SUCCESS/FAILURE
      handleAsync(store, action);
    }
  }
}
