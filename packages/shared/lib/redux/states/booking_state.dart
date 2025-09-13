import 'package:domain/domain.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/redux/core/core.dart';

/// Booking state following functional programming patterns
class BookingState extends BaseAsyncState<List<Booking>> {
  const BookingState({
    required super.isLoading,
    required super.data,
    required super.error,
    required this.filters,
    required this.selectedBookingId,
  });

  /// Initial state factory
  factory BookingState.initial() {
    return const BookingState(
      isLoading: false,
      data: Some([]),
      error: None(),
      filters: {},
      selectedBookingId: None(),
    );
  }

  /// Loading state factory
  factory BookingState.loading() {
    return const BookingState(
      isLoading: true,
      data: Some([]),
      error: None(),
      filters: {},
      selectedBookingId: None(),
    );
  }

  /// Success state factory
  factory BookingState.success(
    List<Booking> bookings, {
    Map<String, dynamic>? filters,
    Option<String>? selectedBookingId,
  }) {
    return BookingState(
      isLoading: false,
      data: Some(bookings),
      error: const None(),
      filters: filters ?? const {},
      selectedBookingId: selectedBookingId ?? const None(),
    );
  }

  /// Error state factory
  factory BookingState.error(
    Exception error, {
    List<Booking>? previousBookings,
    Map<String, dynamic>? filters,
    Option<String>? selectedBookingId,
  }) {
    return BookingState(
      isLoading: false,
      data: Some(previousBookings ?? []),
      error: Some(error),
      filters: filters ?? const {},
      selectedBookingId: selectedBookingId ?? const None(),
    );
  }

  /// Copy with method for state updates
  BookingState copyWith({
    bool? isLoading,
    Option<List<Booking>>? data,
    Option<Exception>? error,
    Map<String, dynamic>? filters,
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
      if (filters['status'] != null) {
        filtered = filtered
            .where((b) => b.status == filters['status'])
            .toList();
      }

      // Filter by date range
      if (filters['dateRange'] != null) {
        filtered = filtered.where((b) {
          return b.scheduledStartTime.isAfter(filters['dateRange']!['start']) &&
              b.scheduledEndTime.isBefore(filters['dateRange']!['end']);
        }).toList();
      }

      // Filter by customer ID
      if (filters['clientId'] != null) {
        filtered = filtered
            .where((b) => b.clientId == filters['clientId'])
            .toList();
      }

      // Filter by professional ID
      if (filters['professionalId'] != null) {
        filtered = filtered
            .where((b) => b.professionalId == filters['professionalId'])
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

  final Map<String, dynamic> filters;
  final Option<String> selectedBookingId;
}
