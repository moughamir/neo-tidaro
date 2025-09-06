import 'package:equatable/equatable.dart';

import 'auth/auth_state.dart';
import 'ui/ui_state.dart';
import 'dashboard/dashboard_state.dart';

/// The global application state that combines all feature states
class AppState extends Equatable {
  const AppState({
    required this.authState,
    required this.uiState,
    required this.dashboardState,
  });

  final AuthState authState;
  final UiState uiState;
  final DashboardState dashboardState;

  /// Initial state factory
  factory AppState.initial() {
    return AppState(
      authState: AuthState.initial(),
      uiState: UiState.initial(),
      dashboardState: DashboardState.initial(),
    );
  }

  /// Copy with method for immutable updates
  AppState copyWith({
    AuthState? authState,
    UiState? uiState,
    DashboardState? dashboardState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      uiState: uiState ?? this.uiState,
      dashboardState: dashboardState ?? this.dashboardState,
    );
  }

  @override
  List<Object?> get props => [authState, uiState, dashboardState];

  @override
  String toString() => 'AppState(authState: $authState, uiState: $uiState)';
}
