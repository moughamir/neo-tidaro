import 'package:shared/domain/domain.dart';

abstract class AddressEntity extends Entity {
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state;
  final String postalCode;
  final String country;
  final bool isPrimary;

  const AddressEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.addressLine1,
    required this.city,
    required this.postalCode,
    required this.country,
    this.addressLine2,
    this.state,
    this.isPrimary = false,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    addressLine1,
    addressLine2,
    city,
    state,
    postalCode,
    country,
    isPrimary,
  ];
}
