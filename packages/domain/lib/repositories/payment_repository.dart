import 'package:domain/entities/payment.dart';
import 'package:domain/enums/payment.dart';

abstract class PaymentRepository {
  Future<Payment> findByBookingId(String bookingId);
  Future<Payment> create(Payment payment);
  Future<void> updateStatus(String id, PaymentStatus status);
}
