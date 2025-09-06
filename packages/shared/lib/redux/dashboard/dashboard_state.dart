import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  const DashboardState({
    this.isLoading = false,
    this.isRefreshing = false,
    this.metrics,
    this.error,
    this.lastUpdated,
  });

  final bool isLoading;
  final bool isRefreshing;
  final DashboardMetrics? metrics;
  final String? error;
  final DateTime? lastUpdated;

  factory DashboardState.initial() {
    return const DashboardState();
  }

  DashboardState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    DashboardMetrics? metrics,
    String? error,
    DateTime? lastUpdated,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      metrics: metrics ?? this.metrics,
      error: error ?? this.error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isRefreshing,
        metrics,
        error,
        lastUpdated,
      ];
}

class DashboardMetrics extends Equatable {
  const DashboardMetrics({
    required this.totalUsers,
    required this.activeUsers,
    required this.revenue,
    required this.orders,
    required this.growthRate,
    this.recentActivities = const [],
  });

  final int totalUsers;
  final int activeUsers;
  final double revenue;
  final int orders;
  final double growthRate;
  final List<ActivityItem> recentActivities;

  DashboardMetrics copyWith({
    int? totalUsers,
    int? activeUsers,
    double? revenue,
    int? orders,
    double? growthRate,
    List<ActivityItem>? recentActivities,
  }) {
    return DashboardMetrics(
      totalUsers: totalUsers ?? this.totalUsers,
      activeUsers: activeUsers ?? this.activeUsers,
      revenue: revenue ?? this.revenue,
      orders: orders ?? this.orders,
      growthRate: growthRate ?? this.growthRate,
      recentActivities: recentActivities ?? this.recentActivities,
    );
  }

  @override
  List<Object?> get props => [
        totalUsers,
        activeUsers,
        revenue,
        orders,
        growthRate,
        recentActivities,
      ];
}

class ActivityItem extends Equatable {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
  });

  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final ActivityType type;

  @override
  List<Object?> get props => [id, title, description, timestamp, type];
}

enum ActivityType {
  user,
  order,
  system,
  revenue,
}
