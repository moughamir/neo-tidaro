import 'package:shared/domain/domain.dart';

BookingStatus bookingStatusFromSql(String value) {
  switch (value) {
    case 'pending':
      return BookingStatus.pending;
    case 'confirmed':
      return BookingStatus.confirmed;
    case 'assigned':
      return BookingStatus.assigned;
    case 'in_progress':
      return BookingStatus.inProgress;
    case 'completed':
      return BookingStatus.completed;
    case 'cancelled':
      return BookingStatus.cancelled;
    case 'rescheduled':
      return BookingStatus.rescheduled;
    default:
      // Fallback to pending
      return BookingStatus.pending;
  }
}
