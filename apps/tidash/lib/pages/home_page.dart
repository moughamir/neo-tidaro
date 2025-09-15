import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'auth/login_page.dart';
import 'main/main_layout.dart';

/// TiDash home page that handles authentication state routing
///
/// This component follows separation of concerns by only handling
/// authentication state routing logic, delegating to dedicated
/// auth and dashboard components.
class TiDashHome extends StatefulWidget {
  const TiDashHome({super.key});

  @override
  State<TiDashHome> createState() => _TiDashHomeState();
}

class _TiDashHomeState extends State<TiDashHome> {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      converter: (Store<AppState> store) => store.state.authState,
      onInit: (Store<AppState> store) {
        // Check authentication status on app start
        store.dispatch(const CheckAuthStatusAction());
      },
      onDidChange: (AuthState? previousState, AuthState newState) {
        // Handle authentication state changes for navigation
        _handleAuthStateChange(context, previousState, newState);
      },
      builder: (BuildContext context, AuthState authState) {
        if (authState.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authState.isAuthenticated) {
          return const MainLayout();
        } else {
          return const LoginPage();
        }
      },
    );
  }

  void _handleAuthStateChange(
    BuildContext context,
    AuthState? previousState,
    AuthState newState,
  ) {
    // Handle successful authentication
    if (previousState != null &&
        !previousState.isAuthenticated &&
        newState.isAuthenticated) {
      // Clear any existing routes and navigate to main layout
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/',
        (Route<dynamic> route) => false,
      );
    }

    // Handle logout
    if (previousState != null &&
        previousState.isAuthenticated &&
        !newState.isAuthenticated) {
      // Clear any existing routes and navigate to login
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/login',
        (Route<dynamic> route) => false,
      );
    }

    // Handle authentication errors
    if (newState.error.isSome() && previousState?.error != newState.error) {
      newState.error.fold(
        () => null,
        (Exception error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.toString()),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          );
        },
      );
    }
  }
}
