import 'package:equatable/equatable.dart';

import 'auth/auth_state.dart';
import 'ui/ui_state.dart';

/// The global application state that combines all feature states
class AppState extends Equatable {
  const AppState({
    required this.authState,
    required this.uiState,
  });

  final AuthState authState;
  final UiState uiState;

  /// Initial state factory
  factory AppState.initial() {
    return const AppState(
      authState: AuthState.initial(),
      uiState: UiState.initial(),
    );
  }

  /// Copy with method for immutable updates
  AppState copyWith({
    AuthState? authState,
    UiState? uiState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      uiState: uiState ?? this.uiState,
    );
  }

  @override
  List<Object?> get props => [authState, uiState];

  @override
  String toString() => 'AppState(authState: $authState, uiState: $uiState)';
}
