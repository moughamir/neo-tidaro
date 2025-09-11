import 'package:domain/entities/base_entity.dart';

abstract class BlockedPeriodEntity extends BaseEntity {
  final String profileId;
  final DateTime startTime;
  final DateTime endTime;
  final String? reason;

  const BlockedPeriodEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.profileId,
    required this.startTime,
    required this.endTime,
    this.reason,
  });

  List<Object?> get props => [profileId, startTime, endTime, reason];
}
