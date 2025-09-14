import 'package:domain/domain.dart';
import 'package:shared/utils/logger.dart';

import 'supabase_booking_repository.dart';

/// Domain-facing adapter that implements the BookingRepository contract
/// by delegating to the Supabase-backed implementation, while ensuring
/// BaseRepository methods return RepositoryResult<T> as required by domain.
class BookingRepositoryAdapter
    implements BookingRepository, BaseRepository<Booking> {
  BookingRepositoryAdapter(this._supabase);
  final SupabaseBookingRepository _supabase;

  // ---------------- BaseRepository<Booking> ----------------
  @override
  Future<RepositoryResult<Booking>> getById(String id) async {
    try {
      final booking = await _supabase.findById(id);
      return RepositoryResult.success(booking);
    } catch (e) {
      CoreLogger.error('getById failed: $e');
      return RepositoryResult.failure(e.toString());
    }
  }

  @override
  Future<RepositoryResult<List<Booking>>> getAll({
    PaginationDto? pagination,
    PreBookingSortBy? sortBy,
  }) async {
    return _supabase.getAll(pagination: pagination, sortBy: sortBy);
  }

  @override
  Future<RepositoryResult<Booking>> create(Booking entity) async {
    try {
      // Delegate to save which upserts
      final saved = await _supabase.save(entity);
      return RepositoryResult.success(saved);
    } catch (e) {
      CoreLogger.error('create failed: $e');
      return RepositoryResult.failure(e.toString());
    }
  }

  @override
  Future<RepositoryResult<Booking>> update(Booking entity) async {
    try {
      final saved = await _supabase.save(entity);
      return RepositoryResult.success(saved);
    } catch (e) {
      CoreLogger.error('update failed: $e');
      return RepositoryResult.failure(e.toString());
    }
  }

  @override
  Future<RepositoryResult<bool>> delete(String id) async {
    try {
      // Use cancel with a generic reason when deleting is not supported.
      await _supabase.cancel(id, 'deleted via adapter');
      return RepositoryResult.success(true);
    } catch (e) {
      CoreLogger.error('delete failed: $e');
      return RepositoryResult.failure(e.toString());
    }
  }

  @override
  Stream<Booking?> watchById(String id) => _supabase.watchById(id);

  @override
  Stream<List<Booking>> watchAll() => _supabase.watchAll();

  @override
  Future<RepositoryResult<List<Booking>>> search(
    String query, {
    PaginationDto? pagination,
    Map<String, dynamic>? filters,
  }) async {
    return _supabase.search(query, pagination: pagination, filters: filters);
  }

  @override
  Future<RepositoryResult<List<Booking>>> createBatch(
    List<Booking> entities,
  ) async {
    try {
      final results = <Booking>[];
      for (final b in entities) {
        final saved = await _supabase.save(b);
        results.add(saved);
      }
      return RepositoryResult.success(results);
    } catch (e) {
      return RepositoryResult.failure(e.toString());
    }
  }

  @override
  Future<RepositoryResult<bool>> deleteBatch(List<String> ids) async {
    try {
      for (final id in ids) {
        await _supabase.cancel(id, 'batch delete via adapter');
      }
      return RepositoryResult.success(true);
    } catch (e) {
      return RepositoryResult.failure(e.toString());
    }
  }

  // ---------------- BookingRepository specifics ----------------

  @override
  Future<Booking> createBooking(CreateBookingDto dto) {
    // Delegate to underlying when implemented
    return _supabase.createBooking(dto);
  }

  @override
  Future<Booking> findById(String id) => _supabase.findById(id);

  @override
  Future<List<Booking>> findByClientId(String clientId) =>
      _supabase.findByClientId(clientId);

  @override
  Future<List<Booking>> findByProviderId(String providerId) =>
      _supabase.findByProviderId(providerId);

  @override
  Future<Booking> updateStatus(UpdateBookingStatusDto dto) =>
      _supabase.updateStatus(dto);

  @override
  Future<List<Booking>> getClientBookings(
    String clientId, {
    BookingActivityStatus? status,
    PaginationDto? pagination,
  }) => _supabase.getClientBookings(
    clientId,
    status: status,
    pagination: pagination,
  );

  @override
  Future<List<Booking>> getProfessionalBookings(
    String professionalId, {
    BookingActivityStatus? status,
    DateTime? date,
    PaginationDto? pagination,
  }) => _supabase.getProfessionalBookings(
    professionalId,
    status: status,
    date: date,
    pagination: pagination,
  );

  @override
  Future<List<Booking>> getUpcomingBookings(String userId) =>
      _supabase.getUpcomingBookings(userId);

  @override
  Future<List<Booking>> getBookingHistory(String userId) =>
      _supabase.getBookingHistory(userId);

  @override
  Future<bool> cancelBooking(String bookingId, String reason) =>
      _supabase.cancelBooking(bookingId, reason);

  @override
  Future<bool> confirmBooking(String bookingId) =>
      _supabase.confirmBooking(bookingId);

  @override
  Future<bool> completeBooking(String bookingId) =>
      _supabase.completeBooking(bookingId);

  @override
  Future<bool> checkAvailability({
    required String professionalId,
    required DateTime date,
    required TimeSlot timeSlot,
  }) => _supabase.checkAvailability(
    professionalId: professionalId,
    date: date,
    timeSlot: timeSlot,
  );

  @override
  Stream<List<Booking>> watchUserBookings(String userId) =>
      _supabase.watchUserBookings(userId);

  @override
  Stream<Booking> watchBooking(String bookingId) =>
      _supabase.watchBooking(bookingId);

  @override
  Future<Booking> save(Booking booking) => _supabase.save(booking);

  @override
  Future<void> cancel(String id, String reason) => _supabase.cancel(id, reason);

  @override
  Future<List<Booking>> findUpcomingBookings({
    String? clientId,
    String? providerId,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _supabase.findUpcomingBookings(
      clientId: clientId,
      providerId: providerId,
      startDate: startDate,
      endDate: endDate,
    );
  }
}
