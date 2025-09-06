import 'package:equatable/equatable.dart';

import 'auth/auth_state.dart';
import 'ui/ui_state.dart';
import 'dashboard/dashboard_state.dart';
import 'housekeeping/housekeeping_state.dart';

/// The global application state that combines all feature states
class AppState extends Equatable {
  const AppState({
    required this.authState,
    required this.uiState,
    required this.dashboardState,
    required this.housekeepingState,
  });

  final AuthState authState;
  final UiState uiState;
  final DashboardState dashboardState;
  final HousekeepingState housekeepingState;

  /// Initial state factory
  factory AppState.initial() {
    return AppState(
      authState: AuthState.initial(),
      uiState: UiState.initial(),
      dashboardState: DashboardState.initial(),
      housekeepingState: HousekeepingState.initial(),
    );
  }

  /// Copy with method for immutable updates
  AppState copyWith({
    AuthState? authState,
    UiState? uiState,
    DashboardState? dashboardState,
    HousekeepingState? housekeepingState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      uiState: uiState ?? this.uiState,
      dashboardState: dashboardState ?? this.dashboardState,
      housekeepingState: housekeepingState ?? this.housekeepingState,
    );
  }

  @override
  List<Object?> get props => [authState, uiState, dashboardState, housekeepingState];

  @override
  String toString() => 'AppState(authState: $authState, uiState: $uiState, dashboardState: $dashboardState, housekeepingState: $housekeepingState)';
}
