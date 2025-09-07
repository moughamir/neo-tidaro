import 'package:fpdart/fpdart.dart';
import 'package:shared/domain/enums/enums.dart';
import '../core/core.dart';
import '../../domain/models/models.dart';

/// Booking action types
class BookingActionTypes {
  static const String loadBookings = 'BOOKINGS_LOAD';
  static const String loadBookingsSuccess = 'BOOKINGS_LOAD_SUCCESS';
  static const String loadBookingsFailure = 'BOOKINGS_LOAD_FAILURE';
  static const String updateFilters = 'BOOKINGS_UPDATE_FILTERS';
  static const String clearFilters = 'BOOKINGS_CLEAR_FILTERS';
  static const String selectBooking = 'BOOKINGS_SELECT';
  static const String updateBooking = 'BOOKINGS_UPDATE';
  static const String updateBookingSuccess = 'BOOKINGS_UPDATE_SUCCESS';
  static const String updateBookingFailure = 'BOOKINGS_UPDATE_FAILURE';
  static const String updateBookingStatus = 'BOOKINGS_UPDATE_STATUS';
  static const String createBooking = 'BOOKINGS_CREATE';
}

/// Load bookings action
class LoadBookingsAction extends BaseAsyncAction<List<Booking>> {
  const LoadBookingsAction({this.filters});

  final BookingFilters? filters;

  @override
  String get type => BookingActionTypes.loadBookings;

  @override
  BookingFilters? get payload => filters;

  @override
  Future<Either<Exception, List<Booking>>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [filters];
}

/// Update booking filters action
class UpdateBookingFiltersAction extends BaseAction {
  const UpdateBookingFiltersAction(this.filters);

  final BookingFilters filters;

  @override
  String get type => BookingActionTypes.updateFilters;

  @override
  BookingFilters get payload => filters;

  @override
  List<Object?> get props => [filters];
}

/// Clear booking filters action
class ClearBookingFiltersAction extends BaseAction {
  const ClearBookingFiltersAction();

  @override
  String get type => BookingActionTypes.clearFilters;

  @override
  List<Object?> get props => [];
}

/// Select booking action
class SelectBookingAction extends BaseAction {
  const SelectBookingAction(this.bookingId);

  final String bookingId;

  @override
  String get type => BookingActionTypes.selectBooking;

  @override
  String get payload => bookingId;

  @override
  List<Object?> get props => [bookingId];
}

/// Update booking action
class UpdateBookingAction extends BaseAsyncAction<Booking> {
  const UpdateBookingAction({required this.bookingId, required this.updates});

  final String bookingId;
  final Map<String, dynamic> updates;

  @override
  String get type => BookingActionTypes.updateBooking;

  @override
  Map<String, dynamic> get payload => {
    'bookingId': bookingId,
    'updates': updates,
  };

  @override
  Future<Either<Exception, Booking>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [bookingId, updates];
}

/// Update booking status action
class UpdateBookingStatusAction extends BaseAction {
  const UpdateBookingStatusAction({
    required this.bookingId,
    required this.status,
  });

  final String bookingId;
  final BookingStatus status;

  @override
  String get type => BookingActionTypes.updateBookingStatus;

  @override
  Map<String, dynamic> get payload => {
    'bookingId': bookingId,
    'status': status,
  };

  @override
  List<Object?> get props => [bookingId, status];
}

/// Create booking action
class CreateBookingAction extends BaseAction {
  const CreateBookingAction(this.booking);

  final Booking booking;

  @override
  String get type => BookingActionTypes.createBooking;

  @override
  Booking get payload => booking;

  @override
  List<Object?> get props => [booking];
}
