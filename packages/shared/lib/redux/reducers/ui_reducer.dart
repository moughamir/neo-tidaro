import 'package:flutter/material.dart';
import 'ui_actions.dart';
import 'ui_state.dart';

/// Reducer for UI state following Single Responsibility Principle
UiState uiReducer(UiState state, dynamic action) {
  // Theme management
  if (action is ChangeThemeModeAction) {
    return state.copyWith(themeMode: action.themeMode);
  }

  if (action is ToggleThemeModeAction) {
    final ThemeMode newThemeMode = _getNextThemeMode(state.themeMode);
    return state.copyWith(themeMode: newThemeMode);
  }

  // Locale management
  if (action is ChangeLocaleAction) {
    return state.copyWith(locale: action.locale);
  }

  if (action is ChangeLanguageAction) {
    return state.copyWith(locale: Locale(action.languageCode));
  }

  return state;
}

/// Helper function to determine next theme mode (DRY principle)
ThemeMode _getNextThemeMode(ThemeMode current) {
  switch (current) {
    case ThemeMode.light:
      return ThemeMode.dark;
    case ThemeMode.dark:
      return ThemeMode.system;
    case ThemeMode.system:
      return ThemeMode.light;
  }
}
