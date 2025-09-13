import 'package:shared/redux/core/core.dart';
import 'states.dart';

class AppState extends BaseState {
  final AuthState authState;
  final BookingState bookingState;
  final CacheState cacheState;
  final ChatState chatState;
  final DashboardState dashboardState;
  final NotificationState notificationState;
  final ProfessionalState professionalState;
  final UiState uiState;
  final UserState userState;
  const AppState({
    required this.authState,
    required this.bookingState,
    required this.cacheState,
    required this.chatState,
    required this.dashboardState,
    required this.notificationState,
    required this.professionalState,
    required this.uiState,
    required this.userState,
  });
  factory AppState.initial() => AppState(
    authState: AuthState.initial(),
    bookingState: BookingState.initial(),
    cacheState: CacheState.initial(),
    chatState: ChatState.initial(),
    dashboardState: DashboardState.initial(),
    notificationState: NotificationState.initial(),
    professionalState: ProfessionalState.initial(),
    uiState: UiState.initial(),
    userState: UserState.initial(),
  );
  AppState copyWith({
    AuthState? authState,
    BookingState? bookingState,
    CacheState? cacheState,
    ChatState? chatState,
    DashboardState? dashboardState,
    NotificationState? notificationState,
    ProfessionalState? professionalState,
    UiState? uiState,
    UserState? userState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      bookingState: bookingState ?? this.bookingState,
      cacheState: cacheState ?? this.cacheState,
      chatState: chatState ?? this.chatState,
      dashboardState: dashboardState ?? this.dashboardState,
      notificationState: notificationState ?? this.notificationState,
      professionalState: professionalState ?? this.professionalState,
      uiState: uiState ?? this.uiState,
      userState: userState ?? this.userState,
    );
  }

  @override
  List<Object?> get props => [
    authState,
    authState,
    bookingState,
    bookingState,
    cacheState,
    chatState,
    professionalState,
    dashboardState,
    dashboardState,
    notificationState,
    professionalState,
    professionalState,
    uiState,
    uiState,
    userState,
  ];
  @override
  String get stateType => 'AppState';

  @override
  String toString() =>
      'AppState('
      'authState: ${authState.stateType},'
      'bookingState: ${bookingState.stateType},'
      'cacheState: ${cacheState.stateType}'
      'chatState: ${chatState.stateType}'
      'dashboardState: ${dashboardState.stateType},'
      'notificationState: ${notificationState.stateType}'
      'professionalState: ${professionalState.stateType},'
      'uiState: ${uiState.stateType}'
      'userState: ${userState.stateType}'
      ')';
}
