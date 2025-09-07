import 'package:shared/domain/domain.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.addressLine1,
    required super.city,
    required super.postalCode,
    required super.country,
    super.addressLine2,
    super.state,
    super.isPrimary,
  });
}
