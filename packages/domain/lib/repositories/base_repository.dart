/// Generic Base Repository for Domain Layer
/// Pure domain interface - dependency-free

import '../dto/pagination_dto.dart';

import '../enums/enums.dart';

/// Generic result wrap
/// per for repository operations
class RepositoryResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  const RepositoryResult._({this.data, this.error, required this.isSuccess});

  factory RepositoryResult.success(T data) =>
      RepositoryResult._(data: data, isSuccess: true);

  factory RepositoryResult.failure(String error) =>
      RepositoryResult._(error: error, isSuccess: false);
}

/// Generic base repository with common CRUD operations
abstract class BaseRepository<T> {
  // Basic CRUD operations
  Future<RepositoryResult<T>> getById(String id);
  Future<RepositoryResult<List<T>>> getAll({
    PaginationDto? pagination,
    SortBy? sortBy,
  });
  Future<RepositoryResult<T>> create(T entity);
  Future<RepositoryResult<T>> update(T entity);
  Future<RepositoryResult<bool>> delete(String id);

  // Reactive streams
  Stream<T?> watchById(String id);
  Stream<List<T>> watchAll();

  // Search and filtering
  Future<RepositoryResult<List<T>>> search(
    String query, {
    PaginationDto? pagination,
    Map<String, dynamic>? filters,
  });

  // Batch operations
  Future<RepositoryResult<List<T>>> createBatch(List<T> entities);
  Future<RepositoryResult<bool>> deleteBatch(List<String> ids);
}
