import 'dart:async';

import 'package:core/utils/logger.dart';
import 'package:domain/entities/user/user.dart';

import 'package:domain/dto/booking_dto.dart' show UpdateBookingStatusDto;
import 'package:domain/enums/enums.dart';

import 'package:shared/redux/redux.dart';
import 'package:shared/repositories/supabase_booking_repository.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide SortBy, User;

/// Booking middleware for handling async operations with Supabase
class BookingMiddleware extends MiddlewareClass<AppState> {
  final SupabaseBookingRepository _bookingRepository;

  /// Creates a new [BookingMiddleware] with the given [SupabaseClient].
  /// If no client is provided, it will use the default Supabase client.
  BookingMiddleware([SupabaseClient? client])
    : _bookingRepository = SupabaseBookingRepository(
        client ?? Supabase.instance.client,
      );

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    next(action);

    if (action is LoadBookingsAction) {
      _handleLoadBookings(store, action);
    } else if (action is UpdateBookingAction) {
      _handleUpdateBooking(store, action);
    }
  }

  /// Creates a booking middleware instance with the default Supabase client
  static BookingMiddleware create() => BookingMiddleware();

  Future<void> _handleLoadBookings(
    Store<AppState> store,
    LoadBookingsAction action,
  ) async {
    final authState = store.state.authState;

    if (authState.isLoading || (authState.error.isSome())) {
      store.dispatch(
        ActionCreators.failure(
          BookingActionTypes.loadBookingsFailure,
          Exception('Authentication state not ready'),
        ),
      );
      return;
    }

    final User? user = authState.data.fold<User?>(() => null, (User u) => u);
    if (user == null) {
      store.dispatch(
        ActionCreators.failure(
          BookingActionTypes.loadBookingsFailure,
          Exception('User not authenticated'),
        ),
      );
      return;
    }

    try {
      final start = action.filters?['dateRange']?['start'] as DateTime?;
      final end = action.filters?['dateRange']?['end'] as DateTime?;

      final bookings = await _bookingRepository.findUpcomingBookings(
        clientId: user.role == PlatformUserRole.clientConsumer ? user.id : null,
        providerId: user.role == PlatformUserRole.clientProfessional
            ? user.id
            : null,
        startDate: start,
        endDate: end,
      );

      store.dispatch(
        ActionCreators.success(
          BookingActionTypes.loadBookingsSuccess,
          bookings,
        ),
      );
    } catch (e, stackTrace) {
      CoreLogger.error(
        'Error in _handleLoadBookings',
        error: e,
        stackTrace: stackTrace,
      );
      store.dispatch(
        ActionCreators.failure(
          BookingActionTypes.loadBookingsFailure,
          e is Exception ? e : Exception('Failed to load bookings: $e'),
        ),
      );
    }
  }

  Future<void> _handleUpdateBooking(
    Store<AppState> store,
    UpdateBookingAction action,
  ) async {
    try {
      final booking = await _bookingRepository.findById(action.bookingId);
      {
        // Parse and validate update values
        // Handle status-only update for now; complex updates TBD
        if (action.updates.containsKey('status')) {
          final statusVal = action.updates['status'];
          final status = statusVal is BookingActivityStatus
              ? statusVal
              : BookingActivityStatus.values.firstWhere(
                  (e) => e.toString().split('.').last == statusVal,
                  orElse: () => booking.status,
                );
          final saved = await _bookingRepository.updateStatus(
            UpdateBookingStatusDto(bookingId: booking.id, status: status),
          );
          store.dispatch(
            ActionCreators.success(
              BookingActionTypes.updateBookingSuccess,
              saved,
            ),
          );
        } else {
          // No supported updates
          store.dispatch(
            ActionCreators.failure(
              BookingActionTypes.updateBookingFailure,
              Exception('Unsupported update fields'),
            ),
          );
        }
      }
    } catch (e, stackTrace) {
      CoreLogger.error(
        'Error in _handleUpdateBooking',
        error: e,
        stackTrace: stackTrace,
      );
      store.dispatch(
        ActionCreators.failure(
          BookingActionTypes.updateBookingFailure,
          e is Exception ? e : Exception('Failed to update booking: $e'),
        ),
      );
    }
  }
}

/// Creates a booking middleware instance with the default Supabase client
BookingMiddleware createBookingMiddleware() => BookingMiddleware();

/// Booking middleware instance with the default Supabase client
final BookingMiddleware bookingMiddleware = createBookingMiddleware();
