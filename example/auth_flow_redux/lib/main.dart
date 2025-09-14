import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import 'screens/auth_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  dynamic ssi = SupabaseServiceInterface.init('url', 'anonKey');

  runApp(AuthFlowReduxApp());
}

class AuthFlowReduxApp extends StatelessWidget {
  AuthFlowReduxApp({super.key});

  // Create Redux store
  final Store<AppState> store = Store<AppState>(
    appReducer,
    initialState: AppState.initial(),
    middleware: [
      AuthMiddleware(SupabaseServiceInterface()).call,
      // Add more middleware as needed
    ],
  );

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Enhanced Auth Flow',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const AuthFlowRouter(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class AuthFlowRouter extends StatelessWidget {
  const AuthFlowRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, bool>(
      converter: (store) => store.state.authState.isAuthenticated,
      builder: (context, isAuthenticated) {
        if (isAuthenticated) {
          return const DashboardScreen();
        } else {
          return const AuthScreen();
        }
      },
    );
  }
}
