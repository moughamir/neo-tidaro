import 'package:shared/domain/domain.dart';

class PaymentModel extends PaymentEntity {
  const PaymentModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.bookingId,
    required super.amount,
    required super.currency,
    required super.status,
    required super.paymentMethod,
    super.transactionId,
    super.refundAmount,
  });
}
