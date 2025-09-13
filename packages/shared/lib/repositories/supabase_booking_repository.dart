import 'package:supabase_flutter/supabase_flutter.dart' hide SortBy;
import 'package:domain/domain.dart';

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
        scheduledStartTime: DateTime.parse(
          json['scheduled_start_time'] as String? ??
              DateTime.now().toIso8601String(),
        ),
        scheduledEndTime: DateTime.parse(
          json['scheduled_end_time'] as String? ??
              DateTime.now().toIso8601String(),
        ),
        actualStartTime: (json['actual_start_time'] as String?) != null
            ? DateTime.tryParse(json['actual_start_time'] as String)
            : null,
        actualEndTime: (json['actual_end_time'] as String?) != null
            ? DateTime.tryParse(json['actual_end_time'] as String)
            : null,
        totalAmount: (json['total_amount'] as num?)?.toDouble() ?? 0,
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
  BookingActivityStatus _parseBookingStatus(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return BookingActivityStatus.pending;
      case 'confirmed':
        return BookingActivityStatus.confirmed;
      case 'in_progress':
      case 'inprogress':
        return BookingActivityStatus.inProgress;
      case 'completed':
        return BookingActivityStatus.completed;
      case 'cancelled':
      case 'canceled':
        return BookingActivityStatus.cancelled;
      default:
        return BookingActivityStatus.pending;
    }
  }

  /// Converts a [Booking] to a JSON map for Supabase
  Map<String, dynamic> _bookingToJson(Booking booking) => {
    'id': booking.id,
    'client_id': booking.clientId,
    'provider_id': booking.professionalId,
    'service_id': booking.serviceId,
    'address_id': booking.addressId,
    'scheduled_start_time': booking.scheduledStartTime.toIso8601String(),
    'scheduled_end_time': booking.scheduledEndTime.toIso8601String(),
    if (booking.actualStartTime != null)
      'actual_start_time': booking.actualStartTime!.toIso8601String(),
    if (booking.actualEndTime != null)
      'actual_end_time': booking.actualEndTime!.toIso8601String(),
    'total_amount': booking.totalAmount,
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
  String _bookingStatusToString(BookingActivityStatus status) =>
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
          .map<Booking>((json) => _mapToBooking(json as Map<String, dynamic>))
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

  Future<RepositoryResult<Booking>> create(Booking entity) {
    // TODO: implement create
    throw UnimplementedError();
  }

  Future<RepositoryResult<List<Booking>>> createBatch(List<Booking> entities) {
    // TODO: implement createBatch
    throw UnimplementedError();
  }

  @override
  Future<Booking> createBooking(CreateBookingDto dto) {
    // TODO: implement createBooking
    throw UnimplementedError();
  }

  Future<RepositoryResult<bool>> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  Future<RepositoryResult<bool>> deleteBatch(List<String> ids) {
    // TODO: implement deleteBatch
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<List<Booking>>> getAll({
    PaginationDto? pagination,
    PreBookingSortBy? sortBy,
  }) async {
    try {
      // Build ordered query first to ensure a TransformBuilder type
      // Sorting: map domain SortBy to booking columns where applicable
      // Default to scheduled_start_time desc
      String orderColumn = 'scheduled_start_time';
      bool ascending = false;
      if (sortBy != null) {
        switch (sortBy) {
          case PreBookingSortBy.price:
            orderColumn = 'total_amount';
            ascending = false;
            break;
          default:
            orderColumn = 'scheduled_start_time';
            ascending = false;
        }
      }

      final ordered = _client
          .from(_bookingsTable)
          .select()
          .order(orderColumn, ascending: ascending);

      final built = pagination != null
          ? ordered.range(
              (pagination.page - 1) * pagination.limit,
              (pagination.page - 1) * pagination.limit + pagination.limit - 1,
            )
          : ordered;

      final response = await built as List<dynamic>;
      final bookings = response
          .map((e) => _mapToBooking(e as Map<String, dynamic>))
          .toList();
      return RepositoryResult.success(bookings);
    } on PostgrestException catch (e) {
      CoreLogger.error('getAll failed: ${e.message}');
      return RepositoryResult.failure(e.message);
    } catch (e) {
      CoreLogger.error('getAll unexpected error: $e');
      return RepositoryResult.failure(e.toString());
    }
  }

  @override
  Future<List<Booking>> getBookingHistory(String userId) {
    // TODO: implement getBookingHistory
    throw UnimplementedError();
  }

  @override
  Future<RepositoryResult<Booking>> getById(String id) async {
    try {
      final booking = await findById(id);
      return RepositoryResult.success(booking);
    } catch (e) {
      CoreLogger.error('getById failed: $e');
      return RepositoryResult.failure(e.toString());
    }
  }

  @override
  Future<List<Booking>> getClientBookings(
    String clientId, {
    BookingActivityStatus? status,
    PaginationDto? pagination,
  }) async {
    CoreLogger.database('Fetching client bookings for: $clientId');
    try {
      var q = _client.from(_bookingsTable).select().eq('client_id', clientId);

      if (status != null) {
        q = q.eq('status', _bookingStatusToString(status));
      }

      // order by most recent scheduled start
      var ordered = q.order('scheduled_start_time', ascending: false);

      if (pagination != null) {
        final start = (pagination.page - 1) * pagination.limit;
        final end = start + pagination.limit - 1;
        ordered = ordered.range(start, end);
      }

      final rows = await ordered as List<dynamic>;
      return rows.map((e) => _mapToBooking(e as Map<String, dynamic>)).toList();
    } on PostgrestException catch (e) {
      CoreLogger.error('getClientBookings failed: ${e.message}');
      throw Failure.database(e.message);
    } catch (e, st) {
      CoreLogger.error('Unexpected getClientBookings error: $e', st);
      throw Failure.unexpected(e.toString());
    }
  }

  @override
  Future<List<Booking>> getProfessionalBookings(
    String professionalId, {
    BookingActivityStatus? status,
    DateTime? date,
    PaginationDto? pagination,
  }) async {
    CoreLogger.database('Fetching professional bookings for: $professionalId');
    try {
      var q = _client
          .from(_bookingsTable)
          .select()
          .eq('provider_id', professionalId);

      if (status != null) {
        q = q.eq('status', _bookingStatusToString(status));
      }

      if (date != null) {
        final startOfDay = DateTime(date.year, date.month, date.day);
        final endOfDay = startOfDay
            .add(const Duration(days: 1))
            .subtract(const Duration(microseconds: 1));
        q = q.gte('scheduled_start_time', startOfDay.toIso8601String());
        q = q.lte('scheduled_start_time', endOfDay.toIso8601String());
      }

      var ordered = q.order('scheduled_start_time', ascending: false);

      if (pagination != null) {
        final start = (pagination.page - 1) * pagination.limit;
        final end = start + pagination.limit - 1;
        ordered = ordered.range(start, end);
      }

      final rows = await ordered as List<dynamic>;
      return rows.map((e) => _mapToBooking(e as Map<String, dynamic>)).toList();
    } on PostgrestException catch (e) {
      CoreLogger.error('getProfessionalBookings failed: ${e.message}');
      throw Failure.database(e.message);
    } catch (e, st) {
      CoreLogger.error('Unexpected getProfessionalBookings error: $e', st);
      throw Failure.unexpected(e.toString());
    }
  }

  @override
  Future<List<Booking>> getUpcomingBookings(String userId) async {
    CoreLogger.database('Fetching upcoming bookings for user: $userId');
    try {
      final nowIso = DateTime.now().toIso8601String();
      // Use OR across client/provider and filter by scheduled_start_time >= now
      final q = _client
          .from(_bookingsTable)
          .select()
          .or('client_id.eq.$userId,provider_id.eq.$userId')
          .gte('scheduled_start_time', nowIso)
          .order('scheduled_start_time', ascending: true);

      final rows = await q as List<dynamic>;
      return rows.map((e) => _mapToBooking(e as Map<String, dynamic>)).toList();
    } on PostgrestException catch (e) {
      CoreLogger.error('getUpcomingBookings failed: ${e.message}');
      throw Failure.database(e.message);
    } catch (e, st) {
      CoreLogger.error('Unexpected getUpcomingBookings error: $e', st);
      throw Failure.unexpected(e.toString());
    }
  }

  @override
  Future<RepositoryResult<List<Booking>>> search(
    String query, {
    PaginationDto? pagination,
    Map<String, dynamic>? filters,
  }) async {
    try {
      // Perform OR ILIKE on id-like columns (client_id, provider_id, service_id)
      final q = query.trim();
      // Build filterable builder first
      final rqFilter = _client
          .from(_bookingsTable)
          .select()
          .or(
            'client_id.ilike.%$q%,provider_id.ilike.%$q%,service_id.ilike.%$q%',
          );

      // Optional status filter on the filter-builder
      final rqFiltered = (() {
        if (filters != null && filters['status'] is String) {
          return rqFilter.eq('status', filters['status']);
        } else if (filters != null &&
            filters['status'] is BookingActivityStatus) {
          final st = filters['status'] as BookingActivityStatus;
          return rqFilter.eq('status', _bookingStatusToString(st));
        }
        return rqFilter;
      })();

      // Now apply ordering, producing a TransformBuilder
      final rqOrdered = rqFiltered.order('scheduled_start_time');

      // Pagination
      final built = pagination != null
          ? rqOrdered.range(
              (pagination.page - 1) * pagination.limit,
              (pagination.page - 1) * pagination.limit + pagination.limit - 1,
            )
          : rqOrdered;

      final response = await built as List<dynamic>;
      final bookings = response
          .map((e) => _mapToBooking(e as Map<String, dynamic>))
          .toList();
      return RepositoryResult.success(bookings);
    } on PostgrestException catch (e) {
      CoreLogger.error('search failed: ${e.message}');
      return RepositoryResult.failure(e.message);
    } catch (e) {
      CoreLogger.error('search unexpected error: $e');
      return RepositoryResult.failure(e.toString());
    }
  }

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
    return _client
        .from(_bookingsTable)
        .stream(primaryKey: ['id'])
        .order('scheduled_start_time')
        .map((rows) => rows.map((e) => _mapToBooking(e)).toList());
  }

  @override
  Stream<Booking> watchBooking(String bookingId) {
    return _client
        .from(_bookingsTable)
        .stream(primaryKey: ['id'])
        .eq('id', bookingId)
        .map(
          (rows) => rows.isNotEmpty
              ? _mapToBooking(rows.first)
              : throw Failure.notFound('Booking $bookingId not found'),
        );
  }

  @override
  Stream<Booking?> watchById(String id) {
    return _client
        .from(_bookingsTable)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((rows) => rows.isNotEmpty ? _mapToBooking(rows.first) : null);
  }

  @override
  Stream<List<Booking>> watchUserBookings(String userId) {
    // Merge two filtered streams (client_id and provider_id) and de-duplicate by id.
    final clientStream = _client
        .from(_bookingsTable)
        .stream(primaryKey: ['id'])
        .eq('client_id', userId)
        .order('scheduled_start_time');

    final providerStream = _client
        .from(_bookingsTable)
        .stream(primaryKey: ['id'])
        .eq('provider_id', userId)
        .order('scheduled_start_time');

    // Combine latest from both streams
    List<Map<String, dynamic>> latestClient = const [];
    List<Map<String, dynamic>> latestProvider = const [];

    return clientStream
        .asyncMap((clientRows) async {
          latestClient = clientRows;
          // merge with latest provider
          final merged = <String, Map<String, dynamic>>{};
          for (final e in latestClient) {
            merged[e['id'] as String] = e;
          }
          for (final e in latestProvider) {
            merged[e['id'] as String] = e;
          }
          final list = merged.values.map((e) => _mapToBooking(e)).toList()
            ..sort(
              (a, b) => a.scheduledStartTime.compareTo(b.scheduledStartTime),
            );
          return list;
        })
        .asyncExpand((clientList) {
          // return a stream that also listens to provider updates and emits merged results
          return providerStream.map((providerRows) {
            latestProvider = providerRows;
            final merged = <String, Map<String, dynamic>>{};
            for (final e in latestClient) {
              merged[e['id'] as String] = e;
            }
            for (final e in latestProvider) {
              merged[e['id'] as String] = e;
            }
            final list = merged.values.map((e) => _mapToBooking(e)).toList()
              ..sort(
                (a, b) => a.scheduledStartTime.compareTo(b.scheduledStartTime),
              );
            return list;
          });
        });
  }
}
