// ============= PAYMENT DTOs =============

import '../enums/payment.dart';

/// Data transfer object for processing a payment.
class ProcessPaymentDto {

  /// Creates a new instance of [ProcessPaymentDto].
  const ProcessPaymentDto({
    required this.bookingId,
    required this.amount,
    required this.method,
    this.paymentDetails,
  });
  /// The ID of the booking to process the payment for.
  final String bookingId;
  /// The amount to process.
  final double amount;
  /// The payment method to use.
  final PaymentMethod method;
  /// Additional details for the payment.
  final Map<String, dynamic>? paymentDetails;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'booking_id': bookingId,
    'amount': amount,
    'method': method.name,
    'payment_details': paymentDetails,
  };
}