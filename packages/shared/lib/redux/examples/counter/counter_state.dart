import '../../core/base_state.dart';

class CounterState extends BaseState {
  const CounterState({
    this.value = 0,
    this.isLoading = false,
    this.error,
  });

  final int value;
  final bool isLoading;
  final String? error;

  CounterState copyWith({
    int? value,
    bool? isLoading,
    String? error,
  }) => CounterState(
        value: value ?? this.value,
        isLoading: isLoading ?? this.isLoading,
        error: error ?? this.error,
      );

  static const initial = CounterState();

  @override
  String get stateType => 'CounterState';

  @override
  List<Object?> get props => [value, isLoading, error];
}
