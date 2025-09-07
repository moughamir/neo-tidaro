import 'package:shared/domain/domain.dart';

class ServiceModel extends ServiceEntity {
  final List<String> providerIds;

  const ServiceModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.name,
    required super.description,
    required super.basePrice,
    required super.currency,
    required super.durationMinutes,
    required super.category,
    super.isActive,
    this.providerIds = const [],
  });

  @override
  List<Object?> get props => [...super.props, providerIds];
}
