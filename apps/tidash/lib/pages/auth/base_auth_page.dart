import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

/// Base authentication page that handles common Redux connections and layout
abstract class BaseAuthPage extends StatelessWidget {
  const BaseAuthPage({super.key});

  /// Build the auth form content (login fields, signup fields, etc.)
  Widget buildAuthContent(BuildContext context, IntlLocalizations l10n);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return StoreConnector<AppState, UiState>(
      converter: (Store<AppState> store) => store.state.uiState,
      builder: (BuildContext context, UiState uiState) {
        return AuthLayout(
          backgroundImage: 'assets/images/orange.jpg',
          isDarkMode:
              uiState.themeMode == ThemeMode.dark ||
              (uiState.themeMode == ThemeMode.system &&
                  theme.brightness == Brightness.dark),
          currentLanguage: uiState.locale.languageCode,
          onThemeToggle: () {
            StoreProvider.of<AppState>(
              context,
              listen: false,
            ).dispatch(const ToggleThemeModeAction());
          },
          onLanguageChanged: (String language) {
            StoreProvider.of<AppState>(
              context,
              listen: false,
            ).dispatch(ChangeLanguageAction(language));
          },
          child: SingleChildScrollView(
            child: AuthCard(child: buildAuthContent(context, l10n)),
          ),
        );
      },
    );
  }
}
