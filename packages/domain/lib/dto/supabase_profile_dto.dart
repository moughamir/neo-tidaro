import '../mappers/mappers.dart';
import '../enums/enums.dart';

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
  /// TODO: add `toDomain & `fromDomain methods
}
