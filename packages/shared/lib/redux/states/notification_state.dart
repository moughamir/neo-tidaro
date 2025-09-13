import 'package:domain/domain.dart';
import 'package:shared/redux/core/base_state.dart';

class NotificationState extends BaseState {
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

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();

  @override
  // TODO: implement stateType
  String get stateType => throw UnimplementedError();
}
