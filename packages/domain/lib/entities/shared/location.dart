import '../base_entity.dart';
import '../../enums/enums.dart';

/// Address entity for location management
class Address extends BaseEntity {
  final String? userId;
  final AddressType type;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final double? latitude;
  final double? longitude;
  final bool isDefault;
  final String? instructions;

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
}

/// Geographic location value object
class GeoLocation {
  final double latitude;
  final double longitude;
  final double? accuracy;

  const GeoLocation({
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });

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
  final String professionalId;
  final String name;
  final List<GeoLocation> boundaries;
  final double? travelFee;
  final bool isActive;

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
}
