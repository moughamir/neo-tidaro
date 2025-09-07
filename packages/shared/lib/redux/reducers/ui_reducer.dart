import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import '../actions/ui_actions.dart';
import '../states/ui_state.dart';

/// UI reducer following Clean Architecture and functional programming principles
class UiReducer extends BaseReducer<UiState> {
  @override
  UiState reduce(UiState state, BaseAction action) {
    return switch (action.type) {
      UiActionTypes.changeThemeMode => _handleChangeTheme(state, action),
      UiActionTypes.toggleThemeMode => _handleToggleTheme(state),
      UiActionTypes.changeLocale => _handleChangeLocale(state, action),
      UiActionTypes.changeLanguage => _handleChangeLanguage(state, action),
      UiActionTypes.showSnackBar => _handleShowSnackBar(state, action),
      UiActionTypes.hideSnackBar => _handleHideSnackBar(state),
      UiActionTypes.setLoading => _handleSetLoading(state, action),
      _ => state,
    };
  }

  /// Handle theme change
  UiState _handleChangeTheme(UiState state, BaseAction action) {
    if (action is! ChangeThemeModeAction) return state;
    return state.copyWith(themeMode: action.themeMode);
  }

  /// Handle theme toggle
  UiState _handleToggleTheme(UiState state) {
    final ThemeMode newThemeMode = _getNextThemeMode(state.themeMode);
    return state.copyWith(themeMode: newThemeMode);
  }

  /// Handle locale change
  UiState _handleChangeLocale(UiState state, BaseAction action) {
    if (action is! ChangeLocaleAction) return state;
    return state.copyWith(locale: action.locale);
  }

  /// Handle language change
  UiState _handleChangeLanguage(UiState state, BaseAction action) {
    if (action is! ChangeLanguageAction) return state;
    return state.copyWith(locale: Locale(action.languageCode));
  }

  /// Handle show snack bar
  UiState _handleShowSnackBar(UiState state, BaseAction action) {
    if (action is! ShowSnackBarAction) return state;
    final snackBarMessage = SnackBarMessage(
      message: action.message,
      type: action.snackBarType,
      duration: action.duration,
    );
    return state.copyWith(snackBarMessage: Some(snackBarMessage));
  }

  /// Handle hide snack bar
  UiState _handleHideSnackBar(UiState state) {
    return state.copyWith(snackBarMessage: const None());
  }

  /// Handle set loading
  UiState _handleSetLoading(UiState state, BaseAction action) {
    if (action is! SetLoadingAction) return state;
    final updatedLoadingStates = Map<String, bool>.from(state.loadingStates);
    final key = action.loadingKey ?? 'default';
    updatedLoadingStates[key] = action.isLoading;
    return state.copyWith(loadingStates: updatedLoadingStates);
  }

  /// Helper function to determine next theme mode (DRY principle)
  ThemeMode _getNextThemeMode(ThemeMode current) {
    return switch (current) {
      ThemeMode.light => ThemeMode.dark,
      ThemeMode.dark => ThemeMode.system,
      ThemeMode.system => ThemeMode.light,
    };
  }
}

/// UI reducer instance
final uiReducer = UiReducer();
