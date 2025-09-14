// ============= LOCATION DTOs =============

import 'package:domain/enums/enums.dart';

import 'geo_location_dto.dart';

/// Data transfer object for creating an address.
class CreateAddressDto {
  /// Creates a new instance of [CreateAddressDto].
  const CreateAddressDto({
    required this.userId,
    required this.type,
    required this.street,
    this.apartment,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.location,
    this.instructions,
    this.isDefault = false,
  });
  /// The ID of the user who owns the address.
  final String userId;
  /// The type of address.
  final AddressType type;
  /// The street address.
  final String street;
  /// The apartment number.
  final String? apartment;
  /// The city.
  final String city;
  /// The state or province.
  final String state;
  /// The postal code.
  final String postalCode;
  /// The country.
  final String country;
  /// The geographic location of the address.
  final GeoLocationDto? location;
  /// Any special instructions for the address.
  final String? instructions;
  /// Whether this is the user's default address.
  final bool isDefault;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'type': type.name,
    'street': street,
    'apartment': apartment,
    'city': city,
    'state': state,
    'postal_code': postalCode,
    'country': country,
    'location': location?.toJson(),
    'instructions': instructions,
    'is_default': isDefault,
  };
}