// ============= SERVICE DTOs =============

import '../enums/rate_type.dart';
import '../enums/service_category.dart';

class CreateServiceDto {
  const CreateServiceDto({
    required this.professionalId,
    required this.category,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.rateType,
    required this.estimatedDuration,
    this.includedTasks = const [],
    this.requirements = const [],
  });
  final String professionalId;
  final PreBookingServiceCategory category;
  final String name;
  final String description;
  final double basePrice;
  final JobRateType rateType;
  final int estimatedDuration;
  final List<String> includedTasks;
  final List<String> requirements;

  Map<String, dynamic> toJson() => {
    'professional_id': professionalId,
    'category': category.name,
    'name': name,
    'description': description,
    'base_price': basePrice,
    'rate_type': rateType.name,
    'estimated_duration': estimatedDuration,
    'included_tasks': includedTasks,
    'requirements': requirements,
  };
}
