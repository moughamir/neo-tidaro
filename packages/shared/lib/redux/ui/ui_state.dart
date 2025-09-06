import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// UI state for managing application-wide UI concerns
class UiState extends Equatable {
  const UiState({
    required this.themeMode,
    required this.locale,
  });

  final ThemeMode themeMode;
  final Locale locale;

  /// Initial state factory
  const UiState.initial()
      : themeMode = ThemeMode.system,
        locale = const Locale('en');

  /// Copy with method for immutable updates
  UiState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
  }) {
    return UiState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];

  @override
  String toString() => 'UiState(themeMode: $themeMode, locale: $locale)';
}
