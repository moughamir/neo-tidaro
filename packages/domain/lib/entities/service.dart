import '../enums/enums.dart';
import 'base_entity.dart';

/// Service entity for professional offerings
class Service extends BaseEntity {
  final String? professionalId;
  final ServiceCategory category;
  final String name;
  final String? description;
  final double basePrice;
  final RateType rateType;
  final int estimatedDuration; // in minutes
  final List<String> includedTasks;
  final List<String> requirements;
  final bool isActive;

  const Service({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    this.professionalId,
    required this.category,
    required this.name,
    this.description,
    required this.basePrice,
    required this.rateType,
    required this.estimatedDuration,
    this.includedTasks = const [],
    this.requirements = const [],
    this.isActive = true,
  });
}

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
