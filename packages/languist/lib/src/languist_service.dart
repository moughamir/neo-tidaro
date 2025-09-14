import 'package:flutter/widgets.dart';

// Import generated localizations file based on languist.yaml config
import 'package:languist/l10n/gen/intl_localizations.dart';

/// A service class to simplify access to IntlLocalizations.
///
/// This provides a single point of access to the localized strings,
/// making it easier to manage and use in your application.
class Languist {
  /// Returns the [IntlLocalizations] instance for the given [context].
  ///
  /// Throws an exception if the instance is not found.
  static IntlLocalizations of(BuildContext context) {
    final localizations = IntlLocalizations.of(context);
    return localizations;
  }

  /// List of supported locales
  static const supportedLocales = IntlLocalizations.supportedLocales;

  /// The localization delegates for the app
  static const localizationsDelegates =
      IntlLocalizations.localizationsDelegates;
}
