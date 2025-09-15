import 'package:domain/domain.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

import 'supabase_repository.dart';

/// Supabase implementation for analytics and dashboard data
class SupabaseAnalyticsRepository extends SupabaseRepository<DashboardMetrics, CreateMetricsDto, UpdateMetricsDto> {
  SupabaseAnalyticsRepository(super.client) : super('dashboard_metrics');

  @override
  DashboardMetrics fromJson(Map<String, dynamic> json) {
    return DashboardMetrics(
      id: json['id'] as String,
      totalBookings: json['total_bookings'] as int? ?? 0,
      pendingBookings: json['pending_bookings'] as int? ?? 0,
      completedBookings: json['completed_bookings'] as int? ?? 0,
      totalRevenue: (json['total_revenue'] as num?)?.toDouble() ?? 0.0,
      monthlyRevenue: (json['monthly_revenue'] as num?)?.toDouble() ?? 0.0,
      activeProfessionals: json['active_professionals'] as int? ?? 0,
      totalCustomers: json['total_customers'] as int? ?? 0,
      averageRating: (json['average_rating'] as num?)?.toDouble() ?? 0.0,
      completionRate: (json['completion_rate'] as num?)?.toDouble() ?? 0.0,
      confirmationRate: (json['confirmation_rate'] as num?)?.toDouble() ?? 0.0,
      revenue7d: (json['revenue_7d'] as num?)?.toDouble() ?? 0.0,
      revenue30d: (json['revenue_30d'] as num?)?.toDouble() ?? 0.0,
      recentActivities: (json['recent_activities'] as List<dynamic>?)
          ?.map((activity) => ActivityItem(
                id: activity['id'] as String,
                title: activity['title'] as String,
                description: activity['description'] as String,
                timestamp: DateTime.parse(activity['timestamp'] as String),
                type: ActivityType.values.firstWhere(
                  (type) => type.name == activity['type'],
                  orElse: () => ActivityType.other,
                ),
              ))
          .toList() ?? [],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null 
          ? DateTime.parse(json['updated_at'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson(DashboardMetrics entity) {
    return {
      'id': entity.id,
      'total_users': entity.totalUsers,
      'active_users': entity.activeUsers,
      'revenue': entity.revenue,
      'orders': entity.orders,
      'user_growth': entity.userGrowth,
      'revenue_growth': entity.revenueGrowth,
      'order_growth': entity.orderGrowth,
      'active_bookings': entity.activeBookings,
      'monthly_revenue': entity.monthlyRevenue,
      'total_customers': entity.totalCustomers,
      'recent_activities': entity.recentActivities.map((activity) => activity.toJson()).toList(),
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt?.toIso8601String(),
    };
  }

  /// Get latest dashboard metrics
  ResultFuture<DashboardMetrics> getLatestMetrics() async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .order('created_at', ascending: false)
          .limit(1)
          .single();

      return right(fromJson(response));
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to get latest metrics: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error getting latest metrics: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Get metrics for date range
  ResultFuture<List<DashboardMetrics>> getMetricsForDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .gte('created_at', startDate.toIso8601String())
          .lte('created_at', endDate.toIso8601String())
          .order('created_at', ascending: true);

      return right(
        (response as List<dynamic>)
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to get metrics for date range: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error getting metrics for date range: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Subscribe to real-time metrics updates
  Stream<DashboardMetrics> subscribeToMetricsUpdates() {
    return client
        .from(tableName)
        .stream(primaryKey: ['id'])
        .order('created_at', ascending: false)
        .limit(1)
        .map((data) => data.isNotEmpty ? fromJson(data.first) : null)
        .where((metrics) => metrics != null)
        .cast<DashboardMetrics>();
  }

  /// Update metrics with calculated growth rates
  ResultFuture<DashboardMetrics> updateMetricsWithGrowth(
    String id,
    DashboardMetrics newMetrics,
  ) async {
    try {
      // Get previous metrics for growth calculation
      final previousMetricsResult = await client
          .from(tableName)
          .select()
          .neq('id', id)
          .order('created_at', ascending: false)
          .limit(1);

      double userGrowth = 0.0;
      double revenueGrowth = 0.0;
      double orderGrowth = 0.0;

      if (previousMetricsResult.isNotEmpty) {
        final previousMetrics = fromJson(previousMetricsResult.first);
        
        userGrowth = _calculateGrowthRate(
          previousMetrics.totalUsers.toDouble(),
          newMetrics.totalUsers.toDouble(),
        );
        
        revenueGrowth = _calculateGrowthRate(
          previousMetrics.revenue,
          newMetrics.revenue,
        );
        
        orderGrowth = _calculateGrowthRate(
          previousMetrics.orders.toDouble(),
          newMetrics.orders.toDouble(),
        );
      }

      final updatedMetrics = newMetrics.copyWith(
        userGrowth: userGrowth,
        revenueGrowth: revenueGrowth,
        orderGrowth: orderGrowth,
      );

      return await update(updatedMetrics);
    } catch (e) {
      CoreLogger.error('Failed to update metrics with growth: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  double _calculateGrowthRate(double previous, double current) {
    if (previous == 0) return current > 0 ? 100.0 : 0.0;
    return ((current - previous) / previous) * 100;
  }
}

/// Activity repository for dashboard activities
class SupabaseActivityRepository extends SupabaseRepository<ActivityItem, CreateActivityDto, UpdateActivityDto> {
  SupabaseActivityRepository(super.client) : super('activities');

  @override
  ActivityItem fromJson(Map<String, dynamic> json) {
    return ActivityItem(
      id: json['id'] as String,
      type: ActivityType.values.firstWhere(
        (type) => type.name == json['type'],
        orElse: () => ActivityType.other,
      ),
      title: json['title'] as String,
      description: json['description'] as String?,
      userId: json['user_id'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? {},
      timestamp: DateTime.parse(json['timestamp'] as String),
    );
  }

  @override
  Map<String, dynamic> toJson(ActivityItem entity) {
    return {
      'id': entity.id,
      'type': entity.type.name,
      'title': entity.title,
      'description': entity.description,
      'user_id': entity.userId,
      'metadata': entity.metadata,
      'timestamp': entity.timestamp.toIso8601String(),
    };
  }

  /// Get recent activities with pagination
  ResultFuture<List<ActivityItem>> getRecentActivities({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .order('timestamp', ascending: false)
          .range(offset, offset + limit - 1);

      return right(
        (response as List<dynamic>)
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to get recent activities: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error getting recent activities: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Get activities by type
  ResultFuture<List<ActivityItem>> getActivitiesByType(ActivityType type) async {
    try {
      final response = await client
          .from(tableName)
          .select()
          .eq('type', type.name)
          .order('timestamp', ascending: false)
          .limit(50);

      return right(
        (response as List<dynamic>)
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to get activities by type: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error getting activities by type: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Subscribe to real-time activity updates
  Stream<List<ActivityItem>> subscribeToActivityUpdates() {
    return client
        .from(tableName)
        .stream(primaryKey: ['id'])
        .order('timestamp', ascending: false)
        .limit(20)
        .map((data) => data
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList());
  }
}

/// DTOs for metrics operations
class CreateMetricsDto {
  const CreateMetricsDto({
    required this.totalUsers,
    required this.activeUsers,
    required this.revenue,
    required this.orders,
    this.activeBookings = 0,
    this.monthlyRevenue = 0.0,
    this.totalCustomers = 0,
    this.recentActivities = const [],
  });

  final int totalUsers;
  final int activeUsers;
  final double revenue;
  final int orders;
  final int activeBookings;
  final double monthlyRevenue;
  final int totalCustomers;
  final List<ActivityItem> recentActivities;

  Map<String, dynamic> toJson() => {
    'total_users': totalUsers,
    'active_users': activeUsers,
    'revenue': revenue,
    'orders': orders,
    'active_bookings': activeBookings,
    'monthly_revenue': monthlyRevenue,
    'total_customers': totalCustomers,
    'recent_activities': recentActivities.map((activity) => activity.toJson()).toList(),
  };
}

class UpdateMetricsDto {
  const UpdateMetricsDto({
    this.totalUsers,
    this.activeUsers,
    this.revenue,
    this.orders,
    this.activeBookings,
    this.monthlyRevenue,
    this.totalCustomers,
    this.recentActivities,
  });

  final int? totalUsers;
  final int? activeUsers;
  final double? revenue;
  final int? orders;
  final int? activeBookings;
  final double? monthlyRevenue;
  final int? totalCustomers;
  final List<ActivityItem>? recentActivities;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (totalUsers != null) json['total_users'] = totalUsers;
    if (activeUsers != null) json['active_users'] = activeUsers;
    if (revenue != null) json['revenue'] = revenue;
    if (orders != null) json['orders'] = orders;
    if (activeBookings != null) json['active_bookings'] = activeBookings;
    if (monthlyRevenue != null) json['monthly_revenue'] = monthlyRevenue;
    if (totalCustomers != null) json['total_customers'] = totalCustomers;
    if (recentActivities != null) {
      json['recent_activities'] = recentActivities!.map((activity) => activity.toJson()).toList();
    }
    return json;
  }
}

/// DTOs for activity operations
class CreateActivityDto {
  const CreateActivityDto({
    required this.type,
    required this.title,
    this.description,
    this.userId,
    this.metadata = const {},
  });

  final ActivityType type;
  final String title;
  final String? description;
  final String? userId;
  final Map<String, dynamic> metadata;

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'title': title,
    'description': description,
    'user_id': userId,
    'metadata': metadata,
    'timestamp': DateTime.now().toIso8601String(),
  };
}

class UpdateActivityDto {
  const UpdateActivityDto({
    this.type,
    this.title,
    this.description,
    this.userId,
    this.metadata,
  });

  final ActivityType? type;
  final String? title;
  final String? description;
  final String? userId;
  final Map<String, dynamic>? metadata;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (type != null) json['type'] = type!.name;
    if (title != null) json['title'] = title;
    if (description != null) json['description'] = description;
    if (userId != null) json['user_id'] = userId;
    if (metadata != null) json['metadata'] = metadata;
    return json;
  }
}
