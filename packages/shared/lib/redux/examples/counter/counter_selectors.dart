import '../../core/base_selector.dart';
import 'counter_state.dart';

class CounterSelectors extends BaseSelector<CounterState> {
  const CounterSelectors();

  int getValue(CounterState state) => state.value;
  bool isLoading(CounterState state) => state.isLoading;
  String? getError(CounterState state) => state.error;
}
