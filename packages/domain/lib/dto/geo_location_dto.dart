// ============= GEOLOCATION DTO =============

class GeoLocationDto {
  final double latitude;
  final double longitude;
  final double? accuracy;

  const GeoLocationDto({
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'accuracy': accuracy,
  };

  factory GeoLocationDto.fromJson(Map<String, dynamic> json) => GeoLocationDto(
    latitude: json['latitude'],
    longitude: json['longitude'],
    accuracy: json['accuracy'],
  );
}
