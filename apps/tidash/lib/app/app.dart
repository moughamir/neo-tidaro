import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import '../pages/auth/login_page.dart';
import '../pages/auth/signup_page.dart';
import '../pages/home_page.dart';

class TiDashApp extends StatelessWidget {
  const TiDashApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
      store: createStore(
        enableLogging: true,
        logger: (String message) =>
            CoreLogger.debug(message, tag: 'REDUX', showLevel: true),
        onError: (Exception error, BaseAction action) => CoreLogger.error(
          'Redux error on action ${action.type}',
          error: error,
          tag: 'REDUX',
          showLevel: true,
        ),
        catchErrors: true,
      ),
      child: AppShell(
        title: 'TiDash',
        home: const TiDashHome(),
        themeMode: ThemeMode.system,
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
        },
      ),
    );
  }
}
