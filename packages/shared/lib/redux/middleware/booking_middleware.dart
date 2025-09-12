import 'dart:async';

import 'package:core/utils/logger.dart';
import 'package:redux/redux.dart';
import 'package:domain/domain.dart';
import 'package:shared/redux/actions/booking_actions.dart';
import 'package:shared/redux/core/base_action.dart';
import 'package:shared/repositories/supabase_booking_repository.dart';

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

    if (authState.isLoading || authState.hasError) {
      store.dispatch(
        ActionCreators.failure(
          BookingActionTypes.loadBookingsFailure,
          Exception('Authentication state not ready'),
        ),
      );
      return;
    }

    final user = authState.dataOrNull;
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
      final result = await _bookingRepository.findUpcomingBookings(
        clientId: user.role == UserRole.clientConsumer ? user.id : null,
        providerId: user.role == UserRole.clientProfessional ? user.id : null,
        startDate: action.filters?.dateRange?.start,
        endDate: action.filters?.dateRange?.end,
      );

      await result.fold(
        (failure) async {
          store.dispatch(
            ActionCreators.failure(
              BookingActionTypes.loadBookingsFailure,
              Exception(failure.message),
            ),
          );
        },
        (bookings) async {
          store.dispatch(
            ActionCreators.success(
              BookingActionTypes.loadBookingsSuccess,
              bookings,
            ),
          );
        },
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
      final result = await _bookingRepository.findById(action.bookingId);

      await result.fold(
        (failure) async => store.dispatch(
          ActionCreators.failure(
            BookingActionTypes.updateBookingFailure,
            Exception(failure.message),
          ),
        ),

        (booking) async {
          // Parse and validate update values
          final providerId =
              action.updates['providerId'] as String? ?? booking.providerId;
          final serviceId =
              action.updates['serviceId'] as String? ?? booking.serviceId;
          final addressId =
              action.updates['addressId'] as String? ?? booking.addressId;

          // Handle DateTime conversion
          DateTime? scheduledDate = booking.scheduledDate;
          if (action.updates['scheduledDate'] is DateTime) {
            scheduledDate = action.updates['scheduledDate'] as DateTime;
          } else if (action.updates['scheduledDate'] != null) {
            scheduledDate =
                DateTime.tryParse(action.updates['scheduledDate'].toString()) ??
                booking.scheduledDate;
          }

          final specialInstructions =
              action.updates['specialInstructions'] as String? ??
              booking.specialInstructions;

          // Parse numeric values with type safety
          int durationMinutes = booking.durationMinutes;
          if (action.updates['durationMinutes'] is int) {
            durationMinutes = action.updates['durationMinutes'] as int;
          } else if (action.updates['durationMinutes'] is String) {
            durationMinutes =
                int.tryParse(action.updates['durationMinutes'] as String) ??
                booking.durationMinutes;
          }

          double totalPrice = booking.totalPrice;
          if (action.updates['totalPrice'] is num) {
            totalPrice = (action.updates['totalPrice'] as num).toDouble();
          } else if (action.updates['totalPrice'] is String) {
            totalPrice =
                double.tryParse(action.updates['totalPrice'] as String) ??
                booking.totalPrice;
          }

          // Handle status enum conversion
          BookingStatus status = booking.status;
          if (action.updates['status'] is BookingStatus) {
            status = action.updates['status'] as BookingStatus;
          } else if (action.updates['status'] is String) {
            final statusStr = action.updates['status'] as String;
            status = BookingStatus.values.firstWhere(
              (e) => e.toString().split('.').last == statusStr,
              orElse: () => booking.status,
            );
          }

          // Create a new booking with updated fields
          final updatedBooking = BookingModel(
            id: booking.id,
            clientId: booking.clientId,
            providerId: providerId,
            serviceId: serviceId,
            addressId: addressId,
            scheduledDate: scheduledDate,
            status: status,
            specialInstructions: specialInstructions,
            durationMinutes: durationMinutes,
            totalPrice: totalPrice,
            client: booking.client,
            provider: booking.provider,
            service: booking.service,
            address: booking.address,
            createdAt: booking.createdAt,
            updatedAt: DateTime.now(),
          );

          final saveResult = await _bookingRepository.save(updatedBooking);

          saveResult.fold(
            (failure) => store.dispatch(
              ActionCreators.failure(
                BookingActionTypes.updateBookingFailure,
                Exception(failure.message),
              ),
            ),
            (savedBooking) => store.dispatch(
              ActionCreators.success(
                BookingActionTypes.updateBookingSuccess,
                savedBooking,
              ),
            ),
          );
        },
      );
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
