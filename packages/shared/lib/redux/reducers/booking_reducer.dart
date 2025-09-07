import 'package:fpdart/fpdart.dart';

import '../actions/booking_actions.dart';
import '../states/booking_state.dart';
import '../../domain/models/models.dart';

/// Booking reducer
BookingState bookingReducer(BookingState state, dynamic action) {
  if (action is LoadBookingsAction) {
    return state.copyWith(isLoading: true);
  }

  if (action.type == BookingActionTypes.loadBookingsSuccess) {
    final bookings = action.payload as List<Booking>;
    return BookingState.success(
      bookings,
      filters: state.filters,
      selectedBookingId: state.selectedBookingId,
    );
  }

  if (action.type == BookingActionTypes.loadBookingsFailure) {
    final error = action.payload as Exception;
    return BookingState.error(
      error,
      previousBookings: state.data.fold(() => null, (bookings) => bookings),
      filters: state.filters,
      selectedBookingId: state.selectedBookingId,
    );
  }

  if (action is UpdateBookingFiltersAction) {
    return state.copyWith(filters: action.filters);
  }

  if (action is ClearBookingFiltersAction) {
    return state.copyWith(filters: const BookingFilters());
  }

  if (action is SelectBookingAction) {
    return state.copyWith(selectedBookingId: Some(action.bookingId));
  }

  if (action is UpdateBookingAction) {
    return state.copyWith(isLoading: true);
  }

  if (action.type == BookingActionTypes.updateBookingSuccess) {
    final updatedBooking = action.payload as Booking;
    return state.data.fold(() => state, (bookings) {
      final updatedBookings = bookings.map((booking) {
        return booking.id == updatedBooking.id ? updatedBooking : booking;
      }).toList();
      return BookingState.success(
        updatedBookings,
        filters: state.filters,
        selectedBookingId: state.selectedBookingId,
      );
    });
  }

  if (action.type == BookingActionTypes.updateBookingFailure) {
    final error = action.payload as Exception;
    return state.copyWith(isLoading: false, error: Some(error));
  }

  return state;
}
