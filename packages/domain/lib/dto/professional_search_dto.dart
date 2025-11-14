import '../enums/service_category.dart';
import '../enums/sort_by.dart';
import 'geo_location_dto.dart';

/// Data transfer object for searching for professionals.
class ProfessionalSearchDto {
  /// Creates a new instance of [ProfessionalSearchDto].
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
  /// The categories of services to search for.
  final List<PreBookingServiceCategory>? categories;
  /// The location to search near.
  final GeoLocationDto? location;
  /// The maximum distance to search in kilometers.
  final double? maxDistance;
  /// The minimum rating of professionals to search for.
  final double? minRating;
  /// The maximum hourly rate of professionals to search for.
  final double? maxHourlyRate;
  /// Whether to only search for professionals with instant booking.
  final bool? instantBooking;
  /// A search query to filter professionals by.
  final String? searchQuery;
  /// The field to sort the search results by.
  final PreBookingSortBy? sortBy;
  /// The page number to fetch.
  final int page;
  /// The number of items to fetch per page.
  final int limit;

  /// Creates a copy of this DTO with the given fields replaced with new values.
  ProfessionalSearchDto copyWith({
    List<PreBookingServiceCategory>? categories,
    GeoLocationDto? location,
    double? maxDistance,
    double? minRating,
    double? maxHourlyRate,
    bool? instantBooking,
    String? searchQuery,
    PreBookingSortBy? sortBy,
    int? page,
    int? limit,
  }) {
    return ProfessionalSearchDto(
      categories: categories ?? this.categories,
      location: location ?? this.location,
      maxDistance: maxDistance ?? this.maxDistance,
      minRating: minRating ?? this.minRating,
      maxHourlyRate: maxHourlyRate ?? this.maxHourlyRate,
      instantBooking: instantBooking ?? this.instantBooking,
      searchQuery: searchQuery ?? this.searchQuery,
      sortBy: sortBy ?? this.sortBy,
      page: page ?? this.page,
      limit: limit ?? this.limit,
    );
  }

  /// Converts the DTO to a JSON object.
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