import 'package:equatable/equatable.dart';
import 'package:shared/domain/domain.dart';

/// Housekeeping service model
class HousekeepingService extends Equatable {
  const HousekeepingService({
    required this.id,
    required this.name,
    required this.category,
    required this.basePrice,
    required this.estimatedDuration,
    this.description,
    this.isActive = true,
  });

  final String id;
  final String name;
  final ServiceCategory category;
  final double basePrice;
  final Duration estimatedDuration;
  final String? description;
  final bool isActive;

  HousekeepingService copyWith({
    String? id,
    String? name,
    ServiceCategory? category,
    double? basePrice,
    Duration? estimatedDuration,
    String? description,
    bool? isActive,
  }) {
    return HousekeepingService(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      basePrice: basePrice ?? this.basePrice,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      description: description ?? this.description,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    category,
    basePrice,
    estimatedDuration,
    description,
    isActive,
  ];
}

/// Housekeeping metrics model
class HousekeepingMetrics extends Equatable {
  const HousekeepingMetrics({
    required this.totalBookings,
    required this.completedBookings,
    required this.cancelledBookings,
    required this.totalRevenue,
    required this.activeCleaners,
    required this.averageRating,
    this.period,
  });

  final int totalBookings;
  final int completedBookings;
  final int cancelledBookings;
  final double totalRevenue;
  final int activeCleaners;
  final double averageRating;
  final String? period;

  double get completionRate {
    if (totalBookings == 0) return 0.0;
    return completedBookings / totalBookings;
  }

  double get cancellationRate {
    if (totalBookings == 0) return 0.0;
    return cancelledBookings / totalBookings;
  }

  HousekeepingMetrics copyWith({
    int? totalBookings,
    int? completedBookings,
    int? cancelledBookings,
    double? totalRevenue,
    int? activeCleaners,
    double? averageRating,
    String? period,
  }) {
    return HousekeepingMetrics(
      totalBookings: totalBookings ?? this.totalBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      cancelledBookings: cancelledBookings ?? this.cancelledBookings,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      activeCleaners: activeCleaners ?? this.activeCleaners,
      averageRating: averageRating ?? this.averageRating,
      period: period ?? this.period,
    );
  }

  @override
  List<Object?> get props => [
    totalBookings,
    completedBookings,
    cancelledBookings,
    totalRevenue,
    activeCleaners,
    averageRating,
    period,
  ];
}

/// Housekeeping activity model
class HousekeepingActivity extends Equatable {
  const HousekeepingActivity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.bookingId,
    this.cleanerId,
    this.customerId,
    this.metadata,
  });

  final String id;
  final HousekeepingActivityType type;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? bookingId;
  final String? cleanerId;
  final String? customerId;
  final Map<String, dynamic>? metadata;

  HousekeepingActivity copyWith({
    String? id,
    HousekeepingActivityType? type,
    String? title,
    String? description,
    DateTime? timestamp,
    String? bookingId,
    String? cleanerId,
    String? customerId,
    Map<String, dynamic>? metadata,
  }) {
    return HousekeepingActivity(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      description: description ?? this.description,
      timestamp: timestamp ?? this.timestamp,
      bookingId: bookingId ?? this.bookingId,
      cleanerId: cleanerId ?? this.cleanerId,
      customerId: customerId ?? this.customerId,
      metadata: metadata ?? this.metadata,
    );
  }

  @override
  List<Object?> get props => [
    id,
    type,
    title,
    description,
    timestamp,
    bookingId,
    cleanerId,
    customerId,
    metadata,
  ];
}
