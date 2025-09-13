import '../enums/enums.dart';

BookingActivityStatus bookingStatusFromSql(String value) {
  switch (value) {
    case 'pending':
      return BookingActivityStatus.pending;
    case 'confirmed':
      return BookingActivityStatus.confirmed;
    case 'assigned':
      return BookingActivityStatus.assigned;
    case 'in_progress':
      return BookingActivityStatus.inProgress;
    case 'completed':
      return BookingActivityStatus.completed;
    case 'cancelled':
      return BookingActivityStatus.cancelled;
    case 'rescheduled':
      return BookingActivityStatus.rescheduled;
    default:
      // Fallback to pending
      return BookingActivityStatus.pending;
  }
}

String bookingStatusToSql(BookingActivityStatus value) {
  switch (value) {
    case BookingActivityStatus.pending:
      return 'pending';
    case BookingActivityStatus.confirmed:
      return 'confirmed';
    case BookingActivityStatus.assigned:
      return 'assigned';
    case BookingActivityStatus.inProgress:
      return 'in_progress';
    case BookingActivityStatus.completed:
      return 'completed';
    case BookingActivityStatus.cancelled:
      return 'cancelled';
    case BookingActivityStatus.rescheduled:
      return 'rescheduled';
    case BookingActivityStatus.noShow:
      // Not in DB – map to cancelled by policy
      return 'cancelled';
  }
}
