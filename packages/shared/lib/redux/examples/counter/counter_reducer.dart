import '../../core/base_action.dart';
import '../../core/base_reducer.dart';
import 'counter_actions.dart';
import 'counter_state.dart';

class CounterReducer extends BaseReducer<CounterState> {
  const CounterReducer();

  @override
  CounterState reduce(CounterState state, BaseAction action) {
    // Map-based handlers keep it readable and scalable
    final reducer = ReducerUtils.createReducer<CounterState>({
      IncrementAction.typeValue: (s, a) => s.copyWith(value: s.value + 1),
      DecrementAction.typeValue: (s, a) => s.copyWith(value: s.value - 1),
      // Async pattern via BaseReducer.handleAsyncAction
      '${IncrementAsyncAction.baseType}_REQUEST': (s, a) => s.copyWith(isLoading: true),
      '${IncrementAsyncAction.baseType}_SUCCESS': (s, a) {
        final data = (a as SuccessAction<int>).data;
        return s.copyWith(value: s.value + data, isLoading: false, error: null);
      },
      '${IncrementAsyncAction.baseType}_FAILURE': (s, a) {
        final error = (a as FailureAction).error;
        return s.copyWith(isLoading: false, error: error.toString());
      },
    });

    return reducer.reduce(state, action);
  }
}
