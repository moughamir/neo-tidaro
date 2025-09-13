// ============= LOCATION DTOs =============

import 'package:domain/enums/enums.dart';

import 'geo_location_dto.dart';

class CreateAddressDto {
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
  final String userId;
  final AddressType type;
  final String street;
  final String? apartment;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final GeoLocationDto? location;
  final String? instructions;
  final bool isDefault;

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
