import 'package:flutter/material.dart';

import 'package:languist/languist.dart';
import 'package:shared/shared.dart';

import '../pages/auth/auth_wrapper.dart';
import '../pages/auth/login_page.dart';
import '../pages/auth/signup_page.dart';
import '../pages/dashboard/dashboard_page.dart';
import '../pages/bookings/bookings_page.dart';

class TiDashboard extends StatelessWidget {
  const TiDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final Store<AppState> store = createStore(enableLogging: true);

    return StoreProvider<AppState>(
      store: store,
      child: StoreConnector<AppState, UiState>(
        converter: (Store<AppState> store) => store.state.uiState,
        builder: (BuildContext context, UiState uiState) {
          return MaterialApp(
            title: 'TiDaro Dashboard',
            localizationsDelegates: Languist.localizationsDelegates,
            supportedLocales: Languist.supportedLocales,
            locale: uiState.locale,
            themeMode: uiState.themeMode,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6366F1), // Modern indigo
                brightness: Brightness.light,
              ),
              useMaterial3: true,
              cardTheme: const CardThemeData(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF6366F1),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
              cardTheme: const CardThemeData(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
            ),
            home: const AuthWrapper(),
            routes: <String, WidgetBuilder>{
              '/login': (BuildContext context) => const LoginPage(),
              '/signup': (BuildContext context) => const SignUpPage(),
              '/dashboard': (BuildContext context) => const DashboardPage(),
              '/bookings': (BuildContext context) => const BookingsPage(),
            },
          );
        },
      ),
    );
  }
}
