import '../entities/entities.dart';

class NotificationState {
  final List<Notification> notifications;
  final int unreadCount;
  final bool isLoading;
  final String? error;

  const NotificationState({
    this.notifications = const [],
    this.unreadCount = 0,
    required this.isLoading,
    this.error,
  });

  factory NotificationState.initial() =>
      const NotificationState(isLoading: false);
}
