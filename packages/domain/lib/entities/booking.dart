import '../enums/enums.dart';
import 'base_entity.dart';

/// Booking entity for service appointments
class Booking extends BaseEntity {
  final String clientId;
  final String professionalId;
  final String serviceId;
  final String? addressId;
  final BookingStatus status;
  final DateTime scheduledDate;
  final DateTime bookingTimeStart;
  final DateTime bookingTimeEnd;
  final int durationMinutes;
  final double? totalPrice;
  final String? locationAddress;
  final PaymentMethod? paymentMethod;
  final PaymentStatus? paymentStatus;
  final String? specialInstructions;
  final RecurrenceType? recurrence;
  final List<String> attachments;
  final DateTime? confirmedAt;
  final DateTime? completedAt;
  final String? cancellationReason;

  const Booking({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.clientId,
    required this.professionalId,
    required this.serviceId,
    this.addressId,
    required this.status,
    required this.scheduledDate,
    required this.bookingTimeStart,
    required this.bookingTimeEnd,
    required this.durationMinutes,
    this.totalPrice,
    this.locationAddress,
    this.paymentMethod,
    this.paymentStatus,
    this.specialInstructions,
    this.recurrence,
    this.attachments = const [],
    this.confirmedAt,
    this.completedAt,
    this.cancellationReason,
  });
}

abstract class BookingEntity extends BaseEntity {
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

  List<Object?> get props => [
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
