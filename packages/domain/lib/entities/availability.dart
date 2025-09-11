import 'package:flutter/material.dart' show TimeOfDay;

import 'base_entity.dart';

/// Professional availability entity
class Availability extends BaseEntity {
  final String professionalId;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAvailable;

  const Availability({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.professionalId,
    required this.startTime,
    required this.endTime,
    this.isAvailable = true,
  });
}

/// Time slot for scheduling
class TimeSlot {
  final String startTime; // Format: "HH:mm"
  final String endTime; // Format: "HH:mm"
  final bool isBooked;

  const TimeSlot({
    required this.startTime,
    required this.endTime,
    this.isBooked = false,
  });
}

abstract class AvailabilitySlotEntity extends BaseEntity {
  final String providerId;
  final int dayOfWeek;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final bool isAvailable;

  const AvailabilitySlotEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.providerId,
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
    required this.isAvailable,
  });

  List<Object?> get props => [
    providerId,
    dayOfWeek,
    startTime,
    endTime,
    isAvailable,
  ];
}
