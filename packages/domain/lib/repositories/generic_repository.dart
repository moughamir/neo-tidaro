import '../entities/entities.dart';
import 'base_repository.dart';

/// Generic repository interface extending [BaseRepository].
///
/// Type parameters:
/// - [T] The domain entity type, constrained to [BaseEntity]
/// - [C] The DTO type used for create operations
/// - [U] The DTO type used for update operations
abstract class GenericRepository<T extends BaseEntity, C, U>
    extends BaseRepository<T> {
  /// Creates an entity from a create DTO [createDto].
  ///
  /// Returns a [RepositoryResult.success] containing the created [T] on
  /// success, or [RepositoryResult.failure] with an error message on failure.
  Future<RepositoryResult<T>> createFromDto(C createDto);

  /// Updates an entity identified by [id] using an update DTO [updateDto].
  ///
  /// Returns a [RepositoryResult.success] containing the updated [T] on
  /// success, or [RepositoryResult.failure] with an error message on failure.
  Future<RepositoryResult<T>> updateById(String id, U updateDto);

  /// Retrieves entities matching the provided list of [ids].
  ///
  /// Returns a [RepositoryResult.success] containing a list of [T] on
  /// success, or [RepositoryResult.failure] with an error message on failure.
  Future<RepositoryResult<List<T>>> getAllByIds(List<String> ids);
}
