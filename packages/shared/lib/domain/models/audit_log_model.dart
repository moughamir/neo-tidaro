import 'package:shared/domain/domain.dart';

class AuditLogModel extends AuditLogEntity {
  const AuditLogModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.action,
    super.profileId,
    required super.resourceType,
    required super.resourceId,
    super.previousValues,
    super.newValues,
    super.ipAddress,
    super.userAgent,
  });
}
