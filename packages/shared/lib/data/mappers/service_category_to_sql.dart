import 'package:shared/domain/domain.dart';

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
  }
}
