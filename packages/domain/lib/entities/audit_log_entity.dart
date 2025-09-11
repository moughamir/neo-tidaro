import 'package:domain/domain.dart';

abstract class AuditLogEntity extends BaseEntity {
  final String action;
  final String? profileId;
  final String resourceType;
  final String resourceId;
  final Map<String, dynamic>? previousValues;
  final Map<String, dynamic>? newValues;
  final String? ipAddress;
  final String? userAgent;

  const AuditLogEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.action,
    this.profileId,
    required this.resourceType,
    required this.resourceId,
    this.previousValues,
    this.newValues,
    this.ipAddress,
    this.userAgent,
  });

  List<Object?> get props => [
    action,
    profileId,
    resourceType,
    resourceId,
    previousValues,
    newValues,
    ipAddress,
    userAgent,
  ];
}
