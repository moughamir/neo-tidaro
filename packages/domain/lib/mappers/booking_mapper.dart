import '../enums/enums.dart';

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
