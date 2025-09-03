// lib/shared/utils/extensions/string_extensions.dart

import 'package:flutter/widgets.dart';
import 'package:tidaro/l10n/app_localizations.dart';

/// Extension methods for [String] to provide common text manipulations.
extension StringExtensions on String {
  /// Capitalizes the first letter of the string.
  ///
  /// Example: `'hello world'.capitalize()` -> "Hello world"
  String capitalize() {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  /// Converts the string to Title Case.
  ///
  /// Example: `'hello world'.toTitleCase()` -> "Hello World"
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ')
        .map((word) => word.capitalize())
        .join(' ');
  }

  /// Treats the string as a localization key and retrieves the localized value.
  ///
  /// This provides a convenient way to access localized strings directly from a key.
  /// Example: `'helloUser'.toLocale(context, args: ['Odin'])`
  String tr(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (l10n == null) return this;

    // This is a simplified lookup. A real implementation might use reflection
    // or a map generated from the .arb files for better performance and safety.
    switch (this) {
      case 'appTitle':
        return l10n.appTitle;
      case 'settings':
        return l10n.settings;
      case 'hello':
        return l10n.hello;
      // Add other keys here
      default:
        return this; // Return the key if no match is found
    }
  }
}
