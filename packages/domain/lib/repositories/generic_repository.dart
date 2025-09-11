import '../entities/entities.dart';
import 'base_repository.dart';

/// Generic repository interface extending BaseRepository
/// Provides additional domain-specific operations
abstract class GenericRepository<T extends BaseEntity, C, U> 
    extends BaseRepository<T> {
  
  /// Creates entity from DTO
  Future<RepositoryResult<T>> createFromDto(C createDto);

  /// Updates entity by ID using DTO
  Future<RepositoryResult<T>> updateById(String id, U updateDto);

  /// Gets entities by multiple IDs
  Future<RepositoryResult<List<T>>> getAllByIds(List<String> ids);
}
