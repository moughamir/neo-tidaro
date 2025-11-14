import 'package:shared/shared.dart';

class BookingsViewModel {
  const BookingsViewModel({
    required this.bookings,
    required this.isLoading,
    required this.error,
    required this.currentFilter,
    required this.onRefresh,
    required this.onFilterChanged,
    required this.onUpdateBookingStatus,
  });

  final List<Booking> bookings;
  final bool isLoading;
  final Option<Exception> error;
  final BookingActivityStatus? currentFilter;
  final VoidCallback onRefresh;
  final Function(BookingActivityStatus?) onFilterChanged;
  final Function(String bookingId, BookingActivityStatus status)
  onUpdateBookingStatus;

  int get activeBookings => bookings
      .where(
        (Booking b) =>
            b.status == BookingActivityStatus.confirmed ||
            b.status == BookingActivityStatus.inProgress,
      )
      .length;

  int get completedBookings => bookings
      .where((Booking b) => b.status == BookingActivityStatus.completed)
      .length;

  static BookingsViewModel fromStore(Store<AppState> store) {
    return BookingsViewModel(
      bookings: BookingSelectors.getFilteredBookings(store.state),
      isLoading: BookingSelectors.isBookingsLoading(store.state),
      error: BookingSelectors.getBookingError(store.state),
      currentFilter: store.state.bookingState.filter,
      onRefresh: () {
        store.dispatch(const LoadBookingsAction());
      },
      onFilterChanged: (BookingActivityStatus? filter) {
        store.dispatch(UpdateBookingFiltersAction(filter));
      },
      onUpdateBookingStatus: (String bookingId, BookingActivityStatus status) {
        store.dispatch(
          UpdateBookingAction(
            bookingId: bookingId,
            updates: <String, dynamic>{'status': status.name},
          ),
        );
      },
    );
  }
}
