import 'profile.dart';

/// Client-specific profile extending UserProfile
class ClientProfile extends Profile {
  /// Creates a new instance of [ClientProfile].
  const ClientProfile({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.userId,
    super.isPublic,
    super.bio,
    super.dateOfBirth,
    super.preferredLanguage,
    super.profileSettings,
    this.preferredCurrency,
    this.spokenLanguages = const [],
    this.clientPreferences,
    this.loyaltyPoints = 0,
    this.membershipLevel,
  });

  /// The client's preferred currency code (e.g., 'USD', 'EUR', 'MAD').
  final String? preferredCurrency;

  /// A list of language codes spoken by the client.
  final List<String> spokenLanguages;

  /// Client-specific preferences and settings.
  final Map<String, dynamic>? clientPreferences;

  /// Loyalty points accumulated by the client.
  final int loyaltyPoints;

  /// Membership level (e.g., 'bronze', 'silver', 'gold', 'platinum').
  final String? membershipLevel;

  /// Creates a copy of this client profile with updated values.
  ClientProfile copyWith({
    bool? isPublic,
    String? bio,
    DateTime? dateOfBirth,
    String? preferredLanguage,
    Map<String, dynamic>? profileSettings,
    String? preferredCurrency,
    List<String>? spokenLanguages,
    Map<String, dynamic>? clientPreferences,
    int? loyaltyPoints,
    String? membershipLevel,
  }) {
    return ClientProfile(
      id: id,
      createdAt: createdAt!,
      updatedAt: DateTime.now(),
      userId: userId,
      isPublic: isPublic ?? this.isPublic,
      bio: bio ?? this.bio,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      preferredLanguage: preferredLanguage ?? this.preferredLanguage,
      profileSettings: profileSettings ?? this.profileSettings,
      preferredCurrency: preferredCurrency ?? this.preferredCurrency,
      spokenLanguages: spokenLanguages ?? this.spokenLanguages,
      clientPreferences: clientPreferences ?? this.clientPreferences,
      loyaltyPoints: loyaltyPoints ?? this.loyaltyPoints,
      membershipLevel: membershipLevel ?? this.membershipLevel,
    );
  }
}
