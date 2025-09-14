import 'package:domain/domain.dart';
import 'package:shared/redux/core/base_state.dart';

class NotificationState extends BaseState {

  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    required this.isLoading,
    this.error,
  });

  factory NotificationState.initial() =>
      const NotificationState(isLoading: false);
  final List<Notification> notifications;
  final int unreadCount;
  final bool isLoading;
  final String? error;

  @override
  List<Object?> get props => [notifications, unreadCount, isLoading, error];

  @override
  String get stateType => 'notificationState';
}
