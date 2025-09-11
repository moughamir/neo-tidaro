import 'base_entity.dart';
import 'user_profile.dart';
import '../enums/enums.dart';

class User extends BaseEntity {
  final String email;
  final String? phoneNumber;
  final UserRole role;
  final UserStatus status;
  final UserProfile? profile;
  final VerificationStatus verificationStatus;
  final KycLevel kycLevel;
  final Map<String, dynamic>? metadata;

  const User({
    required super.id,
    required this.email,
    this.phoneNumber,
    required this.role,
    required this.status,
    this.profile,
    required this.verificationStatus,
    required this.kycLevel,
    required super.createdAt,
    required super.updatedAt,
    this.metadata,
  });
}
