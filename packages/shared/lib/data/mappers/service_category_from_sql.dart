import 'package:shared/domain/domain.dart';

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
