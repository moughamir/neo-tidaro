import 'package:redux/redux.dart';
import '../core/core.dart';
import '../actions/booking_actions.dart';
import '../app_state.dart';
import '../../domain/models/models.dart';
import '../../domain/enums/enums.dart';

/// Booking middleware for handling async operations
class BookingMiddleware extends BaseMiddleware<AppState> {
  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is LoadBookingsAction) {
      _handleLoadBookings(store, action, next);
    } else if (action is UpdateBookingAction) {
      _handleUpdateBooking(store, action, next);
    } else {
      next(action);
    }
  }

  void _handleLoadBookings(
    Store<AppState> store,
    LoadBookingsAction action,
    NextDispatcher next,
  ) {
    next(action);

    // TODO: Replace with actual API call
    _simulateLoadBookings()
        .then((bookings) {
          store.dispatch(
            ActionCreators.success(
              BookingActionTypes.loadBookingsSuccess,
              bookings,
            ),
          );
        })
        .catchError((error) {
          store.dispatch(
            ActionCreators.failure(
              BookingActionTypes.loadBookingsFailure,
              Exception(error.toString()),
            ),
          );
        });
  }

  void _handleUpdateBooking(
    Store<AppState> store,
    UpdateBookingAction action,
    NextDispatcher next,
  ) {
    next(action);

    // TODO: Replace with actual API call
    _simulateUpdateBooking(action.bookingId, action.updates)
        .then((booking) {
          store.dispatch(
            ActionCreators.success(
              BookingActionTypes.updateBookingSuccess,
              booking,
            ),
          );
        })
        .catchError((error) {
          store.dispatch(
            ActionCreators.failure(
              BookingActionTypes.updateBookingFailure,
              Exception(error.toString()),
            ),
          );
        });
  }

  // Simulate API calls - replace with actual implementation
  Future<List<Booking>> _simulateLoadBookings() async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Return mock data for now
    return [
      Booking(
        id: '1',
        customerId: 'customer1',
        serviceCategory: ServiceCategory.standardCleaning,
        address: const Address(
          street: '123 Main St',
          city: 'Anytown',
          state: 'CA',
          zipCode: '12345',
        ),
        scheduledDate: DateTime.now().add(const Duration(days: 1)),
        status: BookingStatus.confirmed,
        price: 150.0,
        notes: 'Regular cleaning',
        estimatedDuration: const Duration(hours: 2),
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        updatedAt: DateTime.now(),
      ),
      Booking(
        id: '2',
        customerId: 'customer2',
        serviceCategory: ServiceCategory.deepCleaning,
        address: const Address(
          street: '456 Oak Ave',
          city: 'Somewhere',
          state: 'NY',
          zipCode: '67890',
        ),
        scheduledDate: DateTime.now().add(const Duration(days: 3)),
        status: BookingStatus.pending,
        price: 250.0,
        notes: 'Deep cleaning for move-in',
        estimatedDuration: const Duration(hours: 4),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  Future<Booking> _simulateUpdateBooking(
    String bookingId,
    Map<String, dynamic> updates,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));

    // In a real implementation, this would update the booking via API
    // For now, return a mock updated booking
    return Booking(
      id: bookingId,
      customerId: 'customer1',
      serviceCategory: ServiceCategory.standardCleaning,
      address: const Address(
        street: '10 Rue 2 Bloc E',
        city: 'Bouskoura',
        state: 'Casablanca',
        zipCode: '27182',
      ),
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      status: BookingStatus.values.firstWhere(
        (status) => status.name == updates['status'],
        orElse: () => BookingStatus.confirmed,
      ),
      price: 150.0,
      notes: updates['notes'] ?? 'Regular cleaning',
      estimatedDuration: const Duration(hours: 2),
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      updatedAt: DateTime.now(),
    );
  }
}

/// Booking middleware instance
final BookingMiddleware bookingMiddleware = BookingMiddleware();
