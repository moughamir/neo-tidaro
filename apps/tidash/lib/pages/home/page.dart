import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:tidash/pages/auth/login_page.dart';
import 'package:tidash/pages/main/main_layout.dart';

class TiDashHome extends StatelessWidget {
  const TiDashHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      converter: (Store<AppState> store) => store.state.authState,
      onInit: (Store<AppState> store) {
        store.dispatch(const CheckAuthStatusAction());
      },
      builder: (BuildContext context, AuthState authState) {
        if (authState.isLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (authState.isAuthenticated) {
          return const MainLayout(); // CHANGED
        } else {
          return const LoginPage();
        }
      },
    );
  }
}
