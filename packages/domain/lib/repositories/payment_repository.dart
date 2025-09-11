import '../entities/entities.dart';
import '../enums/enums.dart';

abstract class PaymentRepository {
  Future<Payment> findByBookingId(String bookingId);
  Future<Payment> create(Payment payment);
  Future<void> updateStatus(String id, PaymentStatus status);
}
