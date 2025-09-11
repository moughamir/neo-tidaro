import '../enums/service_category.dart';
import '../enums/user_role.dart';

import '../enums/auth_provider.dart';
import 'geo_location_dto.dart';

class OAuthSignInDto {
  final AuthProvider provider;
  final String? redirectUrl;
  final Map<String, String>? scopes;

  const OAuthSignInDto({required this.provider, this.redirectUrl, this.scopes});
}

/// DTOs for API Communication
/// Optimized for Supabase GoTrue Auth integration

// ============= AUTH DTOs =============

class SignUpDto {
  final String email;
  final String password;
  final String firstName;
  final String lastName;
  final UserRole role;
  final String? phoneNumber;
  final Map<String, dynamic>? metadata;

  const SignUpDto({
    required this.email,
    required this.password,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.phoneNumber,
    this.metadata,
  });

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

class SignInDto {
  final String email;
  final String password;

  const SignInDto({required this.email, required this.password});

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

class ProfessionalRegistrationDto {
  final String userId;
  final List<ServiceCategory> categories;
  final double hourlyRate;
  final String? businessName;
  final String? taxId;
  final double serviceRadius;
  final GeoLocationDto? location;
  final Map<String, dynamic>? skills;

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
