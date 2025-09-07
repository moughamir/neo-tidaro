import 'package:shared/domain/domain.dart';

class BookingModel extends BookingEntity {
  final ProfileModel? client;
  final ProfileModel? provider;
  final ServiceModel? service;
  final AddressModel? address;

  const BookingModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.clientId,
    required super.serviceId,
    required super.status,
    required super.scheduledDate,
    required super.durationMinutes,
    required super.totalPrice,
    super.providerId,
    super.addressId,
    super.specialInstructions,
    super.cancellationReason,
    this.client,
    this.provider,
    this.service,
    this.address,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    client,
    provider,
    service,
    address,
  ];
}
