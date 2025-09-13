// ============= PAYMENT DTOs =============

import '../enums/payment.dart';

class ProcessPaymentDto {

  const ProcessPaymentDto({
    required this.bookingId,
    required this.amount,
    required this.method,
    this.paymentDetails,
  });
  final String bookingId;
  final double amount;
  final PaymentMethod method;
  final Map<String, dynamic>? paymentDetails;

  Map<String, dynamic> toJson() => {
    'booking_id': bookingId,
    'amount': amount,
    'method': method.name,
    'payment_details': paymentDetails,
  };
}
