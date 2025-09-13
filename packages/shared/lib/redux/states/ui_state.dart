import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/redux/core/core.dart';

import '../actions/ui_actions.dart';

/// UI state following functional programming patterns
class UiState extends BaseState {
  const UiState({
    required this.themeMode,
    required this.locale,
    required this.snackBarMessage,
    required this.loadingStates,
  });

  final ThemeMode themeMode;
  final Locale locale;
  final Option<SnackBarMessage> snackBarMessage;
  final Map<String, bool> loadingStates;

  /// Initial state factory
  factory UiState.initial() {
    return const UiState(
      themeMode: ThemeMode.system,
      locale: Locale('en', 'US'),
      snackBarMessage: None(),
      loadingStates: {},
    );
  }

  /// Copy with method for immutable updates
  UiState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    Option<SnackBarMessage>? snackBarMessage,
    Map<String, bool>? loadingStates,
  }) {
    return UiState(
      themeMode: themeMode ?? this.themeMode,
      locale: locale ?? this.locale,
      snackBarMessage: snackBarMessage ?? this.snackBarMessage,
      loadingStates: loadingStates ?? Map.from(this.loadingStates),
    );
  }

  /// Check if a specific loading key is active
  bool isLoading([String? key]) {
    if (key == null) {
      return loadingStates.values.any((loading) => loading);
    }
    return loadingStates[key] ?? false;
  }

  /// Set loading state for a specific key
  UiState setLoading(String key, bool isLoading) {
    final newLoadingStates = Map<String, bool>.from(loadingStates);
    if (isLoading) {
      newLoadingStates[key] = true;
    } else {
      newLoadingStates.remove(key);
    }
    return copyWith(loadingStates: newLoadingStates);
  }

  @override
  String get stateType => 'UiState';

  @override
  List<Object?> get props => [
    themeMode,
    locale,
    snackBarMessage,
    loadingStates,
  ];

  @override
  String toString() =>
      'UiState('
      'themeMode: $themeMode, '
      'locale: $locale, '
      'hasSnackBar: ${snackBarMessage.isSome()}, '
      'loadingCount: ${loadingStates.length}'
      ')';
}

/// Snack bar message model
class SnackBarMessage {
  const SnackBarMessage({
    required this.message,
    required this.type,
    this.duration,
  });

  final String message;
  final SnackBarType type;
  final Duration? duration;

  @override
  String toString() => 'SnackBarMessage($message, $type)';
}
