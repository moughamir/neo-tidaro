import 'package:domain/domain.dart';
import 'package:shared/utils/type_defs.dart';

/// An abstract interface for a generic repository providing standard CRUD operations.
///
/// This template ensures that all repositories have a consistent API for
/// common data manipulation tasks.
///
/// Type `T` must be a class that extends [BaseEntity].
/// Type `C` is the type for the create data transfer object (DTO).
/// Type `U` is the type for the update data transfer object (DTO).
/// Generic repository interface for CRUD operations
///
/// Provides a standard contract for repositories to implement
/// using Either from fpdart for functional error handling
abstract class GenericRepository<T extends BaseEntity, C, U> {
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
