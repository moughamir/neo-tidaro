import 'package:flutter/material.dart';
import 'package:languist/l10n/gen/intl_localizations.dart';

/// Common authentication form validators with localized messages.
class AuthValidators {
  const AuthValidators._();

  /// Required field validator
  static String? Function(String?) required(IntlLocalizations l10n) {
    return (String? value) =>
        (value == null || value.isEmpty) ? l10n.fieldRequired : null;
  }

  /// Email validator with a basic RFC-like pattern
  static String? Function(String?) email(IntlLocalizations l10n) {
    final RegExp pattern = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,}$');
    return (String? value) {
      if (value == null || value.isEmpty) return l10n.fieldRequired;
      if (!pattern.hasMatch(value)) return l10n.invalidEmail;
      return null;
    };
  }

  /// Minimum length validator
  static String? Function(String?) minLength(
    IntlLocalizations l10n,
    int min, {
    String? Function(IntlLocalizations l10n)? message,
  }) {
    return (String? value) {
      if (value == null || value.isEmpty) return l10n.fieldRequired;
      if (value.length < min) {
        return message?.call(l10n) ?? l10n.passwordTooShort;
      }
      return null;
    };
  }

  /// Confirm password validator compares to [original]
  static String? Function(String?) confirmPassword(
    IntlLocalizations l10n,
    TextEditingController original,
  ) {
    return (String? value) {
      if (value == null || value.isEmpty) return l10n.fieldRequired;
      if (value != original.text) return l10n.passwordsDontMatch;
      return null;
    };
  }
}
