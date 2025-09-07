import 'package:shared/domain/domain.dart';

abstract class ServiceEntity extends Entity {
  final String name;
  final String description;
  final double basePrice;
  final String currency;
  final int durationMinutes;
  final String category;
  final bool isActive;

  const ServiceEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.currency,
    required this.durationMinutes,
    required this.category,
    this.isActive = true,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    name,
    description,
    basePrice,
    currency,
    durationMinutes,
    category,
    isActive,
  ];
}
