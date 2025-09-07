import 'core/core.dart';
import 'states/states.dart';

/// The global application state that combines all feature states
/// Following Clean Architecture and functional programming patterns
class AppState extends BaseState {
  const AppState({
    required this.authState,
    required this.dashboardState,
    required this.bookingState,
    required this.cleanerState,
    required this.uiState,
  });

  final AuthState authState;
  final DashboardState dashboardState;
  final BookingState bookingState;
  final CleanerState cleanerState;
  final UiState uiState;

  /// Initial state factory
  factory AppState.initial() {
    return AppState(
      authState: AuthState.initial(),
      dashboardState: DashboardState.initial(),
      bookingState: BookingState.initial(),
      cleanerState: CleanerState.initial(),
      uiState: UiState.initial(),
    );
  }

  /// Copy with method for immutable updates
  AppState copyWith({
    AuthState? authState,
    DashboardState? dashboardState,
    BookingState? bookingState,
    CleanerState? cleanerState,
    UiState? uiState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      dashboardState: dashboardState ?? this.dashboardState,
      bookingState: bookingState ?? this.bookingState,
      cleanerState: cleanerState ?? this.cleanerState,
      uiState: uiState ?? this.uiState,
    );
  }

  @override
  String get stateType => 'AppState';

  @override
  List<Object?> get props => [
    authState,
    dashboardState,
    bookingState,
    cleanerState,
    uiState,
  ];

  @override
  String toString() => 'AppState('
      'authState: ${authState.stateType}, '
      'dashboardState: ${dashboardState.stateType}, '
      'bookingState: ${bookingState.stateType}, '
      'cleanerState: ${cleanerState.stateType}, '
      'uiState: ${uiState.stateType}'
      ')';
}
