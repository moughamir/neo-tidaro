import '../../value_objects/value_objects.dart';
import '../base_entity.dart';

/// Base profile for all user types
abstract class UserProfile extends BaseEntity {
  /// Creates a new instance of [UserProfile].
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
  /// The user's email address.
  final EmailVO email;
  /// The user's full name.
  final String? fullName;
  /// The user's phone number.
  final PhoneVO? phone;
  /// Whether the user's profile is public.
  final bool isPublic;
  /// Whether the user is verified.
  final bool isVerified;
}

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