/// Categories of housekeeping services available in Tidaro
enum ServiceCategory {
  /// General house cleaning services
  generalCleaning,
  
  /// Deep/thorough cleaning services  
  deepCleaning,
  
  /// Kitchen-specific cleaning
  kitchenCleaning,
  
  /// Bathroom and toilet cleaning
  bathroomCleaning,
  
  /// Window and glass cleaning
  windowCleaning,
  
  /// Floor cleaning and maintenance
  floorCleaning,
  
  /// Laundry and ironing services
  laundryServices,
  
  /// Post-construction or renovation cleaning
  postConstruction,
  
  /// Moving in/out cleaning
  moveInOut,
  
  /// Office/commercial space cleaning
  officeCleaning,
}

extension ServiceCategoryExtension on ServiceCategory {
  /// Get display name for the service category
  String get displayName {
    switch (this) {
      case ServiceCategory.generalCleaning:
        return 'General House Cleaning';
      case ServiceCategory.deepCleaning:
        return 'Deep Cleaning';
      case ServiceCategory.kitchenCleaning:
        return 'Kitchen Cleaning';
      case ServiceCategory.bathroomCleaning:
        return 'Bathroom Cleaning';
      case ServiceCategory.windowCleaning:
        return 'Window Cleaning';
      case ServiceCategory.floorCleaning:
        return 'Floor Cleaning';
      case ServiceCategory.laundryServices:
        return 'Laundry & Ironing';
      case ServiceCategory.postConstruction:
        return 'Post-Construction Cleaning';
      case ServiceCategory.moveInOut:
        return 'Move In/Out Cleaning';
      case ServiceCategory.officeCleaning:
        return 'Office Cleaning';
    }
  }

  /// Get short description for the service category
  String get description {
    switch (this) {
      case ServiceCategory.generalCleaning:
        return 'Regular house cleaning and maintenance';
      case ServiceCategory.deepCleaning:
        return 'Thorough cleaning for every corner';
      case ServiceCategory.kitchenCleaning:
        return 'Kitchen appliances, counters, and cabinets';
      case ServiceCategory.bathroomCleaning:
        return 'Bathroom, toilet, and shower cleaning';
      case ServiceCategory.windowCleaning:
        return 'Interior and exterior window cleaning';
      case ServiceCategory.floorCleaning:
        return 'Mopping, vacuuming, and floor maintenance';
      case ServiceCategory.laundryServices:
        return 'Washing, drying, and ironing clothes';
      case ServiceCategory.postConstruction:
        return 'Cleanup after construction or renovation';
      case ServiceCategory.moveInOut:
        return 'Complete cleaning for moving';
      case ServiceCategory.officeCleaning:
        return 'Professional office space cleaning';
    }
  }

  /// Get estimated duration in hours for the service
  int get estimatedHours {
    switch (this) {
      case ServiceCategory.generalCleaning:
        return 3;
      case ServiceCategory.deepCleaning:
        return 6;
      case ServiceCategory.kitchenCleaning:
        return 2;
      case ServiceCategory.bathroomCleaning:
        return 1;
      case ServiceCategory.windowCleaning:
        return 2;
      case ServiceCategory.floorCleaning:
        return 2;
      case ServiceCategory.laundryServices:
        return 4;
      case ServiceCategory.postConstruction:
        return 8;
      case ServiceCategory.moveInOut:
        return 5;
      case ServiceCategory.officeCleaning:
        return 4;
    }
  }

  /// Get base price in MAD (Moroccan Dirham)
  double get basePriceMAD {
    switch (this) {
      case ServiceCategory.generalCleaning:
        return 150.0; // 150 MAD
      case ServiceCategory.deepCleaning:
        return 300.0; // 300 MAD
      case ServiceCategory.kitchenCleaning:
        return 100.0; // 100 MAD
      case ServiceCategory.bathroomCleaning:
        return 80.0;  // 80 MAD
      case ServiceCategory.windowCleaning:
        return 120.0; // 120 MAD
      case ServiceCategory.floorCleaning:
        return 90.0;  // 90 MAD
      case ServiceCategory.laundryServices:
        return 80.0;  // 80 MAD
      case ServiceCategory.postConstruction:
        return 500.0; // 500 MAD
      case ServiceCategory.moveInOut:
        return 400.0; // 400 MAD
      case ServiceCategory.officeCleaning:
        return 200.0; // 200 MAD
    }
  }
}

// Legacy enum for backwards compatibility
enum PreBookingServiceCategory {
  cleaning,
  standardCleaning,
  regularCleaning,
  laundry,
  cooking,
  babysitting,
  petCare,
  gardening,
  maintenance,
  organization,
  deepCleaning,
  moveInOut,
  postConstruction,
  commercial,
  residential,
  specialized,
  other,
}
