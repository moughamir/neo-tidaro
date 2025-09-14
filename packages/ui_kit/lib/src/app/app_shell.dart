import 'package:flutter/material.dart';

import 'package:ui_kit/src/design_system/design_system.dart';
import 'package:languist/l10n/gen/intl_localizations.dart';

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

      debugShowCheckedModeBanner: false,
      theme: KuiTheme.light(),
      darkTheme: KuiTheme.dark(),
      themeMode: themeMode,
      // Localization wiring via Languist
      localizationsDelegates: IntlLocalizations.localizationsDelegates,
      supportedLocales: IntlLocalizations.supportedLocales,

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
