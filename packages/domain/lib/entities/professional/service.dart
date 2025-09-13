import 'package:domain/entities/base_entity.dart';
import 'package:domain/enums/rate_type.dart';
import 'package:domain/enums/service_category.dart';

/// Service entity for professional offerings
class Service extends BaseEntity {
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
  final String? professionalId;
  final PreBookingServiceCategory category;
  final String name;
  final String? description;
  final double basePrice;
  final JobRateType rateType;
  final int estimatedDuration; // in minutes
  final List<String> includedTasks;
  final List<String> requirements;
  final bool isActive;
}
