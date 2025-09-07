import '../../redux.dart';

Store<CounterState> createCounterStore({bool withLogging = true}) {
  final reducer = const CounterReducer();
  final middleware = <BaseMiddleware<CounterState>>[
    const CounterAsyncMiddleware(),
    if (withLogging) const LoggingMiddleware<CounterState>(),
  ];

  return Store<CounterState>(
    (state, action) => reducer.reduce(state, action as BaseAction),
    initialState: CounterState.initial,
    middleware: middleware
        .map((m) => (Store<CounterState> store, dynamic action, NextDispatcher next) {
              m.call(store, action as BaseAction, next);
            })
        .toList(),
  );
}
