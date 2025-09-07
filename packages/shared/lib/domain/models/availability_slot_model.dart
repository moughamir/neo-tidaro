import 'package:shared/domain/domain.dart';

class AvailabilitySlotModel extends AvailabilitySlotEntity {
  const AvailabilitySlotModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.providerId,
    required super.dayOfWeek,
    required super.startTime,
    required super.endTime,
    required super.isAvailable,
  });
}
