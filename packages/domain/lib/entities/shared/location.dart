import '../../enums/enums.dart';
import '../base_entity.dart';

/// Address entity for location management
class Address extends BaseEntity {
  /// Creates a new instance of [Address].
  const Address({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    this.userId,
    required this.type,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    this.latitude,
    this.longitude,
    this.isDefault = false,
    this.instructions,
  });
  /// The ID of the user this address belongs to.
  final String? userId;
  /// The type of address.
  final AddressType type;
  /// The street address.
  final String street;
  /// The city.
  final String city;
  /// The state or province.
  final String state;
  /// The country.
  final String country;
  /// The postal code.
  final String postalCode;
  /// The latitude of the address.
  final double? latitude;
  /// The longitude of the address.
  final double? longitude;
  /// Whether this is the user's default address.
  final bool isDefault;
  /// Any special instructions for the address.
  final String? instructions;
}

/// Geographic location value object
class GeoLocation {
  /// Creates a new instance of [GeoLocation].
  const GeoLocation({
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });
  /// The latitude of the location.
  final double latitude;
  /// The longitude of the location.
  final double longitude;
  /// The accuracy of the location in meters.
  final double? accuracy;

  /// Calculate distance to another location in kilometers using Haversine formula
  double distanceTo(GeoLocation other) {
    // Simple distance calculation - for production use a proper geospatial library
    final double latDiff = (other.latitude - latitude).abs();
    final double lngDiff = (other.longitude - longitude).abs();

    // Approximate distance using Pythagorean theorem (good for short distances)
    const double kmPerDegree = 111.0; // Approximate km per degree
    return ((latDiff * latDiff) + (lngDiff * lngDiff)) * kmPerDegree;
  }
}

/// Service area entity for professional coverage
class ServiceArea extends BaseEntity {
  /// Creates a new instance of [ServiceArea].
  const ServiceArea({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.professionalId,
    required this.name,
    required this.boundaries,
    this.travelFee,
    this.isActive = true,
  });
  /// The ID of the professional this service area belongs to.
  final String professionalId;
  /// The name of the service area.
  final String name;
  /// A list of geographic locations that define the boundaries of the service area.
  final List<GeoLocation> boundaries;
  /// The travel fee for this service area.
  final double? travelFee;
  /// Whether the service area is active.
  final bool isActive;
}