import '../entities/entities.dart';

class BookingState {
  final List<Booking> userBookings;
  final List<Booking> upcomingBookings;
  final Booking? selectedBooking;
  final Map<String, Booking> bookingCache;
  final bool isLoading;
  final String? error;

  const BookingState({
    this.userBookings = const [],
    this.upcomingBookings = const [],
    this.selectedBooking,
    this.bookingCache = const {},
    required this.isLoading,
    this.error,
  });

  factory BookingState.initial() => const BookingState(isLoading: false);
}
