import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import '../pages/home_page.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:core/core.dart';

class TiDashApp extends StatelessWidget {
  const TiDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: createStore(
        enableLogging: true,
        logger: (String message) => CoreLogger.debug(message, tag: 'REDUX', showLevel: true),
        onError: (Exception error, BaseAction action) => CoreLogger.error(
          'Redux error on action ${action.type}',
          error: error,
          tag: 'REDUX',
          showLevel: true,
        ),
        catchErrors: true,
      ),
      child: const AppShell(
        title: 'TiDash',
        home: TiDashHome(),
        themeMode: ThemeMode.system,
      ),
    );
  }
}
