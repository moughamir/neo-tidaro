import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

/// Base class for all UI actions
abstract class UiAction extends Equatable {
  const UiAction();
}


/// Action to change theme mode
class ChangeThemeModeAction extends UiAction {
  const ChangeThemeModeAction(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object?> get props => [themeMode];
}

/// Action to toggle theme mode
class ToggleThemeModeAction extends UiAction {
  const ToggleThemeModeAction();

  @override
  List<Object?> get props => [];
}

/// Action to change locale
class ChangeLocaleAction extends UiAction {
  const ChangeLocaleAction(this.locale);

  final Locale locale;

  @override
  List<Object?> get props => [locale];
}

/// Action to change locale by language code
class ChangeLanguageAction extends UiAction {
  const ChangeLanguageAction(this.languageCode);

  final String languageCode;

  @override
  List<Object?> get props => [languageCode];
}
