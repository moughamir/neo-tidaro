import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import '../pages/home_page.dart';
import 'package:ui_kit/ui_kit.dart';

class TiDashApp extends StatelessWidget {
  const TiDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: createStore(),
      child: const AppShell(
        title: 'TiDash',
        home: TiDashHome(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
