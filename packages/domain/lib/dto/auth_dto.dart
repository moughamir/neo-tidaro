import 'package:domain/enums/enums.dart';

import 'geo_location_dto.dart';

/// Data transfer object for OAuth sign-in.
class OAuthSignInDto {
  /// Creates a new instance of [OAuthSignInDto].
  const OAuthSignInDto({required this.provider, this.redirectUrl, this.scopes});
  /// The OAuth provider.
  final AuthProvider provider;
  /// The URL to redirect to after sign-in.
  final String? redirectUrl;
  /// The scopes to request from the OAuth provider.
  final Map<String, String>? scopes;
}

/// DTOs for API Communication
/// Optimized for Supabase GoTrue Auth integration

// ============= AUTH DTOs =============

/// Data transfer object for user sign-up.
class SignUpDto {
  /// Creates a new instance of [SignUpDto].
  const SignUpDto({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.phoneNumber,
    this.metadata,
  });
  /// The user's email address.
  final String email;
  /// The user's password.
  final String password;
  /// The user's first name.
  final String firstName;
  /// The user's last name.
  final String lastName;
  /// The user's role.
  final PlatformUserRole role;
  /// The user's phone number.
  final String? phoneNumber;
  /// Additional metadata for the user.
  final Map<String, dynamic>? metadata;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'data': {
      'first_name': firstName,
      'last_name': lastName,
      'role': role.name,
      'phone_number': phoneNumber,
      ...?metadata,
    },
  };
}

/// Data transfer object for user sign-in.
class SignInDto {
  /// Creates a new instance of [SignInDto].
  const SignInDto({required this.email, required this.password});
  /// The user's email address.
  final String email;
  /// The user's password.
  final String password;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

/// Data transfer object for professional registration.
class ProfessionalRegistrationDto {
  /// Creates a new instance of [ProfessionalRegistrationDto].
  const ProfessionalRegistrationDto({
    required this.userId,
    required this.categories,
    required this.hourlyRate,
    this.businessName,
    this.taxId,
    this.serviceRadius = 10.0,
    this.location,
    this.skills,
  });
  /// The user ID of the professional.
  final String userId;
  /// The categories of services offered by the professional.
  final List<PreBookingServiceCategory> categories;
  /// The hourly rate of the professional.
  final double hourlyRate;
  /// The business name of the professional.
  final String? businessName;
  /// The tax ID of the professional.
  final String? taxId;
  /// The service radius of the professional in kilometers.
  final double serviceRadius;
  /// The location of the professional.
  final GeoLocationDto? location;
  /// The skills of the professional.
  final Map<String, dynamic>? skills;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'categories': categories.map((c) => c.name).toList(),
    'hourly_rate': hourlyRate,
    'business_name': businessName,
    'tax_id': taxId,
    'service_radius': serviceRadius,
    'location': location?.toJson(),
    'skills': skills,
  };
}