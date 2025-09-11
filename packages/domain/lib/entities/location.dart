import '../enums/enums.dart';
import 'base_entity.dart';

/// Geographic location entity
class GeoLocation {
  final double latitude;
  final double longitude;
  final double? accuracy;
  final DateTime? timestamp;

  const GeoLocation({
    required this.latitude,
    required this.longitude,
    this.accuracy,
    this.timestamp,
  });
}

/// Address entity for location management
class Address extends BaseEntity {
  final String userId;
  final AddressType type;
  final String street;
  final String? apartment;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final GeoLocation? location;
  final String? instructions;
  final bool isDefault;

  const Address({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
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
}

abstract class AddressEntity extends BaseEntity {
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state;
  final String postalCode;
  final String country;
  final bool isPrimary;

  const AddressEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.addressLine1,
    required this.city,
    required this.postalCode,
    required this.country,
    this.addressLine2,
    this.state,
    this.isPrimary = false,
  });

  List<Object?> get props => [
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    isPrimary,
  ];
}
