import '../base_entity.dart';
import '../../enums/enums.dart';

/// Booking entity for service appointments
class Booking extends BaseEntity {
  final String clientId;
  final String professionalId;
  final String serviceId;
  final String? addressId;
  final DateTime scheduledStartTime;
  final DateTime scheduledEndTime;
  final DateTime? actualStartTime;
  final DateTime? actualEndTime;
  final BookingStatus status;
  final double totalAmount;
  final String? specialInstructions;
  final String? cancellationReason;
  final RecurrenceType recurrenceType;
  final Map<String, dynamic>? metadata;

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
    this.status = BookingStatus.pending,
    required this.totalAmount,
    this.specialInstructions,
    this.cancellationReason,
    this.recurrenceType = RecurrenceType.none,
    this.metadata,
  });

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
  bool get isInProgress => status == BookingStatus.inProgress;

  /// Check if booking is completed
  bool get isCompleted => status == BookingStatus.completed;

  /// Check if booking can be cancelled
  bool get canBeCancelled {
    return status == BookingStatus.pending || 
           status == BookingStatus.confirmed;
  }
}
