import 'package:flutter_redux/flutter_redux.dart';
import 'package:shared/redux/app_state.dart';
import 'package:ui_kit/ui_kit.dart';

import '../pages/auth/login_page.dart';
import '../pages/auth/signup_page.dart';
import '../pages/home_page.dart';

class TiDashApp extends StatelessWidget {
  const TiDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreBuilder<AppState>(
      builder: (context, store) {
        return AppShell(
          title: 'TiDash',
          home: const TiDashHome(),
          theme: kuiTheme,
          themeMode: ThemeMode.system,
          routes: {
            '/login': (context) => const LoginPage(),
            '/signup': (context) => const SignUpPage(),
          },
        );
      },
    );
  }
}
