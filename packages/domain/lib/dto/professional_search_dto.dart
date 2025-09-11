import '../enums/service_category.dart';
import '../enums/sort_by.dart';
import 'geo_location_dto.dart';

class ProfessionalSearchDto {
  final List<ServiceCategory>? categories;
  final GeoLocationDto? location;
  final double? maxDistance;
  final double? minRating;
  final double? maxHourlyRate;
  final bool? instantBooking;
  final String? searchQuery;
  final SortBy? sortBy;
  final int page;
  final int limit;

  const ProfessionalSearchDto({
    this.categories,
    this.location,
    this.maxDistance,
    this.minRating,
    this.maxHourlyRate,
    this.instantBooking,
    this.searchQuery,
    this.sortBy,
    this.page = 1,
    this.limit = 20,
  });

  Map<String, dynamic> toJson() => {
    if (categories != null)
      'categories': categories!.map((c) => c.name).toList(),
    if (location != null) 'location': location!.toJson(),
    if (maxDistance != null) 'max_distance': maxDistance,
    if (minRating != null) 'min_rating': minRating,
    if (maxHourlyRate != null) 'max_hourly_rate': maxHourlyRate,
    if (instantBooking != null) 'instant_booking': instantBooking,
    if (searchQuery != null) 'search': searchQuery,
    if (sortBy != null) 'sort_by': sortBy!.value,
    'page': page,
    'limit': limit,
  };
}
