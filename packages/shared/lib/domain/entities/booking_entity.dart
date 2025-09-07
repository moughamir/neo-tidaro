import 'package:shared/domain/domain.dart';

abstract class BookingEntity extends Entity {
  final String clientId;
  final String? providerId;
  final String serviceId;
  final String? addressId;
  final BookingStatus status;
  final DateTime scheduledDate;
  final int durationMinutes;
  final double totalPrice;
  final String? specialInstructions;
  final String? cancellationReason;

  const BookingEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.clientId,
    required this.serviceId,
    required this.status,
    required this.scheduledDate,
    required this.durationMinutes,
    required this.totalPrice,
    this.providerId,
    this.addressId,
    this.specialInstructions,
    this.cancellationReason,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    clientId,
    providerId,
    serviceId,
    addressId,
    status,
    scheduledDate,
    durationMinutes,
    totalPrice,
    specialInstructions,
    cancellationReason,
  ];
}
