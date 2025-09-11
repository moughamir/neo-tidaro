import '../enums/enums.dart';
import 'base_entity.dart';

/// Notification entity for system messages
class Notification extends BaseEntity {
  final String userId;
  final NotificationType type;
  final String title;
  final String body;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime? readAt;

  const Notification({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.userId,
    required this.type,
    required this.title,
    required this.body,
    this.data,
    this.isRead = false,
    this.readAt,
  });
}

/// System settings entity
class Setting extends BaseEntity {
  final String key;
  final String? value;

  const Setting({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.key,
    this.value,
  });
}

/// Background job entity
class Job extends BaseEntity {
  final String queue;
  final dynamic payload;
  final JobStatus status;
  final int? attempts;
  final DateTime? reservedAt;
  final DateTime? availableAt;
  final DateTime? failedAt;
  final String? exception;
  final String? connection;

  const Job({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.queue,
    required this.payload,
    required this.status,
    this.attempts,
    this.reservedAt,
    this.availableAt,
    this.failedAt,
    this.exception,
    this.connection,
  });
}

/// Activity log entity for audit trail
class ActivityLog extends BaseEntity {
  final String? actorId;
  final String actionType;
  final String? targetId;
  final String? targetTable;
  final dynamic payload;

  const ActivityLog({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    this.actorId,
    required this.actionType,
    this.targetId,
    this.targetTable,
    this.payload,
  });
}
