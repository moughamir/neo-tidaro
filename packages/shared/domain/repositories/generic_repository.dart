// lib/shared/domain/repositories/generic_repository.dart

import 'package:tidaro/shared/domain/entities/entity.dart';
import 'package:tidaro/shared/utils/type_defs.dart';

/// An abstract interface for a generic repository providing standard CRUD operations.
///
/// This template ensures that all repositories have a consistent API for
/// common data manipulation tasks.
///
/// Type `T` must be a class that extends [Entity].
/// Type `C` is the type for the create data transfer object (DTO).
/// Type `U` is the type for the update data transfer object (DTO).
abstract class GenericRepository<T extends Entity, C, U> {
  /// Retrieves all items of type [T].
  ResultFuture<List<T>> getAll();

  /// Retrieves a single item by its unique [id].
  ResultFuture<T> getById(String id);

  /// Creates a new item.
  ResultFuture<T> create(C createDto);

  /// Updates an existing item.
  ResultFuture<T> update(String id, U updateDto);

  /// Deletes an item by its unique [id].
  ResultFuture<void> delete(String id);
}
