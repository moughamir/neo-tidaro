import '../../enums/enums.dart';
import '../../value_objects/value_objects.dart';
import 'user_profile.dart';

/// Professional-specific profile extending UserProfile
class ProfessionalProfile extends UserProfile {
  /// Creates a new instance of [ProfessionalProfile].
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
    this.avatarUrl,
    this.role = PlatformUserRole.clientProfessional,
    this.status = ProfessionalKycStatus.pending,
    this.certifications = const [],
    this.licenseNumber,
    this.licenseExpiry,
    this.backgroundCheckCompleted = false,
    this.backgroundCheckDate,
    this.serviceAreas = const [],
    this.professionalSettings,
  });

  /// The categories of services offered by the professional.
  final List<PreBookingServiceCategory> categories;

  /// The hourly rate of the professional.
  final double hourlyRate;

  /// The default rate type of the professional.
  final JobRateType defaultRateType;

  /// The business name of the professional.
  final String? businessName;

  /// The tax ID of the professional.
  final String? taxId;

  /// The average rating of the professional.
  final double rating;

  /// The total number of reviews for the professional.
  final int totalReviews;

  /// The total number of completed jobs for the professional.
  final int completedJobs;

  /// The service radius of the professional in kilometers.
  final double serviceRadius;

  /// Whether the professional is available for new bookings.
  final bool isAvailable;

  /// Whether the professional accepts instant bookings.
  final bool acceptsInstantBooking;

  /// A list of portfolio image URLs for the professional.
  final List<String> portfolioImages;

  /// A map of skills for the professional.
  final Map<String, dynamic>? skills;

  /// The URL of the professional's avatar.
  final String? avatarUrl;

  /// The role of the professional.
  final PlatformUserRole role;

  // Professional-specific fields
  /// The KYC status of the professional.
  final ProfessionalKycStatus status;

  /// A list of certifications for the professional.
  final List<String> certifications;

  /// The license number of the professional.
  final String? licenseNumber;

  /// The expiry date of the professional's license.
  final DateTime? licenseExpiry;

  /// Whether the professional has completed a background check.
  final bool backgroundCheckCompleted;

  /// The date of the professional's background check.
  final DateTime? backgroundCheckDate;

  /// A list of service areas for the professional.
  final List<String> serviceAreas;

  /// A map of professional-specific settings.
  final Map<String, dynamic>? professionalSettings;

  /// Calculate professional score based on rating and completion rate
  double get professionalScore {
    if (totalReviews == 0) return 0.0;
    final completionRate = completedJobs > 0
        ? completedJobs / (completedJobs + 1)
        : 0.0;
    return (rating * 0.7) + (completionRate * 0.3);
  }

  /// Check if professional is fully verified
  bool get isFullyVerified {
    return isVerified &&
        backgroundCheckCompleted &&
        status == ProfessionalKycStatus.active;
  }

  /// Creates a new instance of [ProfessionalProfile] with updated values.
  ProfessionalProfile copyWith({
    String? fullName,
    PhoneVO? phone,
    bool? isPublic,
    bool? isVerified,
    List<PreBookingServiceCategory>? categories,
    double? hourlyRate,
    JobRateType? defaultRateType,
    String? businessName,
    String? taxId,
    double? rating,
    int? totalReviews,
    int? completedJobs,
    double? serviceRadius,
    bool? isAvailable,
    bool? acceptsInstantBooking,
    List<String>? portfolioImages,
    Map<String, dynamic>? skills,
    String? avatarUrl,
    PlatformUserRole? role,
    ProfessionalKycStatus? status,
    List<String>? certifications,
    String? licenseNumber,
    DateTime? licenseExpiry,
    bool? backgroundCheckCompleted,
    DateTime? backgroundCheckDate,
    List<String>? serviceAreas,
    Map<String, dynamic>? professionalSettings,
  }) {
    return ProfessionalProfile(
      id: id,
      createdAt: createdAt!,
      updatedAt: DateTime.now(),
      email: email,
      fullName: fullName ?? this.fullName,
      phone: phone ?? this.phone,
      isPublic: isPublic ?? this.isPublic,
      isVerified: isVerified ?? this.isVerified,
      categories: categories ?? this.categories,
      hourlyRate: hourlyRate ?? this.hourlyRate,
      defaultRateType: defaultRateType ?? this.defaultRateType,
      businessName: businessName ?? this.businessName,
      taxId: taxId ?? this.taxId,
      rating: rating ?? this.rating,
      totalReviews: totalReviews ?? this.totalReviews,
      completedJobs: completedJobs ?? this.completedJobs,
      serviceRadius: serviceRadius ?? this.serviceRadius,
      isAvailable: isAvailable ?? this.isAvailable,
      acceptsInstantBooking:
          acceptsInstantBooking ?? this.acceptsInstantBooking,
      portfolioImages: portfolioImages ?? this.portfolioImages,
      skills: skills ?? this.skills,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      status: status ?? this.status,
      certifications: certifications ?? this.certifications,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      licenseExpiry: licenseExpiry ?? this.licenseExpiry,
      backgroundCheckCompleted:
          backgroundCheckCompleted ?? this.backgroundCheckCompleted,
      backgroundCheckDate: backgroundCheckDate ?? this.backgroundCheckDate,
      serviceAreas: serviceAreas ?? this.serviceAreas,
      professionalSettings: professionalSettings ?? this.professionalSettings,
    );
  }
}
