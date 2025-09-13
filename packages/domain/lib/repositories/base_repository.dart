/// Generic Base Repository for Domain Layer
/// Pure domain interface - dependency-free. This file declares the foundational
/// repository contracts used across the domain. Implementations must live in
/// infrastructure layers (e.g., in `packages/shared/`) and depend on this
/// domain contract, never the other way around.
library;

import '../dto/pagination_dto.dart';

import '../enums/enums.dart';

/// Result wrapper for repository operations.
///
/// Encapsulates the outcome of a repository call with either a `data` payload
/// on success or an `error` message on failure.
///
/// - `T` is the type of the returned data
/// - `isSuccess` indicates whether the operation succeeded
/// - `data` is non-null when `isSuccess` is true
/// - `error` is non-null when `isSuccess` is false
class RepositoryResult<T> {
  const RepositoryResult._({this.data, this.error, required this.isSuccess});

  /// Creates a successful result with the provided [data].
  factory RepositoryResult.success(T data) =>
      RepositoryResult._(data: data, isSuccess: true);

  /// Creates a failed result with the provided [error] message.
  factory RepositoryResult.failure(String error) =>
      RepositoryResult._(error: error, isSuccess: false);
  final T? data;
  final String? error;
  final bool isSuccess;
}

/// Generic base repository with common CRUD operations.
///
/// Implementations should not throw for expected error cases; instead, return
/// a [RepositoryResult.failure] with a meaningful message. Streams should be
/// hot and reflect live updates when the storage layer supports it.
abstract class BaseRepository<T> {
  // Basic CRUD operations
  /// Fetches an entity by its [id].
  Future<RepositoryResult<T>> getById(String id);

  /// Fetches all entities, optionally paginated and sorted.
  Future<RepositoryResult<List<T>>> getAll({
    PaginationDto? pagination,
    PreBookingSortBy? sortBy,
  });

  /// Creates a new [entity]. Returns the created entity on success.
  Future<RepositoryResult<T>> create(T entity);

  /// Updates an existing [entity]. Returns the updated entity on success.
  Future<RepositoryResult<T>> update(T entity);

  /// Deletes the entity with the given [id]. Returns true on success.
  Future<RepositoryResult<bool>> delete(String id);

  // Reactive streams
  /// Watches a single entity by [id]. Emits `null` when it no longer exists.
  Stream<T?> watchById(String id);

  /// Watches all entities. Emits on any collection change.
  Stream<List<T>> watchAll();

  // Search and filtering
  /// Performs a free-text [query] search with optional [pagination] and
  /// arbitrary [filters].
  Future<RepositoryResult<List<T>>> search(
    String query, {
    PaginationDto? pagination,
    Map<String, dynamic>? filters,
  });

  // Batch operations
  /// Creates multiple [entities] in a single operation.
  Future<RepositoryResult<List<T>>> createBatch(List<T> entities);

  /// Deletes multiple entities by [ids] in a single operation.
  Future<RepositoryResult<bool>> deleteBatch(List<String> ids);
}
