import 'package:shared/shared.dart';

class AdminBookingsViewModel {
  AdminBookingsViewModel({
    required this.isLoading,
    required this.bookings,
    required this.updateStatus,
  });

  final bool isLoading;
  final List<Booking> bookings;
  final void Function(String bookingId, BookingActivityStatus status) updateStatus;

  static AdminBookingsViewModel fromStore(Store<AppState> store) {
    final s = store.state.bookingState;
    final list = s.data.fold(() => <Booking>[], (b) => b);
    return AdminBookingsViewModel(
      isLoading: s.isLoading,
      bookings: list,
      updateStatus: (id, status) => store.dispatch(
        UpdateBookingAction(bookingId: id, updates: {'status': status}),
      ),
    );
  }
}
