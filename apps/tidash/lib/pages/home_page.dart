import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'auth/login_page.dart';
import 'dashboard/dashboard_page.dart';

/// TiDash home page that handles authentication state routing
/// 
/// This component follows separation of concerns by only handling
/// authentication state routing logic, delegating to dedicated
/// auth and dashboard components.
class TiDashHome extends StatelessWidget {
  const TiDashHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      converter: (Store<AppState> store) => store.state.authState,
      onInit: (Store<AppState> store) {
        // Check authentication status on app start
        store.dispatch(const CheckAuthStatusAction());
      },
      builder: (BuildContext context, AuthState authState) {
        if (authState.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authState.isAuthenticated) {
          return const DashboardPage();
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
