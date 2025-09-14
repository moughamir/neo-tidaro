import 'package:domain/entities/base_entity.dart';
import 'package:domain/enums/rate_type.dart';
import 'package:domain/enums/service_category.dart';

/// Service entity for professional offerings
class Service extends BaseEntity {
  /// Creates a new instance of [Service].
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
  /// The ID of the professional offering the service.
  final String? professionalId;
  /// The category of the service.
  final PreBookingServiceCategory category;
  /// The name of the service.
  final String name;
  /// A description of the service.
  final String? description;
  /// The base price of the service.
  final double basePrice;
  /// The rate type of the service.
  final JobRateType rateType;
  /// The estimated duration of the service in minutes.
  final int estimatedDuration; // in minutes
  /// A list of tasks included in the service.
  final List<String> includedTasks;
  /// A list of requirements for the service.
  final List<String> requirements;
  /// Whether the service is active.
  final bool isActive;
}