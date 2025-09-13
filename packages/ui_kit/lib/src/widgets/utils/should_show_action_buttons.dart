import 'package:domain/domain.dart';

bool shouldShowActionButtons(BookingActivityStatus status) {
  return status == BookingActivityStatus.pending ||
      status == BookingActivityStatus.confirmed ||
      status == BookingActivityStatus.assigned ||
      status == BookingActivityStatus.inProgress;
}
