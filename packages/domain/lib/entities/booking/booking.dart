import 'package:domain/domain.dart';

/// Booking entity for service appointments
class Booking extends BaseEntity {
  const Booking({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.clientId,
    required this.professionalId,
    required this.serviceId,
    this.addressId,

    required this.scheduledStartTime,
    required this.scheduledEndTime,
    this.actualStartTime,
    this.actualEndTime,
    this.status = BookingActivityStatus.pending,
    required this.totalAmount,

    this.specialInstructions,
    this.cancellationReason,
    this.recurrenceType = JobRecurrenceType.none,
    this.metadata,
  });
  final String clientId;
  final String professionalId;
  final String serviceId;
  final String? addressId;
  final DateTime scheduledStartTime;
  final DateTime scheduledEndTime;
  final DateTime? actualStartTime;
  final DateTime? actualEndTime;
  final BookingActivityStatus status;
  final double totalAmount;

  final String? specialInstructions;
  final String? cancellationReason;
  final JobRecurrenceType recurrenceType;
  final Map<String, dynamic>? metadata;

  /// Calculate booking duration in minutes
  int get scheduledDurationMinutes {
    return scheduledEndTime.difference(scheduledStartTime).inMinutes;
  }

  /// Calculate actual duration if completed
  int? get actualDurationMinutes {
    if (actualStartTime != null && actualEndTime != null) {
      return actualEndTime!.difference(actualStartTime!).inMinutes;
    }
    return null;
  }

  /// Check if booking is in progress
  bool get isInProgress => status == BookingActivityStatus.inProgress;

  /// Check if booking is completed
  bool get isCompleted => status == BookingActivityStatus.completed;

  /// Check if booking can be cancelled
  bool get canBeCancelled {
    return status == BookingActivityStatus.pending ||
        status == BookingActivityStatus.confirmed;
  }

  double get overallRating => overallRating;

  String get bookingId => id;

  String get reviewerId => clientId;

  String get revieweeId => professionalId;

  PaymentStatus get paymentStatus => PaymentStatus.pending;
}
