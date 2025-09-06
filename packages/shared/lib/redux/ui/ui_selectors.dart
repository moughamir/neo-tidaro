import 'package:flutter/material.dart';
import '../app_state.dart';
import 'ui_state.dart';

/// Selectors for UI state
class UiSelectors {
  /// Get the UI state from app state
  static UiState getUiState(AppState state) => state.uiState;

  /// Get theme mode
  static ThemeMode getThemeMode(AppState state) => state.uiState.themeMode;

  /// Get locale
  static Locale getLocale(AppState state) => state.uiState.locale;

  /// Get language code from locale
  static String getLanguageCode(AppState state) => state.uiState.locale.languageCode;

  /// Get country code from locale (if available)
  static String? getCountryCode(AppState state) => state.uiState.locale.countryCode;

  /// Check if app is in dark mode
  static bool isDarkMode(AppState state) => state.uiState.themeMode == ThemeMode.dark;

  /// Check if app is in light mode
  static bool isLightMode(AppState state) => state.uiState.themeMode == ThemeMode.light;

  /// Check if app is using system theme
  static bool isSystemTheme(AppState state) => state.uiState.themeMode == ThemeMode.system;

}
