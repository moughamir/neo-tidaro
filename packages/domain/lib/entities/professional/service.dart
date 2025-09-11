import '../base_entity.dart';
import '../../enums/enums.dart';

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
