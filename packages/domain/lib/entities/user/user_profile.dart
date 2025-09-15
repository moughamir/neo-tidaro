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
