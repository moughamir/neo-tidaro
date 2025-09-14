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

class HousekeepingActivity extends BaseEntity {
  const HousekeepingActivity({
    required super.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    super.createdAt,
    super.updatedAt,
  });

  final String title;
  final String description;
  final DateTime timestamp;
  final HousekeepingActivityType type;

  HousekeepingActivity copyWith({
    String? title,
    String? description,
    DateTime? timestamp,
    HousekeepingActivityType? type,
  }) {
    return HousekeepingActivity(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class ActivityItem extends BaseEntity {
  const ActivityItem({
    required super.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    super.createdAt,
    super.updatedAt,
  });

  final String title;
  final String description;
  final DateTime timestamp;
  final ActivityType type;

  ActivityItem copyWith({
    String? title,
    String? description,
    DateTime? timestamp,
    ActivityType? type,
  }) {
    return ActivityItem(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

class DashboardMetrics extends BaseEntity {
  const DashboardMetrics({
    required super.id,
    required this.totalBookings,
    required this.pendingBookings,
    required this.completedBookings,
    required this.totalRevenue,
    required this.monthlyRevenue,
    required this.activeProfessionals,
    required this.totalCustomers,
    required this.averageRating,
    required this.recentActivities,
    this.completionRate = 0,
    this.confirmationRate = 0,
    this.revenue7d = 0,
    this.revenue30d = 0,
    super.createdAt,
    super.updatedAt,
  });

  final int totalBookings;
  final int pendingBookings;
  final int completedBookings;
  final double totalRevenue;
  final double monthlyRevenue;
  final int activeProfessionals;
  final int totalCustomers;
  final double averageRating;
  final double completionRate;
  final double confirmationRate;
  final double revenue7d;
  final double revenue30d;
  final List<ActivityItem> recentActivities;

  DashboardMetrics copyWith({
    int? totalBookings,
    int? pendingBookings,
    int? completedBookings,
    double? totalRevenue,
    double? monthlyRevenue,
    int? activeProfessionals,
    int? totalCustomers,
    double? averageRating,
    double? completionRate,
    double? confirmationRate,
    double? revenue7d,
    double? revenue30d,
    List<ActivityItem>? recentActivities,
  }) {
    return DashboardMetrics(
      id: id,
      totalBookings: totalBookings ?? this.totalBookings,
      pendingBookings: pendingBookings ?? this.pendingBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
      activeProfessionals: activeProfessionals ?? this.activeProfessionals,
      totalCustomers: totalCustomers ?? this.totalCustomers,
      averageRating: averageRating ?? this.averageRating,
      completionRate: completionRate ?? this.completionRate,
      confirmationRate: confirmationRate ?? this.confirmationRate,
      revenue7d: revenue7d ?? this.revenue7d,
      revenue30d: revenue30d ?? this.revenue30d,
      recentActivities: recentActivities ?? this.recentActivities,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
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
