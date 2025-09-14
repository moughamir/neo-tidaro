// ============= SERVICE DTOs =============

import '../enums/rate_type.dart';
import '../enums/service_category.dart';

/// Data transfer object for creating a service.
class CreateServiceDto {
  /// Creates a new instance of [CreateServiceDto].
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
  /// The ID of the professional offering the service.
  final String professionalId;
  /// The category of the service.
  final PreBookingServiceCategory category;
  /// The name of the service.
  final String name;
  /// A description of the service.
  final String description;
  /// The base price of the service.
  final double basePrice;
  /// The rate type of the service.
  final JobRateType rateType;
  /// The estimated duration of the service in minutes.
  final int estimatedDuration;
  /// A list of tasks included in the service.
  final List<String> includedTasks;
  /// A list of requirements for the service.
  final List<String> requirements;

  /// Converts the DTO to a JSON object.
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