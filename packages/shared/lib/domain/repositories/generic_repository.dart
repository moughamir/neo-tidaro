import '../../utils/type_defs.dart';
import '../entities/entity.dart';

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
