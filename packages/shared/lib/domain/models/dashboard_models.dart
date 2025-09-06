import 'package:equatable/equatable.dart';

/// Dashboard metrics model
class DashboardMetrics extends Equatable {
  const DashboardMetrics({
    required this.totalBookings,
    required this.pendingBookings,
    required this.completedBookings,
    required this.totalRevenue,
    required this.monthlyRevenue,
    required this.activeCleaners,
    required this.totalCustomers,
    required this.averageRating,
    this.recentActivities = const [],
    this.topServices = const [],
  });

  final int totalBookings;
  final int pendingBookings;
  final int completedBookings;
  final double totalRevenue;
  final double monthlyRevenue;
  final int activeCleaners;
  final int totalCustomers;
  final double averageRating;
  final List<ActivityItem> recentActivities;
  final List<ServiceMetric> topServices;

  double get completionRate {
    if (totalBookings == 0) return 0.0;
    return completedBookings / totalBookings;
  }

  DashboardMetrics copyWith({
    int? totalBookings,
    int? pendingBookings,
    int? completedBookings,
    double? totalRevenue,
    double? monthlyRevenue,
    int? activeCleaners,
    int? totalCustomers,
    double? averageRating,
    List<ActivityItem>? recentActivities,
    List<ServiceMetric>? topServices,
  }) {
    return DashboardMetrics(
      totalBookings: totalBookings ?? this.totalBookings,
      pendingBookings: pendingBookings ?? this.pendingBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
      activeCleaners: activeCleaners ?? this.activeCleaners,
      totalCustomers: totalCustomers ?? this.totalCustomers,
      averageRating: averageRating ?? this.averageRating,
      recentActivities: recentActivities ?? this.recentActivities,
      topServices: topServices ?? this.topServices,
    );
  }

  @override
  List<Object?> get props => [
        totalBookings,
        pendingBookings,
        completedBookings,
        totalRevenue,
        monthlyRevenue,
        activeCleaners,
        totalCustomers,
        averageRating,
        recentActivities,
        topServices,
      ];
}

/// Activity item model for dashboard
class ActivityItem extends Equatable {
  const ActivityItem({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.type,
    this.icon,
  });

  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? type;
  final String? icon;

  ActivityItem copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? timestamp,
    String? type,
    String? icon,
  }) {
    return ActivityItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      type: type ?? this.type,
      icon: icon ?? this.icon,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        timestamp,
        type,
        icon,
      ];
}

/// Service metric model for dashboard
class ServiceMetric extends Equatable {
  const ServiceMetric({
    required this.serviceName,
    required this.bookingCount,
    required this.revenue,
    this.growthRate,
  });

  final String serviceName;
  final int bookingCount;
  final double revenue;
  final double? growthRate;

  ServiceMetric copyWith({
    String? serviceName,
    int? bookingCount,
    double? revenue,
    double? growthRate,
  }) {
    return ServiceMetric(
      serviceName: serviceName ?? this.serviceName,
      bookingCount: bookingCount ?? this.bookingCount,
      revenue: revenue ?? this.revenue,
      growthRate: growthRate ?? this.growthRate,
    );
  }

  @override
  List<Object?> get props => [
        serviceName,
        bookingCount,
        revenue,
        growthRate,
      ];
}
