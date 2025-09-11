
import '../dto/dto.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'base_repository.dart';

// Export all repository interfaces
export 'auth_repository.dart';
export 'base_repository.dart';

abstract class AddressRepository {
  Future<Address> findById(String id);
  Future<List<Address>> findByProfileId(String profileId);
  Future<Address> save(Address address);
  Future<void> delete(String id);
}

abstract class AnalyticsRepository {
  Future<void> trackEvent(String event, Map<String, dynamic> properties);
  Future<void> trackScreen(String screenName);
  Future<void> setUserProperties(Map<String, dynamic> properties);
  Future<Map<String, dynamic>> getDashboardMetrics(String userId);
  Future<List<Map<String, dynamic>>> getBookingTrends({
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Map<String, dynamic>> getPlatformStatistics();
}

abstract class AuditLogRepository {
  Future<List<ActivityLog>> findAll();
  Future<ActivityLog> log(ActivityLog log);
}


abstract class AvailabilitySlotRepository {
  Future<List<Availability>> findByProviderId(String providerId);
  Future<Availability> create(Availability slot);
  Future<void> toggleAvailability(String id);
}

abstract class BlockedPeriodRepository {
  Future<List<Availability>> findByProfileId(String profileId);
  Future<Availability> create(Availability period);
  Future<void> remove(String id);
}

abstract class BookingRepository {
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

  Future<List<Booking>> findUpcomingBookings({
    String? clientId,
    String? providerId,
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Booking> save(Booking booking);
  Future<void> cancel(String id, String reason);
}

abstract class ChatRepository {
  Future<Chat> createChatRoom(CreateChatRoomDto dto);
  Future<Chat?> getChatRoom(String id);
  Future<Chat?> getBookingChatRoom(String bookingId);
  Future<List<Chat>> getUserChatRooms(String userId);
  Future<Message> sendMessage(SendMessageDto dto);
  Future<List<Message>> getChatMessages(
    String chatRoomId, {
    PaginationDto? pagination,
  });
  Future<bool> markAsRead(String chatRoomId, String userId);
  Future<bool> deleteMessage(String messageId);
  Stream<List<Chat>> watchUserChatRooms(String userId);
  Stream<List<Message>> watchChatMessages(String chatRoomId);
  Stream<int> watchUnreadCount(String userId);
}

abstract class MessageRepository {
  Future<List<Message>> findByBookingId(String bookingId);
  Future<Message> sendMessage(Message message);
  Future<void> markAsRead(String id);
}

abstract class PaymentRepository {
  Future<Payment> findByBookingId(String bookingId);
  Future<Payment> create(Payment payment);
  Future<void> updateStatus(String id, PaymentStatus status);
}

abstract class ProfessionalRepository {
  Future<RepositoryResult<ProfessionalProfile>> getByUserId(String userId);
  Future<RepositoryResult<ProfessionalProfile>> register(
    ProfessionalRegistrationDto dto,
  );

  Future<RepositoryResult<List<ProfessionalProfile>>> searchProfessionals(
    ProfessionalSearchDto dto,
  );

  Future<RepositoryResult<List<ProfessionalProfile>>> getNearby({
    required GeoLocation location,
    required double radius,
    ServiceCategory? category,
  });

  Future<RepositoryResult<List<ProfessionalProfile>>> getTopRated({
    ServiceCategory? category,
    int limit = 10,
  });

  Future<RepositoryResult<bool>> updateAvailability(SetAvailabilityDto dto);
  Future<RepositoryResult<List<Availability>>> getAvailability(
    String professionalId,
  );

  Future<RepositoryResult<List<Service>>> getServices(String professionalId);
  Future<RepositoryResult<Service>> addService(CreateServiceDto dto);
  Future<RepositoryResult<bool>> updateService(Service service);
  Future<RepositoryResult<bool>> toggleServiceStatus(
    String serviceId,
    bool isActive,
  );

  Future<RepositoryResult<List<Review>>> getReviews(String professionalId);
  Future<RepositoryResult<ProfessionalStatistics>> getStatistics(
    String professionalId,
  );

  Stream<ProfessionalProfile> watchProfessional(String professionalId);
}

class ProfessionalStatistics {
  final double averageRating;
  final int totalReviews;
  final int completedJobs;
  final double responseRate;
  final Duration averageResponseTime;
  final int totalEarnings;
  final Map<ServiceCategory, int> jobsByCategory;

  const ProfessionalStatistics({
    required this.averageRating,
    required this.totalReviews,
    required this.completedJobs,
    required this.responseRate,
    required this.averageResponseTime,
    required this.totalEarnings,
    required this.jobsByCategory,
  });
}

abstract class ProfileRepository {
  Future<UserProfile> findById(String id);
  Future<List<UserProfile>> findAll();
  Future<UserProfile> save(UserProfile profile);
  Future<void> delete(String id);
}

abstract class ReviewRepository<T extends BaseEntity> {
  Future<Review> createReview({
    required String reviewerId,
    required String targetId,
    required double rating,
    String? comment,
    List<ReviewAspectRating>? aspectRatings,
  });

  Future<List<Review>> getReviewsForTarget(
    String targetId, {
    PaginationDto? pagination,
    SortBy? sortBy,
  });

  Future<List<Review>> getReviewsByReviewer(
    String reviewerId, {
    PaginationDto? pagination,
  });

  Future<ReviewSummary> getReviewSummary(String targetId);

  Future<bool> updateReview(Review review);
  Future<bool> deleteReview(String reviewId);

  Future<bool> reportReview(String reviewId, String reason);
  Future<bool> moderateReview(String reviewId, ModerationAction action);

  Stream<List<Review>> watchReviewsForTarget(String targetId);
  Future<Review> findByBookingId(String bookingId);
  Future<Review> submit(Review review);
  Future<void> verify(String id);
}

class ReviewAspectRating {
  final ReviewAspect aspect;
  final double rating;

  const ReviewAspectRating({required this.aspect, required this.rating});
}

class ReviewSummary {
  final double averageRating;
  final int totalReviews;
  final Map<int, int> ratingDistribution;
  final Map<ReviewAspect, double> aspectAverages;

  const ReviewSummary({
    required this.averageRating,
    required this.totalReviews,
    required this.ratingDistribution,
    required this.aspectAverages,
  });
}

abstract class ServiceRepository {
  Future<Service> findById(String id);
  Future<List<Service>> findAllActive();
  Future<Service> save(Service service);
  Future<void> delete(String id);
}

abstract class UserRepository {
  Future<RepositoryResult<User>> getByEmail(String email);
  Future<RepositoryResult<User>> getByPhone(String phoneNumber);

  Future<RepositoryResult<UserProfile>> getProfile(String userId);
  Future<RepositoryResult<UserProfile>> updateProfile(UserProfile profile);

  Future<RepositoryResult<List<Address>>> getUserAddresses(String userId);
  Future<RepositoryResult<Address>> addAddress(CreateAddressDto dto);
  Future<RepositoryResult<bool>> setDefaultAddress(
    String userId,
    String addressId,
  );

  Future<RepositoryResult<KycDocument>> submitKyc(SubmitKycDto dto);
  Future<RepositoryResult<KycLevel>> getKycLevel(String userId);

  Future<RepositoryResult<List<User>>> searchUsers({
    String? query,
    UserRole? role,
    UserStatus? status,
    PaginationDto? pagination,
    Map<String, dynamic>? additionalFilters,
  });
}

abstract class VerificationDocumentRepository {
  Future<List<KycDocument>> findByProfileId(String profileId);
  Future<KycDocument> upload(KycDocument document);
  Future<void> approve(String id);
  Future<void> reject(String id, String reason);
}
