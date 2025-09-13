import 'package:domain/mappers/cleaner_status_mapper.dart';

import '../enums/enums.dart';
import '../mappers/mappers.dart';

class SupabaseProfileDto {
  const SupabaseProfileDto({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    required this.role,
    this.professionalActivityStatus,
    this.createdAt,
    this.updatedAt,
  });

  factory SupabaseProfileDto.fromMap(Map<String, dynamic> map) {
    return SupabaseProfileDto(
      id: map['id'] as String,
      fullName: map['full_name'] as String? ?? '',
      avatarUrl: map['avatar_url'] as String?,
      phoneNumber: map['phone_number'] as String?,
      role: userRoleFromSql(map['role'] as String),
      professionalActivityStatus: map['status'] != null
          ? professionalActivityStatusFromSql(map['status'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }
  final String id;
  final String fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final PlatformUserRole role;
  final ProfessionalActivityStatus? professionalActivityStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'phone_number': phoneNumber,
      'role': userRoleToSql(role),
      'status': professionalActivityStatus != null
          ? professionalActivityStatusToSql(professionalActivityStatus!)
          : null,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }

  // Mapping to domain Profile model (models/Profile)
  /// TODO: add `toDomain & `fromDomain methods
}
