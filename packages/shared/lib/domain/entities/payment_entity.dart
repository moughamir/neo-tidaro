import 'package:shared/domain/domain.dart';

abstract class PaymentEntity extends Entity {
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

  @override
  List<Object?> get props => [
    ...super.props,
    bookingId,
    amount,
    currency,
    status,
    paymentMethod,
    transactionId,
    refundAmount,
  ];
}
