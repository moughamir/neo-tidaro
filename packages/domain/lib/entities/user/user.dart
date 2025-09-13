import '../../enums/enums.dart';
import '../../value_objects/value_objects.dart';
import '../base_entity.dart';

/// Core user entity for authentication and basic identity
class User extends BaseEntity {
  const User({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.email,
    this.fullName,
    this.phone,
    this.role = PlatformUserRole.clientConsumer,
    this.status = PlatformUserStatus.active,
    this.lastLoginAt,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
  });
  final EmailVO email;
  final String? fullName;
  final PhoneVO? phone;
  final PlatformUserRole role;
  final PlatformUserStatus status;
  final DateTime? lastLoginAt;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;

  bool get isEmailVerified => emailVerifiedAt != null;
  bool get isPhoneVerified => phoneVerifiedAt != null;
  bool get isVerified => isEmailVerified;
}
