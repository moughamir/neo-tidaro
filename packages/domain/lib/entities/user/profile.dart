import '../base_entity.dart';

/// Base profile for all user types
/// This extends the core User entity with profile-specific information
abstract class Profile extends BaseEntity {
  /// Creates a new instance of [Profile].
  const Profile({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
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

  /// Calculate age from date of birth.
  int? get age {
    if (dateOfBirth == null) return null;
    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }
    return age;
  }
}
