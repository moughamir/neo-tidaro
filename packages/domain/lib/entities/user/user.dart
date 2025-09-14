import '../../enums/enums.dart';
import '../../value_objects/value_objects.dart';
import '../base_entity.dart';

/// Core user entity for authentication and basic identity
class User extends BaseEntity {
  /// Creates a new instance of [User].
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
  /// The user's email address.
  final EmailVO email;
  /// The user's full name.
  final String? fullName;
  /// The user's phone number.
  final PhoneVO? phone;
  /// The user's role.
  final PlatformUserRole role;
  /// The user's status.
  final PlatformUserStatus status;
  /// The timestamp of the user's last login.
  final DateTime? lastLoginAt;
  /// The timestamp of when the user's email was verified.
  final DateTime? emailVerifiedAt;
  /// The timestamp of when the user's phone number was verified.
  final DateTime? phoneVerifiedAt;

  /// Whether the user's email is verified.
  bool get isEmailVerified => emailVerifiedAt != null;
  /// Whether the user's phone number is verified.
  bool get isPhoneVerified => phoneVerifiedAt != null;
  /// Whether the user is verified.
  bool get isVerified => isEmailVerified;
}