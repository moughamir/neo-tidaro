import 'package:shared/domain/domain.dart';

abstract class BlockedPeriodEntity extends Entity {
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

  @override
  List<Object?> get props => [
    ...super.props,
    profileId,
    startTime,
    endTime,
    reason,
  ];
}
