import 'package:flutter/material.dart';
import '../app_state.dart';

/// Selectors for UI state
class UiSelectors {
  /// Get theme mode
  static ThemeMode getThemeMode(AppState state) => state.uiState.themeMode;

  /// Get locale
  static Locale getLocale(AppState state) => state.uiState.locale;

  /// Get language code
  static String getLanguageCode(AppState state) => state.uiState.locale.languageCode;
}
