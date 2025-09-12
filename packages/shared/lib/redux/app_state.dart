import 'core/core.dart';
import 'states/states.dart';

/// The global application state that combines all feature states
/// Following Clean Architecture and functional programming patterns
class AppState extends BaseState {
  const AppState({
    required this.authState,
    required this.dashboardState,
    required this.bookingState,
    required this.professionalState,
    required this.uiState,
  });

  final AuthState authState;
  final DashboardState dashboardState;
  final BookingState bookingState;
  final ProfessionalState professionalState;
  final UiState uiState;

  /// Initial state factory
  factory AppState.initial() {
    return AppState(
      authState: AuthState.initial(),
      dashboardState: DashboardState.initial(),
      bookingState: BookingState.initial(),
      professionalState: ProfessionalState.initial(),
      uiState: UiState.initial(),
    );
  }

  /// Copy with method for immutable updates
  AppState copyWith({
    AuthState? authState,
    DashboardState? dashboardState,
    BookingState? bookingState,
    ProfessionalState? cleanerState,
    UiState? uiState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      dashboardState: dashboardState ?? this.dashboardState,
      bookingState: bookingState ?? this.bookingState,
      professionalState: cleanerState ?? this.professionalState,
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
    professionalState,
    uiState,
  ];

  @override
  String toString() =>
      'AppState('
      'authState: ${authState.stateType}, '
      'dashboardState: ${dashboardState.stateType}, '
      'bookingState: ${bookingState.stateType}, '
      'cleanerState: ${professionalState.stateType}, '
      'uiState: ${uiState.stateType}'
      ')';
}
