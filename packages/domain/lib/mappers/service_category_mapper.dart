import 'package:domain/enums/service_category.dart';

String serviceCategoryToSql(ServiceCategory value) {
  switch (value) {
    case ServiceCategory.standardCleaning:
      return 'standard_cleaning';
    case ServiceCategory.regularCleaning:
      return 'regular_cleaning';
    case ServiceCategory.deepCleaning:
      return 'deep_cleaning';
    case ServiceCategory.moveInOut:
      return 'move_in_out';
    case ServiceCategory.postConstruction:
      return 'post_construction';
    case ServiceCategory.commercial:
      return 'commercial';
    case ServiceCategory.residential:
      return 'residential';
    case ServiceCategory.specialized:
      return 'specialized';
    case ServiceCategory.cleaning:
      return 'cleaning';
    case ServiceCategory.laundry:
      return 'laundry';
    case ServiceCategory.cooking:
      return 'cooking';
    case ServiceCategory.babysitting:
      return 'babysitting';
    case ServiceCategory.petCare:
      return 'pet_care';
    case ServiceCategory.gardening:
      return 'gardening';
    case ServiceCategory.maintenance:
      return 'maintenance';
    case ServiceCategory.organization:
      return 'organization';
    case ServiceCategory.other:
      return 'other';
  }
}

ServiceCategory serviceCategoryFromSql(String value) {
  switch (value) {
    case 'standard_cleaning':
      return ServiceCategory.standardCleaning;
    case 'regular_cleaning':
      return ServiceCategory.regularCleaning;
    case 'deep_cleaning':
      return ServiceCategory.deepCleaning;
    case 'move_in_out':
      return ServiceCategory.moveInOut;
    case 'post_construction':
      return ServiceCategory.postConstruction;
    case 'commercial':
      return ServiceCategory.commercial;
    case 'residential':
      return ServiceCategory.residential;
    case 'specialized':
      return ServiceCategory.specialized;
    default:
      return ServiceCategory.standardCleaning;
  }
}
