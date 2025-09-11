import '../enums/enums.dart';

String paymentStatusToSql(PaymentStatus value) {
  switch (value) {
    case PaymentStatus.pending:
      return 'pending';
    case PaymentStatus.processing:
      return 'pending'; // no DB equivalent; treat as pending/in-flight
    case PaymentStatus.completed:
      return 'paid';
    case PaymentStatus.failed:
      return 'failed';
    case PaymentStatus.refunded:
      return 'refunded';
    case PaymentStatus.disputed:
      // TODO: Handle this case.
      throw UnimplementedError();
  }
}

PaymentStatus paymentStatusFromSql(String value) {
  switch (value) {
    case 'pending':
      return PaymentStatus.pending;
    case 'paid':
      return PaymentStatus.completed; // map DB 'paid' to domain 'completed'
    case 'failed':
      return PaymentStatus.failed;
    case 'refunded':
      return PaymentStatus.refunded;
    default:
      return PaymentStatus.pending;
  }
}
