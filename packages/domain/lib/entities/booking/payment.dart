import '../base_entity.dart';
import '../../enums/enums.dart';

/// Payment entity for booking transactions
class Payment extends BaseEntity {
  final String bookingId;
  final double amount;
  final String currency;
  final PaymentMethod method;
  final PaymentStatus status;
  final String? transactionId;
  final String? paymentIntentId;
  final DateTime? processedAt;
  final String? failureReason;
  final Map<String, dynamic>? metadata;

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

  /// Check if payment is successful
  bool get isSuccessful => status == PaymentStatus.completed;

  /// Check if payment failed
  bool get isFailed => status == PaymentStatus.failed;

  /// Check if payment can be refunded
  bool get canBeRefunded => status == PaymentStatus.completed;
}
