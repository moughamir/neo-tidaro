import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';

import 'package:tidaro/pages/home/page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create Redux store
    final Store<AppState> store = createStore(enableLogging: true);

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'TiDaro',
        localizationsDelegates: Languist.localizationsDelegates,
        supportedLocales: Languist.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
