library shared.repositories;

import 'package:shared/domain/domain.dart';
import 'package:shared/utils/type_defs.dart';

/// An abstract interface for a generic repository providing standard CRUD operations.
///
/// This template ensures that all repositories have a consistent API for
/// common data manipulation tasks.
///
/// Type `T` must be a class that extends [Entity].
/// Type `C` is the type for the create data transfer object (DTO).
/// Type `U` is the type for the update data transfer object (DTO).
/// Generic repository interface for CRUD operations
///
/// Provides a standard contract for repositories to implement
/// using Either from fpdart for functional error handling
abstract class GenericRepository<T extends Entity, C, U> {
  /// Create a new entity
  ResultFuture<T> create(T entity);

  /// Creates a new item.
  ResultFuture<T> createFromDto(C createDto);

  /// Read an entity by ID
  ResultFuture<T> read(String id);

  /// Update an existing entity
  ResultFuture<T> update(T entity);

  /// Updates an existing item.
  ResultFuture<T> updateById(String id, U updateDto);

  /// Delete an entity by ID
  ResultFuture<bool> delete(String id);

  /// Deletes an item by its unique [id].
  ResultFuture<void> deleteById(String id);

  /// Get all entities
  ResultFuture<List<T>> getAll();

  /// Retrieves a single item by its unique [id].
  ResultFuture<T> getById(String id);

  /// Retrieves all items of type [T].
  ResultFuture<List<T>> getAllByIds(List<String> ids);
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
