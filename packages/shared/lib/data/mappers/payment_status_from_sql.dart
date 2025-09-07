import 'package:shared/domain/domain.dart';

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
