import '../enums/service_category.dart';

String serviceCategoryToSql(PreBookingServiceCategory value) {
  switch (value) {
    case PreBookingServiceCategory.standardCleaning:
      return 'standard_cleaning';
    case PreBookingServiceCategory.regularCleaning:
      return 'regular_cleaning';
    case PreBookingServiceCategory.deepCleaning:
      return 'deep_cleaning';
    case PreBookingServiceCategory.moveInOut:
      return 'move_in_out';
    case PreBookingServiceCategory.postConstruction:
      return 'post_construction';
    case PreBookingServiceCategory.commercial:
      return 'commercial';
    case PreBookingServiceCategory.residential:
      return 'residential';
    case PreBookingServiceCategory.specialized:
      return 'specialized';
    case PreBookingServiceCategory.cleaning:
      return 'cleaning';
    case PreBookingServiceCategory.laundry:
      return 'laundry';
    case PreBookingServiceCategory.cooking:
      return 'cooking';
    case PreBookingServiceCategory.babysitting:
      return 'babysitting';
    case PreBookingServiceCategory.petCare:
      return 'pet_care';
    case PreBookingServiceCategory.gardening:
      return 'gardening';
    case PreBookingServiceCategory.maintenance:
      return 'maintenance';
    case PreBookingServiceCategory.organization:
      return 'organization';
    case PreBookingServiceCategory.other:
      return 'other';
  }
}

PreBookingServiceCategory serviceCategoryFromSql(String value) {
  switch (value) {
    case 'standard_cleaning':
      return PreBookingServiceCategory.standardCleaning;
    case 'regular_cleaning':
      return PreBookingServiceCategory.regularCleaning;
    case 'deep_cleaning':
      return PreBookingServiceCategory.deepCleaning;
    case 'move_in_out':
      return PreBookingServiceCategory.moveInOut;
    case 'post_construction':
      return PreBookingServiceCategory.postConstruction;
    case 'commercial':
      return PreBookingServiceCategory.commercial;
    case 'residential':
      return PreBookingServiceCategory.residential;
    case 'specialized':
      return PreBookingServiceCategory.specialized;
    default:
      return PreBookingServiceCategory.standardCleaning;
  }
}
