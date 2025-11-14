import '../enums/enums.dart';

/// Data transfer object for creating a new user.
class CreateUserDto {
  /// Creates a new instance of [CreateUserDto].
  const CreateUserDto({
    required this.email,
    this.fullName,
    this.phone,
    this.avatarUrl,
    this.role = PlatformUserRole.clientConsumer,
    this.status = PlatformUserStatus.active,
    this.supabaseUserId,
    this.appMetadata,
    this.userMetadata,
  });

  /// The user's email address.
  final String email;

  /// The user's full name.
  final String? fullName;

  /// The user's phone number.
  final String? phone;

  /// The user's avatar URL.
  final String? avatarUrl;

  /// The user's role in the platform.
  final PlatformUserRole role;

  /// The user's status.
  final PlatformUserStatus status;

  /// The Supabase user ID (auth.users.id).
  final String? supabaseUserId;

  /// App metadata from Supabase auth.
  final Map<String, dynamic>? appMetadata;

  /// User metadata from Supabase auth.
  final Map<String, dynamic>? userMetadata;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'email': email,
    'full_name': fullName,
    'phone_number': phone,
    'avatar_url': avatarUrl,
    'role': role.name,
    'status': status.name,
    'supabase_user_id': supabaseUserId,
    'app_metadata': appMetadata,
    'user_metadata': userMetadata,
  };
}

/// Data transfer object for updating an existing user.
class UpdateUserDto {
  /// Creates a new instance of [UpdateUserDto].
  const UpdateUserDto({
    this.fullName,
    this.phone,
    this.avatarUrl,
    this.role,
    this.status,
    this.lastLoginAt,
    this.emailVerifiedAt,
    this.phoneVerifiedAt,
    this.appMetadata,
    this.userMetadata,
  });

  /// The user's full name.
  final String? fullName;

  /// The user's phone number.
  final String? phone;

  /// The user's avatar URL.
  final String? avatarUrl;

  /// The user's role in the platform.
  final PlatformUserRole? role;

  /// The user's status.
  final PlatformUserStatus? status;

  /// The timestamp of the user's last login.
  final DateTime? lastLoginAt;

  /// The timestamp of when the user's email was verified.
  final DateTime? emailVerifiedAt;

  /// The timestamp of when the user's phone number was verified.
  final DateTime? phoneVerifiedAt;

  /// App metadata from Supabase auth.
  final Map<String, dynamic>? appMetadata;

  /// User metadata from Supabase auth.
  final Map<String, dynamic>? userMetadata;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (fullName != null) json['full_name'] = fullName;
    if (phone != null) json['phone_number'] = phone;
    if (avatarUrl != null) json['avatar_url'] = avatarUrl;
    if (role != null) json['role'] = role!.name;
    if (status != null) json['status'] = status!.name;
    if (lastLoginAt != null)
      json['last_login_at'] = lastLoginAt!.toIso8601String();
    if (emailVerifiedAt != null)
      json['email_verified_at'] = emailVerifiedAt!.toIso8601String();
    if (phoneVerifiedAt != null)
      json['phone_verified_at'] = phoneVerifiedAt!.toIso8601String();
    if (appMetadata != null) json['app_metadata'] = appMetadata;
    if (userMetadata != null) json['user_metadata'] = userMetadata;
    return json;
  }
}

/// Data transfer object for creating a user profile.
class CreateUserProfileDto {
  /// Creates a new instance of [CreateUserProfileDto].
  const CreateUserProfileDto({
    required this.userId,
    this.isPublic = false,
    this.bio,
    this.dateOfBirth,
    this.preferredLanguage,
    this.profileSettings,
  });

  /// Reference to the associated User entity.
  final String userId;

  /// Whether the user's profile is public.
  final bool isPublic;

  /// A short biography or description.
  final String? bio;

  /// The user's date of birth.
  final DateTime? dateOfBirth;

  /// The user's preferred language code (e.g., 'en', 'fr', 'ar').
  final String? preferredLanguage;

  /// Profile-specific settings and preferences.
  final Map<String, dynamic>? profileSettings;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'is_public': isPublic,
    'bio': bio,
    'date_of_birth': dateOfBirth?.toIso8601String(),
    'preferred_language': preferredLanguage,
    'profile_settings': profileSettings,
  };
}

/// Data transfer object for updating a user profile.
class UpdateUserProfileDto {
  /// Creates a new instance of [UpdateUserProfileDto].
  const UpdateUserProfileDto({
    this.isPublic,
    this.bio,
    this.dateOfBirth,
    this.preferredLanguage,
    this.profileSettings,
  });

  /// Whether the user's profile is public.
  final bool? isPublic;

  /// A short biography or description.
  final String? bio;

  /// The user's date of birth.
  final DateTime? dateOfBirth;

  /// The user's preferred language code (e.g., 'en', 'fr', 'ar').
  final String? preferredLanguage;

  /// Profile-specific settings and preferences.
  final Map<String, dynamic>? profileSettings;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (isPublic != null) json['is_public'] = isPublic;
    if (bio != null) json['bio'] = bio;
    if (dateOfBirth != null)
      json['date_of_birth'] = dateOfBirth!.toIso8601String();
    if (preferredLanguage != null)
      json['preferred_language'] = preferredLanguage;
    if (profileSettings != null) json['profile_settings'] = profileSettings;
    return json;
  }
}
