import '../base_entity.dart';
import '../../enums/enums.dart';
import '../../value_objects/value_objects.dart';

/// Core user entity for authentication and basic identity
class User extends BaseEntity {
  final EmailVO email;
  final String? fullName;
  final PhoneVO? phone;
  final UserRole role;
  final UserStatus status;
  final DateTime? lastLoginAt;
  final DateTime? emailVerifiedAt;
  final DateTime? phoneVerifiedAt;

  const User({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.email,
    this.fullName,
    this.phone,
    this.role = UserRole.clientConsumer,
    this.status = UserStatus.active,
    this.lastLoginAt,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
  });

  bool get isEmailVerified => emailVerifiedAt != null;
  bool get isPhoneVerified => phoneVerifiedAt != null;
  bool get isVerified => isEmailVerified;
}
