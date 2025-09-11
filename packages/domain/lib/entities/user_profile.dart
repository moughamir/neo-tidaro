import '../enums/enums.dart';
import '../value_objects/value_objects.dart';
import 'base_entity.dart';

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

/// Professional-specific profile
class ProfessionalProfile extends UserProfile {
  final List<ServiceCategory> categories;
  final double hourlyRate;
  final RateType defaultRateType;
  final String? businessName;
  final String? taxId;
  final double rating;
  final int totalReviews;
  final int completedJobs;
  final double serviceRadius;
  final bool isAvailable;
  final bool acceptsInstantBooking;
  final List<String> portfolioImages;
  final Map<String, dynamic>? skills;

  const ProfessionalProfile({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.email,
    super.fullName,
    super.phone,
    super.isPublic = true,
    super.isVerified,
    this.categories = const [],
    required this.hourlyRate,
    required this.defaultRateType,
    this.businessName,
    this.taxId,
    this.rating = 0.0,
    this.totalReviews = 0,
    this.completedJobs = 0,
    this.serviceRadius = 10.0,
    this.isAvailable = true,
    this.acceptsInstantBooking = false,
    this.portfolioImages = const [],
    this.skills,
  });
}

abstract class ProfileEntity extends Entity {
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final UserRole role;
  final bool isAvailable;

  const ProfileEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.avatarUrl,
    this.role = UserRole.clientConsumer,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    email,
    firstName,
    lastName,
    phoneNumber,
    dateOfBirth,
    avatarUrl,
    role,
    isAvailable,
  ];
}
