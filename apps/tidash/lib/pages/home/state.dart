import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:tidash/pages/home/page.dart';

class TiDashboardHomePageState extends State<TiDashboardHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final IntlLocalizations l10n = Languist.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('${l10n.appTitle} ${l10n.dashboard}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(l10n.hello),
            const SizedBox(height: 20),
            Text(l10n.helloUser('Admin')),
            const SizedBox(height: 20),
            Text(l10n.fromNow(l10n.minutesAgo(_counter))),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
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
              child: Text(l10n.settings),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: l10n.incrementAction,
        child: const Icon(Icons.add),
      ),
    );
  }
}
