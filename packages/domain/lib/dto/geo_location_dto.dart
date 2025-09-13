// ============= GEOLOCATION DTO =============

class GeoLocationDto {

  const GeoLocationDto({
    required this.latitude,
    required this.longitude,
    this.accuracy,
  });

  factory GeoLocationDto.fromJson(Map<String, dynamic> json) => GeoLocationDto(
    latitude: json['latitude'],
    longitude: json['longitude'],
    accuracy: json['accuracy'],
  );
  final double latitude;
  final double longitude;
  final double? accuracy;

  Map<String, dynamic> toJson() => {
    'latitude': latitude,
    'longitude': longitude,
    'accuracy': accuracy,
  };
}
