import '../base_entity.dart';

/// Professional availability entity
class Availability extends BaseEntity {
  /// Creates a new instance of [Availability].
  const Availability({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.professionalId,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });
  /// The ID of the professional this availability belongs to.
  final String professionalId;
  /// The start time of the availability.
  final DateTime startTime;
  /// The end time of the availability.
  final DateTime endTime;
  /// Whether the professional is available during this time.
  final bool isAvailable;
}

/// Time slot for scheduling
class TimeSlot {
  /// Creates a new instance of [TimeSlot].
  const TimeSlot({
    required this.startTime,
    required this.endTime,
    this.isBooked = false,
  });
  /// The start time of the time slot in "HH:mm" format.
  final String startTime; // Format: "HH:mm"
  /// The end time of the time slot in "HH:mm" format.
  final String endTime; // Format: "HH:mm"
  /// Whether the time slot is booked.
  final bool isBooked;
}