import '../base_entity.dart';

/// Activity log for tracking system events
class ActivityLog extends BaseEntity {
  final String action;
  final String? userId;
  final String? resourceType;
  final String? resourceId;
  final Map<String, dynamic>? metadata;
  final String? ipAddress;
  final String? userAgent;

  const ActivityLog({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.action,
    this.userId,
    this.resourceType,
    this.resourceId,
    this.metadata,
    this.ipAddress,
    this.userAgent,
  });
}

/// Configuration entity for system settings
class Configuration extends BaseEntity {
  final String key;
  final String value;
  final String? description;
  final bool isActive;

  const Configuration({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.key,
    required this.value,
    this.description,
    this.isActive = true,
  });
}

/// Feature flag entity for system feature management
class FeatureFlag extends BaseEntity {
  final String name;
  final bool isEnabled;
  final String? description;
  final Map<String, dynamic>? conditions;
  final DateTime? expiresAt;

  const FeatureFlag({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    required this.isEnabled,
    this.description,
    this.conditions,
    this.expiresAt,
  });
}
