import 'package:domain/entities/user/user_profile.dart';

/// Client-specific profile
class ClientProfile extends UserProfile {
  /// Creates a new instance of [ClientProfile].
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

  /// A short biography of the client.
  final String? bio;

  /// The client's date of birth.
  final DateTime? dateOfBirth;

  /// The client's preferred language.
  final String? preferredLanguage;

  /// The client's preferred currency.
  final String? preferredCurrency;

  /// A list of languages spoken by the client.
  final List<String> spokenLanguages;

  /// A map of client-specific preferences.
  final Map<String, dynamic>? preferences;
}
