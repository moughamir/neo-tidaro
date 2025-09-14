import '../../enums/enums.dart';
import '../base_entity.dart';

/// Represents a housekeeping service in the catalog
class Service extends BaseEntity {
  const Service({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.title,
    required this.description,
    required this.category,
    required this.basePriceMAD,
    required this.estimatedDurationHours,
    this.detailedDescription,
    this.requirements = const [],
    this.includes = const [],
    this.excludes = const [],
    this.imageUrls = const [],
    this.tags = const [],
    this.isActive = true,
    this.minimumBookingHours = 1,
    this.maximumBookingHours = 8,
  });

  /// Service title/name
  final String title;

  /// Short description of the service
  final String description;

  /// Detailed description with more information
  final String? detailedDescription;

  /// Service category
  final ServiceCategory category;

  /// Base price in Moroccan Dirham (MAD)
  final double basePriceMAD;

  /// Estimated duration in hours
  final int estimatedDurationHours;

  /// Special requirements for the service
  final List<String> requirements;

  /// What's included in the service
  final List<String> includes;

  /// What's excluded from the service
  final List<String> excludes;

  /// Service images
  final List<String> imageUrls;

  /// Service tags for filtering/search
  final List<String> tags;

  /// Whether the service is currently active
  final bool isActive;

  /// Minimum booking duration in hours
  final int minimumBookingHours;

  /// Maximum booking duration in hours
  final int maximumBookingHours;

  /// Get the main image URL or a placeholder
  String get mainImageUrl {
    if (imageUrls.isNotEmpty) {
      return imageUrls.first;
    }
    return _getPlaceholderImage();
  }

  /// Get placeholder image based on category
  String _getPlaceholderImage() {
    switch (category) {
      case ServiceCategory.generalCleaning:
        return 'assets/images/services/general_cleaning.jpg';
      case ServiceCategory.deepCleaning:
        return 'assets/images/services/deep_cleaning.jpg';
      case ServiceCategory.kitchenCleaning:
        return 'assets/images/services/kitchen_cleaning.jpg';
      case ServiceCategory.bathroomCleaning:
        return 'assets/images/services/bathroom_cleaning.jpg';
      case ServiceCategory.windowCleaning:
        return 'assets/images/services/window_cleaning.jpg';
      case ServiceCategory.floorCleaning:
        return 'assets/images/services/floor_cleaning.jpg';
      case ServiceCategory.laundryServices:
        return 'assets/images/services/laundry_services.jpg';
      case ServiceCategory.postConstruction:
        return 'assets/images/services/post_construction.jpg';
      case ServiceCategory.moveInOut:
        return 'assets/images/services/move_in_out.jpg';
      case ServiceCategory.officeCleaning:
        return 'assets/images/services/office_cleaning.jpg';
    }
  }

  /// Calculate price for a given duration
  double calculatePrice(int hours) {
    if (hours < minimumBookingHours) {
      hours = minimumBookingHours;
    } else if (hours > maximumBookingHours) {
      hours = maximumBookingHours;
    }

    // Simple linear pricing for now
    return basePriceMAD * (hours / estimatedDurationHours);
  }

  /// Check if service matches search query
  bool matchesSearch(String query) {
    final lowerQuery = query.toLowerCase();

    return title.toLowerCase().contains(lowerQuery) ||
           description.toLowerCase().contains(lowerQuery) ||
           (detailedDescription?.toLowerCase().contains(lowerQuery) ?? false) ||
           category.displayName.toLowerCase().contains(lowerQuery) ||
           tags.any((tag) => tag.toLowerCase().contains(lowerQuery));
  }

  Service copyWith({
    String? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? title,
    String? description,
    String? detailedDescription,
    ServiceCategory? category,
    double? basePriceMAD,
    int? estimatedDurationHours,
    List<String>? requirements,
    List<String>? includes,
    List<String>? excludes,
    List<String>? imageUrls,
    List<String>? tags,
    bool? isActive,
    int? minimumBookingHours,
    int? maximumBookingHours,
  }) {
    return Service(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      title: title ?? this.title,
      description: description ?? this.description,
      detailedDescription: detailedDescription ?? this.detailedDescription,
      category: category ?? this.category,
      basePriceMAD: basePriceMAD ?? this.basePriceMAD,
      estimatedDurationHours: estimatedDurationHours ?? this.estimatedDurationHours,
      requirements: requirements ?? this.requirements,
      includes: includes ?? this.includes,
      excludes: excludes ?? this.excludes,
      imageUrls: imageUrls ?? this.imageUrls,
      tags: tags ?? this.tags,
      isActive: isActive ?? this.isActive,
      minimumBookingHours: minimumBookingHours ?? this.minimumBookingHours,
      maximumBookingHours: maximumBookingHours ?? this.maximumBookingHours,
    );
  }
}
