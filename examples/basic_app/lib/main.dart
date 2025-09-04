import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  runApp(const BasicAppExample());
}

class BasicAppExample extends StatelessWidget {
  const BasicAppExample({super.key});

  @override
  Widget build(BuildContext context) {
    // Create Redux store
    final Store<AppState> store = createStore(enableLogging: true);

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Basic App Example',
        localizationsDelegates: Languist.localizationsDelegates,
        supportedLocales: Languist.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const ExampleHomePage(),
      ),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final IntlLocalizations l10n = Languist.of(context);

    return StoreConnector<AppState, int>(
      converter: (store) => UiSelectors.getCounter(store.state),
      builder: (context, counter) {
        return Scaffold(
          appBar: AppBar(
            title: Text('${l10n.appTitle} - Example'),
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // UI Kit Components Showcase
                Text(
                  'UI Kit Components',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                
                // Primary Button Example
                PrimaryButton(
                  text: 'Primary Button',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Primary button pressed!')),
                    );
                  },
                ),
                const SizedBox(height: 16),

                // Glassy Card Example
                GlassyCard(
                  title: 'Glassy Card Example',
                  subtitle: 'This showcases the glassy card component',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Counter: $counter'),
                        const SizedBox(height: 8),
                        Text(l10n.minutesAgo(counter)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Info Card Example
                InfoCard(
                  title: 'Info Card',
                  content: 'This demonstrates the info card component from the UI Kit.',
                  icon: Icons.info,
                ),
                const SizedBox(height: 16),

                // Loading Indicator Example
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Loading Indicator Example'),
                        SizedBox(height: 8),
                        LoadingIndicator(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Redux State Management Example
                Text(
                  'Redux State Management',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Current Counter: $counter'),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            StoreConnector<AppState, VoidCallback>(
                              converter: (store) => () => store.dispatch(IncrementCounterAction()),
                              builder: (context, callback) => ElevatedButton(
                                onPressed: callback,
                                child: const Text('Increment'),
                              ),
                            ),
                            StoreConnector<AppState, VoidCallback>(
                              converter: (store) => () => store.dispatch(DecrementCounterAction()),
                              builder: (context, callback) => ElevatedButton(
                                onPressed: callback,
                                child: const Text('Decrement'),
                              ),
                            ),
                            StoreConnector<AppState, VoidCallback>(
                              converter: (store) => () => store.dispatch(ResetCounterAction()),
                              builder: (context, callback) => ElevatedButton(
                                onPressed: callback,
                                child: const Text('Reset'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Localization Example
                Text(
                  'Localization Examples',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${l10n.hello} - Simple greeting'),
                        Text('${l10n.helloUser('Developer')} - Parameterized greeting'),
                        Text('${l10n.justNow} - Time format'),
                        Text('${l10n.aMinuteAgo} - Time format'),
                        Text('${l10n.anHourAgo} - Time format'),
                        Text('${l10n.aDayAgo} - Time format'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
