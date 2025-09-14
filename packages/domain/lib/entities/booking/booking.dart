import 'package:domain/domain.dart';

/// Booking entity for service appointments
class Booking extends BaseEntity {
  /// Creates a new instance of [Booking].
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
  /// The ID of the client who made the booking.
  final String clientId;
  /// The ID of the professional who will perform the service.
  final String professionalId;
  /// The ID of the service being booked.
  final String serviceId;
  /// The ID of the address where the service will be performed.
  final String? addressId;
  /// The scheduled start time of the booking.
  final DateTime scheduledStartTime;
  /// The scheduled end time of the booking.
  final DateTime scheduledEndTime;
  /// The actual start time of the booking.
  final DateTime? actualStartTime;
  /// The actual end time of the booking.
  final DateTime? actualEndTime;
  /// The current status of the booking.
  final BookingActivityStatus status;
  /// The total amount for the booking.
  final double totalAmount;

  /// Any special instructions for the booking.
  final String? specialInstructions;
  /// The reason for cancelling the booking.
  final String? cancellationReason;
  /// The recurrence type of the booking.
  final JobRecurrenceType recurrenceType;
  /// Additional metadata for the booking.
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

  /// The overall rating of the booking.
  /// TODO: Implement the actual logic for this.
  double get overallRating => 0.0;

  /// The ID of the booking.
  String get bookingId => id;

  /// The ID of the reviewer.
  String get reviewerId => clientId;

  /// The ID of the reviewee.
  String get revieweeId => professionalId;

  /// The payment status of the booking.
  PaymentStatus get paymentStatus => PaymentStatus.pending;
}