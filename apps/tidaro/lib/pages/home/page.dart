import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final IntlLocalizations l10n = Languist.of(context);

    return StoreConnector<AppState, int>(
      converter: (Store<AppState> store) => UiSelectors.getCounter(store.state),
      builder: (BuildContext context, int counter) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(l10n.appTitle),
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: () {
                  // Show settings dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: Text(l10n.settings),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextButton(
                            onPressed: () {},
                            child: Text(l10n.themeSettings),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: Text(l10n.languageSettings),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text(l10n.ok),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Using simple localized string
                Text(l10n.hello),
                const SizedBox(height: 20),
                // Using localized string with parameter
                Text(l10n.helloUser('Flutter Developer')),
                const SizedBox(height: 20),
                // Using counter with localized time format
                Text(l10n.minutesAgo(counter)),
                Text(
                  '$counter',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                // Showcasing different time formats
                const SizedBox(height: 20),
                Text(l10n.justNow),
                Text(l10n.aMinuteAgo),
                Text(l10n.anHourAgo),
                Text(l10n.aDayAgo),
              ],
            ),
          ),
          floatingActionButton: StoreConnector<AppState, VoidCallback>(
            converter: (Store<AppState> store) {
              return () => store.dispatch(IncrementCounterAction());
            },
            builder: (BuildContext context, VoidCallback callback) {
              return FloatingActionButton(
                onPressed: callback,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              );
            },
          ),
        );
      },
    );
  }
}
