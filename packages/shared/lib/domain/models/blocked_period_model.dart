import 'package:shared/domain/domain.dart';

class BlockedPeriodModel extends BlockedPeriodEntity {
  const BlockedPeriodModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.profileId,
    required super.startTime,
    required super.endTime,
    super.reason,
  });
}
