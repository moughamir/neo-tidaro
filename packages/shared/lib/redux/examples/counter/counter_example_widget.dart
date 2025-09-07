import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'counter.dart';

class CounterExampleApp extends StatelessWidget {
  const CounterExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    final store = createCounterStore();

    return StoreProvider<CounterState>(
      store: store,
      child: MaterialApp(
        title: 'Redux Counter Example',
        home: const CounterExamplePage(),
      ),
    );
  }
}

class CounterExamplePage extends StatelessWidget {
  const CounterExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Redux Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreConnector<CounterState, int>(
              converter: (store) => store.state.value,
              builder: (context, value) => Text('$value', style: Theme.of(context).textTheme.displayLarge),
            ),
            const SizedBox(height: 24),
            StoreConnector<CounterState, bool>(
              converter: (store) => store.state.isLoading,
              builder: (context, loading) => loading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: CircularProgressIndicator(),
                    )
                  : const SizedBox.shrink(),
            ),
            const SizedBox(height: 24),
            Wrap(
              spacing: 12,
              children: [
                ElevatedButton(
                  onPressed: () => StoreProvider.of<CounterState>(context).dispatch(const IncrementAction()),
                  child: const Text('Increment'),
                ),
                ElevatedButton(
                  onPressed: () => StoreProvider.of<CounterState>(context).dispatch(const DecrementAction()),
                  child: const Text('Decrement'),
                ),
                ElevatedButton(
                  onPressed: () => StoreProvider.of<CounterState>(context).dispatch(const IncrementAsyncAction(by: 1, delayMs: 600)),
                  child: const Text('Increment Async'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
