import '../enums/enums.dart';
import 'base_entity.dart';

/// Payment entity for transaction management
class Payment extends BaseEntity {
  final String bookingId;
  final String payerId;
  final String payeeId;
  final double amount;
  final double platformFee;
  final double netAmount;
  final PaymentMethod method;
  final PaymentStatus status;
  final String? transactionId;
  final Map<String, dynamic>? metadata;

  const Payment({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.bookingId,
    required this.payerId,
    required this.payeeId,
    required this.amount,
    required this.platformFee,
    required this.netAmount,
    required this.method,
    required this.status,
    this.transactionId,
    this.metadata,
  });
}

abstract class PaymentEntity extends BaseEntity {
  final String bookingId;
  final double amount;
  final String currency;
  final PaymentStatus status;
  final String paymentMethod;
  final String? transactionId;
  final double? refundAmount;

  const PaymentEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.bookingId,
    required this.amount,
    required this.currency,
    required this.status,
    required this.paymentMethod,
    this.transactionId,
    this.refundAmount,
  });
}
