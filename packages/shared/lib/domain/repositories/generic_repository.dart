library shared.repositories;

import 'package:shared/domain/domain.dart';
import 'package:shared/utils/type_defs.dart';

/// Generic repository interface for CRUD operations
///
/// Provides a standard contract for repositories to implement
/// using Either from fpdart for functional error handling
abstract class GenericRepository<T extends Entity> {
  /// Create a new entity
  ResultFuture<T> create(T entity);

  /// Read an entity by ID
  ResultFuture<T> read(String id);

  /// Update an existing entity
  ResultFuture<T> update(T entity);

  /// Delete an entity by ID
  ResultFuture<bool> delete(String id);

  /// Get all entities
  ResultFuture<List<T>> getAll();
}

/// Business-specific repository interfaces

abstract class ProfileRepository {
  Future<ProfileModel> findById(String id);
  Future<List<ProfileModel>> findAll();
  Future<ProfileModel> save(ProfileModel profile);
  Future<void> delete(String id);
}

abstract class AddressRepository {
  Future<AddressModel> findById(String id);
  Future<List<AddressModel>> findByProfileId(String profileId);
  Future<AddressModel> save(AddressModel address);
  Future<void> delete(String id);
}

abstract class ServiceRepository {
  Future<ServiceModel> findById(String id);
  Future<List<ServiceModel>> findAllActive();
  Future<ServiceModel> save(ServiceModel service);
  Future<void> delete(String id);
}

abstract class BookingRepository {
  Future<BookingModel> findById(String id);
  Future<List<BookingModel>> findByClientId(String clientId);
  Future<List<BookingModel>> findByProviderId(String providerId);
  Future<BookingModel> save(BookingModel booking);
  Future<void> cancel(String id, String reason);
}

abstract class PaymentRepository {
  Future<PaymentModel> findByBookingId(String bookingId);
  Future<PaymentModel> create(PaymentModel payment);
  Future<void> updateStatus(String id, PaymentStatus status);
}

abstract class MessageRepository {
  Future<List<MessageModel>> findByBookingId(String bookingId);
  Future<MessageModel> sendMessage(MessageModel message);
  Future<void> markAsRead(String id);
}

abstract class ReviewRepository {
  Future<ReviewModel> findByBookingId(String bookingId);
  Future<ReviewModel> submit(ReviewModel review);
  Future<void> verify(String id);
}

abstract class VerificationDocumentRepository {
  Future<List<VerificationDocumentModel>> findByProfileId(String profileId);
  Future<VerificationDocumentModel> upload(VerificationDocumentModel document);
  Future<void> approve(String id);
  Future<void> reject(String id, String reason);
}

abstract class AvailabilitySlotRepository {
  Future<List<AvailabilitySlotModel>> findByProviderId(String providerId);
  Future<AvailabilitySlotModel> create(AvailabilitySlotModel slot);
  Future<void> toggleAvailability(String id);
}

abstract class BlockedPeriodRepository {
  Future<List<BlockedPeriodModel>> findByProfileId(String profileId);
  Future<BlockedPeriodModel> create(BlockedPeriodModel period);
  Future<void> remove(String id);
}

abstract class AuditLogRepository {
  Future<List<AuditLogModel>> findAll();
  Future<AuditLogModel> log(AuditLogModel log);
}
