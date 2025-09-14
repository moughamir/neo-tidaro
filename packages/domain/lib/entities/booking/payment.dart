import '../../enums/enums.dart';
import '../base_entity.dart';

/// Payment entity for booking transactions
class Payment extends BaseEntity {

  /// Creates a new instance of [Payment].
  const Payment({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.bookingId,
    required this.amount,
    this.currency = 'USD',
    required this.method,
    this.status = PaymentStatus.pending,
    this.transactionId,
    this.paymentIntentId,
    this.processedAt,
    this.failureReason,
    this.metadata,
  });
  /// The ID of the booking this payment is for.
  final String bookingId;
  /// The amount of the payment.
  final double amount;
  /// The currency of the payment.
  final String currency;
  /// The payment method used.
  final PaymentMethod method;
  /// The status of the payment.
  final PaymentStatus status;
  /// The ID of the transaction.
  final String? transactionId;
  /// The ID of the payment intent.
  final String? paymentIntentId;
  /// The timestamp of when the payment was processed.
  final DateTime? processedAt;
  /// The reason for the payment failure.
  final String? failureReason;
  /// Additional metadata for the payment.
  final Map<String, dynamic>? metadata;

  /// Check if payment is successful
  bool get isSuccessful => status == PaymentStatus.completed;

  /// Check if payment failed
  bool get isFailed => status == PaymentStatus.failed;

  /// Check if payment can be refunded
  bool get canBeRefunded => status == PaymentStatus.completed;
}