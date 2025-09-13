// ignore_for_file: public_member_api_docs, type_annotate_public_apis, prefer_typing_uninitialized_variables, strict_top_level_inference, always_declare_return_types

import 'package:domain/enums/activity_type.dart';

import '../base_entity.dart';

/// Activity log for tracking system events
class ActivityLog extends BaseEntity {
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
  final String action;
  final String? userId;
  final String? resourceType;
  final String? resourceId;
  final Map<String, dynamic>? metadata;
  final String? ipAddress;
  final String? userAgent;
}

class HousekeepingActivity extends ActivityItem {
  HousekeepingActivity({
    required super.id,
    required super.description,
    required super.title,
    required super.timestamp,
    required super.type,
  });
}

class ActivityItem extends BaseEntity {
  ActivityItem({
    required super.id,
    required String description,
    required String title,
    required DateTime timestamp,
    required ActivityType type,
  });

  var description;

  var timestamp;

  get title => null;

  get type => null;
}

class DashboardMetrics extends BaseEntity {
  DashboardMetrics({
    required super.id,
    required int totalBookings,
    required int pendingBookings,
    required int completedBookings,
    required double totalRevenue,
    required double monthlyRevenue,
    required int activeProfessionals,
    required int totalCustomers,
    required double averageRating,
    required List<ActivityItem> recentActivities,
  });
  var totalBookings;

  get pendingBookings => null;

  get completedBookings => null;

  get totalRevenue => null;

  get monthlyRevenue => null;

  get activeProfessionals => null;

  get totalCustomers => null;

  get averageRating => null;

  get completionRate => null;

  get recentActivities => null;
}

/// Configuration entity for system settings
class Configuration extends BaseEntity {
  const Configuration({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.key,
    required this.value,
    this.description,
    this.isActive = true,
  });
  final String key;
  final String value;
  final String? description;
  final bool isActive;
}

/// Feature flag entity for system feature management
class FeatureFlag extends BaseEntity {
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
  final String name;
  final bool isEnabled;
  final String? description;
  final Map<String, dynamic>? conditions;
  final DateTime? expiresAt;
}
