import '../dto/dto.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'base_repository.dart';

abstract class BookingRepository extends BaseRepository<Booking> {
  Future<Booking> createBooking(CreateBookingDto dto);
  Future<Booking> findById(String id);
  Future<List<Booking>> findByClientId(String clientId);
  Future<List<Booking>> findByProviderId(String providerId);
  Future<Booking> updateStatus(UpdateBookingStatusDto dto);
  Future<List<Booking>> getClientBookings(
    String clientId, {
    BookingStatus? status,
    PaginationDto? pagination,
  });
  Future<List<Booking>> getProfessionalBookings(
    String professionalId, {
    BookingStatus? status,
    DateTime? date,
    PaginationDto? pagination,
  });
  Future<List<Booking>> getUpcomingBookings(String userId);
  Future<List<Booking>> getBookingHistory(String userId);
  Future<bool> cancelBooking(String bookingId, String reason);
  Future<bool> confirmBooking(String bookingId);
  Future<bool> completeBooking(String bookingId);
  Future<bool> checkAvailability({
    required String professionalId,
    required DateTime date,
    required TimeSlot timeSlot,
  });
  Stream<List<Booking>> watchUserBookings(String userId);
  Stream<Booking> watchBooking(String bookingId);

  /// Finds upcoming bookings based on the provided filters.
  ///
  /// - [clientId]: Optional filter for bookings by client ID
  /// - [providerId]: Optional filter for bookings by provider ID
  /// - [startDate]: Optional start date for filtering bookings
  /// - [endDate]: Optional end date for filtering bookings
  ///
  /// Returns a list of upcoming bookings matching the filters.
  Future<List<Booking>> findUpcomingBookings({
    String? clientId,
    String? providerId,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Booking> save(Booking booking);
  Future<void> cancel(String id, String reason);
}
