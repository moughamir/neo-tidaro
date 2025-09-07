import 'package:flutter/material.dart';
import '../core/core.dart';

/// UI action types
class UiActionTypes {
  static const String changeThemeMode = 'UI_CHANGE_THEME_MODE';
  static const String toggleThemeMode = 'UI_TOGGLE_THEME_MODE';
  static const String changeLocale = 'UI_CHANGE_LOCALE';
  static const String changeLanguage = 'UI_CHANGE_LANGUAGE';
  static const String showSnackBar = 'UI_SHOW_SNACK_BAR';
  static const String hideSnackBar = 'UI_HIDE_SNACK_BAR';
  static const String setLoading = 'UI_SET_LOADING';
}

/// Action to change theme mode
class ChangeThemeModeAction extends BaseAction {
  const ChangeThemeModeAction(this.themeMode);

  final ThemeMode themeMode;

  @override
  String get type => UiActionTypes.changeThemeMode;

  @override
  ThemeMode get payload => themeMode;

  @override
  List<Object?> get props => [themeMode];
}

/// Action to toggle theme mode
class ToggleThemeModeAction extends BaseAction {
  const ToggleThemeModeAction();

  @override
  String get type => UiActionTypes.toggleThemeMode;

  @override
  List<Object?> get props => [];
}

/// Action to change locale
class ChangeLocaleAction extends BaseAction {
  const ChangeLocaleAction(this.locale);

  final Locale locale;

  @override
  String get type => UiActionTypes.changeLocale;

  @override
  Locale get payload => locale;

  @override
  List<Object?> get props => [locale];
}

/// Action to change locale by language code
class ChangeLanguageAction extends BaseAction {
  const ChangeLanguageAction(this.languageCode);

  final String languageCode;

  @override
  String get type => UiActionTypes.changeLanguage;

  @override
  String get payload => languageCode;

  @override
  List<Object?> get props => [languageCode];
}

/// Action to show snack bar
class ShowSnackBarAction extends BaseAction {
  const ShowSnackBarAction({
    required this.message,
    this.snackBarType = SnackBarType.info,
    this.duration,
  });

  final String message;
  final SnackBarType snackBarType;
  final Duration? duration;

  @override
  String get type => UiActionTypes.showSnackBar;

  @override
  Map<String, dynamic> get payload => {
    'message': message,
    'type': snackBarType.name,
    if (duration != null) 'duration': duration!.inMilliseconds,
  };

  @override
  List<Object?> get props => [message, snackBarType, duration];
}

/// Action to hide snack bar
class HideSnackBarAction extends BaseAction {
  const HideSnackBarAction();

  @override
  String get type => UiActionTypes.hideSnackBar;

  @override
  List<Object?> get props => [];
}

/// Action to set loading state
class SetLoadingAction extends BaseAction {
  const SetLoadingAction({
    required this.isLoading,
    this.loadingKey,
  });

  final bool isLoading;
  final String? loadingKey;

  @override
  String get type => UiActionTypes.setLoading;

  @override
  Map<String, dynamic> get payload => {
    'isLoading': isLoading,
    if (loadingKey != null) 'loadingKey': loadingKey!,
  };

  @override
  List<Object?> get props => [isLoading, loadingKey];
}

/// Snack bar types
enum SnackBarType {
  info,
  success,
  warning,
  error,
}
