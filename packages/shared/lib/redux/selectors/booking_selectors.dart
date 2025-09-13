import 'package:domain/domain.dart';
import 'package:fpdart/fpdart.dart';
import '../states/app_state.dart';
import '../states/booking_state.dart';

/// Booking selectors
class BookingSelectors {
  /// Get booking state
  static BookingState getBookingState(AppState state) => state.bookingState;

  /// Get all bookings
  static List<Booking> getBookings(AppState state) {
    return state.bookingState.data.fold(() => [], (bookings) => bookings);
  }

  /// Get filtered bookings
  static List<Booking> getFilteredBookings(AppState state) {
    return state.bookingState.filteredBookings;
  }

  /// Get booking filters
  static Map<String, dynamic> getBookingFilters(AppState state) {
    return state.bookingState.filters;
  }

  /// Get selected booking
  static Option<Booking> getSelectedBooking(AppState state) {
    return state.bookingState.selectedBooking;
  }

  /// Get selected booking ID
  static Option<String> getSelectedBookingId(AppState state) {
    return state.bookingState.selectedBookingId;
  }

  /// Check if bookings are loading
  static bool isBookingsLoading(AppState state) {
    return state.bookingState.isLoading;
  }

  /// Get booking error
  static Option<Exception> getBookingError(AppState state) {
    return state.bookingState.error;
  }

  /// Get bookings by status
  static List<Booking> getBookingsByStatus(
    AppState state,
    BookingActivityStatus status,
  ) {
    return getBookings(
      state,
    ).where((booking) => booking.status == status).toList();
  }

  /// Get bookings by customer ID
  static List<Booking> getBookingsByCustomer(
    AppState state,
    String customerId,
  ) {
    return getBookings(
      state,
    ).where((booking) => booking.clientId == customerId).toList();
  }

  /// Get bookings by professional ID
  static List<Booking> getBookingsByProfessional(
    AppState state,
    String professionalId,
  ) {
    return getBookings(
      state,
    ).where((booking) => booking.professionalId == professionalId).toList();
  }

  /// Get bookings count
  static int getBookingsCount(AppState state) {
    return getBookings(state).length;
  }

  /// Get filtered bookings count
  static int getFilteredBookingsCount(AppState state) {
    return getFilteredBookings(state).length;
  }

  /// Get pending bookings
  static List<Booking> getPendingBookings(AppState state) {
    return getBookingsByStatus(state, BookingActivityStatus.pending);
  }

  /// Get confirmed bookings
  static List<Booking> getConfirmedBookings(AppState state) {
    return getBookingsByStatus(state, BookingActivityStatus.confirmed);
  }

  /// Get assigned bookings
  static List<Booking> getAssignedBookings(AppState state) {
    return getBookingsByStatus(state, BookingActivityStatus.inProgress);
  }

  /// Get completed bookings
  static List<Booking> getCompletedBookings(AppState state) {
    return getBookingsByStatus(state, BookingActivityStatus.completed);
  }

  /// Get cancelled bookings
  static List<Booking> getCancelledBookings(AppState state) {
    return getBookingsByStatus(state, BookingActivityStatus.cancelled);
  }

  /// Get today's bookings
  static List<Booking> getTodaysBookings(AppState state) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));

    return getBookings(state).where((booking) {
      return booking.scheduledStartTime.isAfter(today) &&
          booking.scheduledStartTime.isBefore(tomorrow);
    }).toList();
  }

  /// Get upcoming bookings (next 7 days)
  static List<Booking> getUpcomingBookings(AppState state) {
    final now = DateTime.now();
    final nextWeek = now.add(const Duration(days: 7));

    return getBookings(state).where((booking) {
      return booking.scheduledStartTime.isAfter(now) &&
          booking.scheduledStartTime.isBefore(nextWeek);
    }).toList();
  }

  /// Check if there are any active filters
  static bool hasActiveFilters(AppState state) {
    final filters = getBookingFilters(state);
    return filters['status'] != null ||
        filters['serviceCategory'] != null ||
        filters['dateRange'] != null ||
        filters['clientId'] != null ||
        filters['professionalId'] != null;
  }
}
