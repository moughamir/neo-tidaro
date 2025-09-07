import 'package:flutter/material.dart';

import 'package:ui_kit/ui_kit.dart';

/// AppShell: A reusable MaterialApp wrapper that wires themes and localization.
class AppShell extends StatelessWidget {
  const AppShell({
    super.key,
    required this.title,
    required this.home,
    this.themeMode = ThemeMode.system,
    this.navigatorKey,
    this.routes,
    this.onGenerateRoute,
    this.builder,
    this.locale,
    this.onGenerateTitle,
  });

  final String title;
  final Widget home;
  final ThemeMode themeMode;
  final GlobalKey<NavigatorState>? navigatorKey;
  final Map<String, WidgetBuilder>? routes;
  final RouteFactory? onGenerateRoute;
  final TransitionBuilder? builder;
  final Locale? locale;
  final GenerateAppTitle? onGenerateTitle;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: title,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: navigatorKey,
      routes: routes ?? const <String, WidgetBuilder>{},
      onGenerateRoute: onGenerateRoute,
      builder: builder,
      locale: locale,
      onGenerateTitle: onGenerateTitle,
      home: home,
    );
  }
}
