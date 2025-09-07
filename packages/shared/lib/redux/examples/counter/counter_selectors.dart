import 'counter_state.dart';

class CounterSelectors {
  const CounterSelectors._();

  static int getValue(CounterState state) => state.value;
  static bool isLoading(CounterState state) => state.isLoading;
  static String? getError(CounterState state) => state.error;
}
