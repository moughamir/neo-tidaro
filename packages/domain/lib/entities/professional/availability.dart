import '../base_entity.dart';

/// Professional availability entity
class Availability extends BaseEntity {
  const Availability({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.professionalId,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });
  final String professionalId;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;
}

/// Time slot for scheduling
class TimeSlot {
  const TimeSlot({
    required this.startTime,
    required this.endTime,
    this.isBooked = false,
  });
  final String startTime; // Format: "HH:mm"
  final String endTime; // Format: "HH:mm"
  final bool isBooked;
}
