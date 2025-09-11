import '../base_entity.dart';
import '../../value_objects/value_objects.dart';

/// Base profile for all user types
abstract class UserProfile extends BaseEntity {
  final EmailVO email;
  final String? fullName;
  final PhoneVO? phone;
  final bool isPublic;
  final bool isVerified;

  const UserProfile({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.email,
    this.fullName,
    this.phone,
    this.isPublic = false,
    this.isVerified = false,
  });
}

/// Client-specific profile
class ClientProfile extends UserProfile {
  final String? bio;
  final DateTime? dateOfBirth;
  final String? preferredLanguage;
  final String? preferredCurrency;
  final List<String> spokenLanguages;
  final Map<String, dynamic>? preferences;

  const ClientProfile({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.email,
    super.fullName,
    super.phone,
    super.isPublic,
    super.isVerified,
    this.bio,
    this.dateOfBirth,
    this.preferredLanguage,
    this.preferredCurrency,
    this.spokenLanguages = const [],
    this.preferences,
  });
}
