import 'package:shared/domain/domain.dart';

String bookingStatusToSql(BookingStatus value) {
  switch (value) {
    case BookingStatus.pending:
      return 'pending';
    case BookingStatus.confirmed:
      return 'confirmed';
    case BookingStatus.assigned:
      return 'assigned';
    case BookingStatus.inProgress:
      return 'in_progress';
    case BookingStatus.completed:
      return 'completed';
    case BookingStatus.cancelled:
      return 'cancelled';
    case BookingStatus.rescheduled:
      return 'rescheduled';
    case BookingStatus.noShow:
      // Not in DB – map to cancelled by policy
      return 'cancelled';
  }
}
