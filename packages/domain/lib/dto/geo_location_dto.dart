// ============= GEOLOCATION DTO =============

/// Data transfer object for geographic coordinates.
class GeoLocationDto {

  /// Creates a new instance of [GeoLocationDto].
  const GeoLocationDto({
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });

  /// Creates a new instance of [GeoLocationDto] from a JSON object.
  factory GeoLocationDto.fromJson(Map<String, dynamic> json) => GeoLocationDto(
    latitude: json['latitude'],
    longitude: json['longitude'],
    accuracy: json['accuracy'],
  );
  /// The latitude of the location.
  final double latitude;
  /// The longitude of the location.
  final double longitude;
  /// The accuracy of the location in meters.
  final double? accuracy;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'accuracy': accuracy,
  };
}