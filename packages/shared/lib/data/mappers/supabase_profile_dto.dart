import 'package:shared/data/mappers/cleaner_status_from_sql.dart';
import 'package:shared/data/mappers/cleaner_status_to_sql.dart';
import 'package:shared/data/mappers/user_role_from_sql.dart';
import 'package:shared/data/mappers/user_role_to_sql.dart';
import 'package:shared/domain/domain.dart';

class SupabaseProfileDto {
  final String id;
  final String fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final UserRole role;
  final CleanerStatus? cleanerStatus;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const SupabaseProfileDto({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    required this.role,
    this.cleanerStatus,
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
      cleanerStatus: map['status'] != null
          ? cleanerStatusFromSql(map['status'] as String)
          : null,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : null,
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'phone_number': phoneNumber,
      'role': userRoleToSql(role),
      'status': cleanerStatus != null
          ? cleanerStatusToSql(cleanerStatus!)
          : null,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    }..removeWhere((key, value) => value == null);
  }

  // Mapping to domain Profile model (models/Profile)
  Profile toDomain() {
    return Profile(
      id: id,
      fullName: fullName,
      avatarUrl: avatarUrl,
      phoneNumber: phoneNumber,
      role: role,
      cleanerStatus: cleanerStatus,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  static SupabaseProfileDto fromDomain(Profile profile) {
    return SupabaseProfileDto(
      id: profile.id,
      fullName: profile.fullName,
      avatarUrl: profile.avatarUrl,
      phoneNumber: profile.phoneNumber,
      role: profile.role,
      cleanerStatus: profile.cleanerStatus,
      createdAt: profile.createdAt,
      updatedAt: profile.updatedAt,
    );
  }
}
