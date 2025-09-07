import 'package:shared/domain/domain.dart';

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
  }
}
