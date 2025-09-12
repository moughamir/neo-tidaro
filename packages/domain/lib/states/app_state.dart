import 'dashboard_state.dart';
import 'user_state.dart';
import 'auth_state.dart';
import 'booking_state.dart';
import 'cache_state.dart';
import 'chat_state.dart';
import 'notification_state.dart';
import 'professional_state.dart';
import 'ui_state.dart';

class AppState {
  final AuthState authState;
  final UserState userState;
  final ProfessionalState professionalState;
  final BookingState bookingState;
  final ChatState chatState;
  final NotificationState notificationState;
  final UIState uiState;
  final CacheState cacheState;
  final DashboardState dashboardState;

  const AppState({
    required this.authState,
    required this.userState,
    required this.professionalState,
    required this.bookingState,
    required this.chatState,
    required this.notificationState,
    required this.uiState,
    required this.cacheState,
    required this.dashboardState,
  });

  factory AppState.initial() => AppState(
    authState: AuthState.initial(),
    userState: UserState.initial(),
    professionalState: ProfessionalState.initial(),
    bookingState: BookingState.initial(),
    chatState: ChatState.initial(),
    notificationState: NotificationState.initial(),
    uiState: UIState.initial(),
    cacheState: CacheState.initial(),
    dashboardState: DashboardState.initial(),
  );

  AppState copyWith({
    AuthState? authState,
    UserState? userState,
    ProfessionalState? professionalState,
    BookingState? bookingState,
    ChatState? chatState,
    NotificationState? notificationState,
    UIState? uiState,
    CacheState? cacheState,
    DashboardState? dashboardState,
  }) {
    return AppState(
      authState: authState ?? this.authState,
      userState: userState ?? this.userState,
      professionalState: professionalState ?? this.professionalState,
      bookingState: bookingState ?? this.bookingState,
      chatState: chatState ?? this.chatState,
      notificationState: notificationState ?? this.notificationState,
      uiState: uiState ?? this.uiState,
      cacheState: cacheState ?? this.cacheState,
      dashboardState: dashboardState ?? this.dashboardState,
    );
  }
}
