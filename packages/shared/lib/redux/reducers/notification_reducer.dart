import 'package:shared/redux/states/notification_state.dart';
import '../core/core.dart';

/// Notification reducer following Clean Architecture and functional programming principles
class NotificationReducer extends BaseReducer<NotificationState> {
  @override
  NotificationState reduce(NotificationState state, BaseAction action) {
    return switch (action.type) {
      // TODO: Handle this case.
      String() => throw UnimplementedError(),
    };
  }
}

/// Notification reducer instance
final notificationReducer = NotificationReducer();
