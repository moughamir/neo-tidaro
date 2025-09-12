import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:fpdart/fpdart.dart';
import 'package:domain/domain.dart';

import 'package:shared/utils/type_defs.dart';
import 'package:shared/utils/logger.dart';
import 'package:shared/utils/failures/failure.dart';

/// Implementation of [BookingRepository] using Supabase as the backend.
class SupabaseBookingRepository implements BookingRepository {
  // Table name for bookings
  static const String _bookingsTable = 'bookings';
  final SupabaseClient _client;

  /// Maps a JSON map to a [Booking]
  Booking _mapToBooking(Map<String, dynamic> json) {
    try {
      return Booking(
        id: json['id'] as String? ?? '',
        clientId: json['client_id'] as String? ?? '',
        professionalId: json['provider_id'] as String? ?? '',
        serviceId: json['service_id'] as String? ?? '',
        addressId: json['address_id'] as String?,
        status: _parseBookingStatus(json['status'] as String? ?? ''),
        scheduledDate: DateTime.parse(
          json['scheduled_date'] as String? ?? DateTime.now().toIso8601String(),
        ),
        bookingTimeStart: DateTime.parse(json['booking_time_start'] as String? ?? DateTime.now().toIso8601String()),
        bookingTimeEnd: DateTime.parse(json['booking_time_end'] as String? ?? DateTime.now().toIso8601String()),
        durationMinutes: json['duration_minutes'] as int? ?? 60,
        totalPrice: (json['total_price'] as num?)?.toDouble(),
        specialInstructions: json['special_instructions'] as String?,
        cancellationReason: json['cancellation_reason'] as String?,
        createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
        updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
      );
    } catch (e, stackTrace) {
      CoreLogger.error('Error mapping booking from JSON: $e', stackTrace);
      rethrow;
    }
  }

  /// Parses a status string to BookingStatus enum
  BookingStatus _parseBookingStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BookingStatus.pending;
      case 'confirmed':
        return BookingStatus.confirmed;
      case 'in_progress':
      case 'inprogress':
        return BookingStatus.inProgress;
      case 'completed':
        return BookingStatus.completed;
      case 'cancelled':
      case 'canceled':
        return BookingStatus.cancelled;
      default:
        return BookingStatus.pending;
    }
  }

  /// Converts a [Booking] to a JSON map for Supabase
  Map<String, dynamic> _bookingToJson(Booking booking) => {
    'id': booking.id,
    'client_id': booking.clientId,
    'provider_id': booking.professionalId,
    'service_id': booking.serviceId,
    'address_id': booking.addressId,
    'scheduled_date': booking.scheduledDate.toIso8601String(),
    'duration_minutes': booking.durationMinutes,
    'total_price': booking.totalPrice,
    'special_instructions': booking.specialInstructions,
    'status': _bookingStatusToString(booking.status),
    'cancellation_reason': booking.cancellationReason,
    'created_at':
        booking.createdAt?.toIso8601String() ??
        DateTime.now().toIso8601String(),
    'updated_at':
        booking.updatedAt?.toIso8601String() ??
        DateTime.now().toIso8601String(),
  };

  /// Converts BookingStatus to string representation for storage
  String _bookingStatusToString(BookingStatus status) =>
      status.toString().split('.').last;

  /// Creates a new [SupabaseBookingRepository] with the given [SupabaseClient].
  /// If no client is provided, it will use the default Supabase client.
  SupabaseBookingRepository([SupabaseClient? client])
    : _client = client ?? Supabase.instance.client {
    // Initialize logger if not already initialized
    try {
      CoreLogger.initialize();
    } catch (e) {
      // Ignore if logger is already initialized
    }
  }

  @override
  Future<Booking> findById(String id) async {
    CoreLogger.database('Fetching booking by id: $id');
    if (id.isEmpty) {
      throw const ValidationFailure('Booking ID cannot be empty');
    }
    try {
      final response = await _client
          .from('bookings')
          .select('''
            *,
            client:client_id(*),
            provider:provider_id(*),
            service:service_id(*),
            address:address_id(*)
          ''')
          .filter('id', 'eq', id)
          .single()
          .then((data) => data as Map<String, dynamic>?)
          .onError((error, _) {
            CoreLogger.error('Error finding booking by id: $error');
            return null;
          });

      if (response == null) {
        throw Failure.notFound('Booking with id $id not found');
      }

      return _mapToBooking(response);
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to find booking by id $id: ${e.message}');
      throw Failure.database(e.message);
    } catch (e, stackTrace) {
      CoreLogger.error(
        'Unexpected error finding booking by id $id: $e',
        stackTrace,
      );
      throw Failure.unexpected('Error finding booking: $e');
    }
  }

  @override
  Future<List<Booking>> findByClientId(String clientId) async {
    CoreLogger.database('Fetching bookings for client: $clientId');
    try {
      final response = await _client
          .from(_bookingsTable)
          .select()
          .filter('client_id', 'eq', clientId)
          .order('scheduled_date', ascending: false);

      final data = await response as List<dynamic>;
      final bookings = data
          .map((json) => _mapToBooking(json as Map<String, dynamic>))
          .toList();

      return bookings;
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to find bookings by client: ${e.message}');
      throw Failure.database(e.message);
    } catch (e, stackTrace) {
      CoreLogger.error(
        'Unexpected error finding bookings by client: $e',
        stackTrace,
      );
      throw Failure.unexpected('Error finding bookings: $e');
    }
  }

  @override
  Future<List<Booking>> findByProviderId(String providerId) async {
    CoreLogger.database('Fetching bookings for provider: $providerId');
    try {
      final response = await _client
          .from(_bookingsTable)
          .select('''
            *,
            client:client_id(*),
            provider:provider_id(*),
            service:service_id(*),
            address:address_id(*)
          ''')
          .filter('provider_id', 'eq', providerId)
          .order('scheduled_date', ascending: false);

      final bookings = (response as List<dynamic>)
          .map((json) => _mapToBooking(json as Map<String, dynamic>))
          .toList();

      return bookings;
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to find provider bookings: ${e.message}');
      throw Failure.database(e.message);
    } catch (e, stackTrace) {
      CoreLogger.error(
        'Unexpected error finding provider bookings: $e',
        stackTrace,
      );
      throw Failure.unexpected('Error finding provider bookings: $e');
    }
  }

  @override
  Future<Booking> save(Booking booking) async {
    CoreLogger.database('Saving booking: ${booking.id}');
    try {
      final data = _bookingToJson(booking);
      final response = await _client
          .from(_bookingsTable)
          .upsert(data)
          .select()
          .single()
          .then((data) => data);

      final savedBooking = _mapToBooking(response);
      return savedBooking;
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to save booking: ${e.message}');
      throw Failure.database(e.message);
    } catch (e, stackTrace) {
      CoreLogger.error('Unexpected error saving booking', stackTrace);
      throw Failure.unexpected(e.toString());
    }
  }

  @override
  Future<void> cancel(String id, String reason) async {
    CoreLogger.database('Cancelling booking: $id, reason: $reason');
    try {
      await _client.rpc(
                'cancel_booking',
                params: {'p_booking_id': id, 'p_reason': reason},
              );
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to cancel booking $id: ${e.message}');
      throw Failure.database(e.message);
    } catch (e) {
      CoreLogger.error('Unexpected error canceling booking $id: $e');
      throw Failure.unexpected(e.toString());
    }
  }

  @override
  Future<List<Booking>> findUpcomingBookings({
    String? clientId,
    String? providerId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    CoreLogger.database(
      'Fetching upcoming bookings: client=$clientId, provider=$providerId, start=$startDate, end=$endDate',
    );

    try {
      // Build the base query
      var query = _client.from(_bookingsTable).select('''
            *,
            client:client_id(*),
            provider:provider_id(*),
            service:service_id(*),
            address:address_id(*)
          ''');

      // Apply filters if provided
      if (clientId != null && clientId.isNotEmpty) {
        query = query.filter('client_id', 'eq', clientId);
      }

      if (providerId != null && providerId.isNotEmpty) {
        query = query.filter('provider_id', 'eq', providerId);
      }

      final now = DateTime.now().toIso8601String();
      query = query.filter(
        'scheduled_date',
        'gte',
        startDate?.toIso8601String() ?? now,
      );

      if (endDate != null) {
        query = query.filter(
          'scheduled_date',
          'lte',
          endDate.toIso8601String(),
        );
      }

      // Execute the query
      final response = await query.order('scheduled_date', ascending: true);

      if (response.isEmpty) {
        return <Booking>[];
      }

      // Map the response to Booking list
      final bookings = (response as List<dynamic>)
          .map<Booking>(
            (json) => _mapToBooking(json as Map<String, dynamic>),
          )
          .toList();

      return bookings;
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to fetch upcoming bookings: ${e.message}');
      throw Failure.database(e.message);
    } catch (e, stackTrace) {
      CoreLogger.error('Unexpected error in findUpcomingBookings', stackTrace);
      throw Failure.unexpected(e.toString());
    }
  }

  @override
  Future<bool> cancelBooking(String bookingId, String reason) {
    // TODO: implement cancelBooking
    throw UnimplementedError();
  }

  @override
  Future<bool> checkAvailability({
    required String professionalId,
    required DateTime date,
    required TimeSlot timeSlot,
  }) {
    // TODO: implement checkAvailability
    throw UnimplementedError();
  }

  @override
  Future<bool> completeBooking(String bookingId) {
    // TODO: implement completeBooking
    throw UnimplementedError();
  }

  @override
  Future<bool> confirmBooking(String bookingId) {
    // TODO: implement confirmBooking
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<Booking>> create(Booking entity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<List<Booking>>> createBatch(List<Booking> entities) {
    // TODO: implement createBatch
    throw UnimplementedError();
  }

  @override
  Future<Booking> createBooking(CreateBookingDto dto) {
    // TODO: implement createBooking
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<bool>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<bool>> deleteBatch(List<String> ids) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<List<Booking>>> getAll({
    PaginationDto? pagination,
    SortBy? sortBy,
  }) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<List<Booking>> getBookingHistory(String userId) {
    // TODO: implement getBookingHistory
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<Booking>> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<List<Booking>> getClientBookings(
    String clientId, {
    BookingStatus? status,
    PaginationDto? pagination,
  }) {
    // TODO: implement getClientBookings
    throw UnimplementedError();
  }

  @override
  Future<List<Booking>> getProfessionalBookings(
    String professionalId, {
    BookingStatus? status,
    DateTime? date,
    PaginationDto? pagination,
  }) {
    // TODO: implement getProfessionalBookings
    throw UnimplementedError();
  }

  @override
  Future<List<Booking>> getUpcomingBookings(String userId) {
    // TODO: implement getUpcomingBookings
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<List<Booking>>> search(
    String query, {
    PaginationDto? pagination,
    Map<String, dynamic>? filters,
  }) {
    // TODO: implement search
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<Booking>> update(Booking entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Booking> updateStatus(UpdateBookingStatusDto dto) {
    // TODO: implement updateStatus
    throw UnimplementedError();
  }

  @override
  Stream<List<Booking>> watchAll() {
    // TODO: implement watchAll
    throw UnimplementedError();
  }

  @override
  Stream<Booking> watchBooking(String bookingId) {
    // TODO: implement watchBooking
    throw UnimplementedError();
  }

  @override
  Stream<Booking?> watchById(String id) {
    // TODO: implement watchById
    throw UnimplementedError();
  }

  @override
  Stream<List<Booking>> watchUserBookings(String userId) {
    // TODO: implement watchUserBookings
    throw UnimplementedError();
  }
}
