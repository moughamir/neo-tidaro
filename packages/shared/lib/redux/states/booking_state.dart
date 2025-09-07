import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import '../../domain/models/models.dart';

/// Booking state following functional programming patterns
class BookingState extends BaseAsyncState<List<Booking>> {
  const BookingState({
    required super.isLoading,
    required super.data,
    required super.error,
    required this.filters,
    required this.selectedBookingId,
  });

  final BookingFilters filters;
  final Option<String> selectedBookingId;

  /// Initial state factory
  factory BookingState.initial() {
    return BookingState(
      isLoading: false,
      data: const Some([]),
      error: const None(),
      filters: const BookingFilters(),
      selectedBookingId: const None(),
    );
  }

  /// Loading state factory
  factory BookingState.loading() {
    return BookingState(
      isLoading: true,
      data: const Some([]),
      error: const None(),
      filters: const BookingFilters(),
      selectedBookingId: const None(),
    );
  }

  /// Success state factory
  factory BookingState.success(
    List<Booking> bookings, {
    BookingFilters? filters,
    Option<String>? selectedBookingId,
  }) {
    return BookingState(
      isLoading: false,
      data: Some(bookings),
      error: const None(),
      filters: filters ?? const BookingFilters(),
      selectedBookingId: selectedBookingId ?? const None(),
    );
  }

  /// Error state factory
  factory BookingState.error(
    Exception error, {
    List<Booking>? previousBookings,
    BookingFilters? filters,
    Option<String>? selectedBookingId,
  }) {
    return BookingState(
      isLoading: false,
      data: Some(previousBookings ?? []),
      error: Some(error),
      filters: filters ?? const BookingFilters(),
      selectedBookingId: selectedBookingId ?? const None(),
    );
  }

  /// Copy with method for state updates
  BookingState copyWith({
    bool? isLoading,
    Option<List<Booking>>? data,
    Option<Exception>? error,
    BookingFilters? filters,
    Option<String>? selectedBookingId,
  }) {
    return BookingState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
      filters: filters ?? this.filters,
      selectedBookingId: selectedBookingId ?? this.selectedBookingId,
    );
  }

  /// Get filtered bookings based on current filters
  List<Booking> get filteredBookings {
    return data.fold(() => [], (bookings) {
      var filtered = bookings;

      // Filter by status
      if (filters.status != null) {
        filtered = filtered.where((b) => b.status == filters.status).toList();
      }

      // Filter by service category
      if (filters.serviceCategory != null) {
        filtered = filtered
            .where((b) => b.serviceCategory == filters.serviceCategory)
            .toList();
      }

      // Filter by date range
      if (filters.dateRange != null) {
        filtered = filtered.where((b) {
          return b.scheduledDate.isAfter(filters.dateRange!.start) &&
              b.scheduledDate.isBefore(filters.dateRange!.end);
        }).toList();
      }

      // Filter by customer ID
      if (filters.customerId != null) {
        filtered = filtered
            .where((b) => b.customerId == filters.customerId)
            .toList();
      }

      // Filter by cleaner ID
      if (filters.cleanerId != null) {
        filtered = filtered
            .where((b) => b.cleanerId == filters.cleanerId)
            .toList();
      }

      return filtered;
    });
  }

  /// Get selected booking
  Option<Booking> get selectedBooking {
    return selectedBookingId.fold(
      () => const None(),
      (id) => data.fold(() => const None(), (bookings) {
        try {
          final booking = bookings.firstWhere((b) => b.id == id);
          return Some(booking);
        } catch (e) {
          return const None();
        }
      }),
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    data,
    error,
    filters,
    selectedBookingId,
  ];

  @override
  String get stateType => 'BookingState';
}
