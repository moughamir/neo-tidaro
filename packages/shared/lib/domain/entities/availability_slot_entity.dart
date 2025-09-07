import 'package:flutter/material.dart' show TimeOfDay;
import 'package:shared/domain/domain.dart';

abstract class AvailabilitySlotEntity extends Entity {
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

  @override
  List<Object?> get props => [
    ...super.props,
    providerId,
    dayOfWeek,
    startTime,
    endTime,
    isAvailable,
  ];
}
