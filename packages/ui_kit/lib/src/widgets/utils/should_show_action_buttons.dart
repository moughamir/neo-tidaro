import 'package:domain/domain.dart';

bool shouldShowActionButtons(BookingStatus status) {
  return status == BookingStatus.pending ||
      status == BookingStatus.confirmed ||
      status == BookingStatus.assigned ||
      status == BookingStatus.inProgress;
}
