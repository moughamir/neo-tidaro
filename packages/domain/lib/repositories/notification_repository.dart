import '../dto/pagination_dto.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'base_repository.dart';

/// Repository interface for user-facing notifications.
///
/// This contract is pure domain. Implementations must live outside the domain
/// layer (e.g., in Shared/Infra) and depend on this interface.
///
/// Key expectations:
/// - Methods should return RepositoryResult<T> for controllable error cases.
/// - Streams should emit live changes when supported by the backing store.
/// - No framework (Flutter) or SDK coupling here.
abstract class NotificationRepository extends BaseRepository<Notification> {
  /// Returns all notifications for a given [userId].
  Future<RepositoryResult<List<Notification>>> getForUser(
    String userId, {
    PaginationDto? pagination,
  });

  /// Marks a single notification as read by its [notificationId].
  Future<RepositoryResult<bool>> markRead(String notificationId);

  /// Marks all notifications as read for [userId].
  Future<RepositoryResult<bool>> markAllRead(String userId);

  /// Sends/creates a notification for [userId].
  Future<RepositoryResult<Notification>> notify({
    required String userId,
    required String title,
    required String content,
    required NotificationType type,
    Map<String, dynamic>? payload,
    String? actionUrl,
  });

  /// Batch-send notifications to multiple [userIds].
  Future<RepositoryResult<List<Notification>>> notifyBatch({
    required List<String> userIds,
    required String title,
    required String content,
    required NotificationType type,
    Map<String, dynamic>? payload,
    String? actionUrl,
  });

  /// Watches live notifications for [userId].
  Stream<List<Notification>> watchUserNotifications(String userId);
}
