import 'package:domain/entities/base_entity.dart';
import 'package:fpdart/fpdart.dart';

import 'package:shared/utils/type_defs.dart';
import 'package:shared/utils/failures/failure.dart';
import 'package:shared/utils/logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide SortBy;

/// Base class for Supabase repositories that provides common CRUD operations.
///
/// [T] is the entity type
/// [C] is the create DTO type
/// [U] is the update DTO type
abstract class SupabaseRepository<T extends BaseEntity, C, U> {
  /// The table name in Supabase
  final String tableName;

  /// The Supabase client
  final SupabaseClient _client;

  /// Creates a new Supabase repository
  SupabaseRepository(this.tableName, SupabaseClient client) : _client = client;

  /// Converts a Map from Supabase to an entity
  T fromJson(Map<String, dynamic> json);

  /// Converts an entity to a Map for Supabase
  Map<String, dynamic> toJson(T entity);

  /// Creates a new entity in Supabase
  ResultFuture<T> create(T entity) async {
    try {
      final data = toJson(entity);
      final response = await _client
          .from(tableName)
          .insert(data)
          .select()
          .single();

      return right(fromJson(response));
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to create $tableName: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error creating $tableName: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Creates a new entity from a DTO in Supabase
  ResultFuture<T> createFromDto(C createDto) async {
    try {
      final response = await _client
          .from(tableName)
          .insert(createDto as Map<String, dynamic>)
          .select()
          .single();

      return right(fromJson(response));
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to create $tableName from DTO: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error creating $tableName from DTO: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Reads an entity by ID from Supabase
  ResultFuture<T> read(String id) async {
    try {
      final response =
          await _client.from(tableName).select().eq('id', id).single()
              as Map<String, dynamic>?;

      if (response == null) {
        return left(Failure.notFound('$tableName with id $id not found'));
      }

      return right(fromJson(response));
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to read $tableName with id $id: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error reading $tableName with id $id: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Updates an existing entity in Supabase
  ResultFuture<T> update(T entity) async {
    try {
      final data = toJson(entity);
      final response = await _client
          .from(tableName)
          .update(data)
          .eq('id', entity.id)
          .select()
          .single();

      return right(fromJson(response));
    } on PostgrestException catch (e) {
      CoreLogger.error(
        'Failed to update $tableName with id ${entity.id}: ${e.message}',
      );
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error(
        'Unexpected error updating $tableName with id ${entity.id}: $e',
      );
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Updates an entity by ID from a DTO in Supabase
  ResultFuture<T> updateById(String id, U updateDto) async {
    try {
      final response = await _client
          .from(tableName)
          .update(updateDto as Map<String, dynamic>)
          .eq('id', id)
          .select()
          .single();

      return right(fromJson(response));
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to update $tableName with id $id: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error updating $tableName with id $id: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Deletes an entity by ID from Supabase
  ResultFuture<bool> delete(String id) async {
    try {
      await _client.from(tableName).delete().eq('id', id);

      return right(true);
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to delete $tableName with id $id: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error deleting $tableName with id $id: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Gets all entities from Supabase
  ResultFuture<List<T>> getAll() async {
    try {
      final response = await _client.from(tableName).select() as List<dynamic>;

      return right(
        response.map((json) => fromJson(json as Map<String, dynamic>)).toList(),
      );
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to get all $tableName: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error getting all $tableName: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Gets an entity by ID from Supabase
  ResultFuture<T> getById(String id) => read(id);

  /// Gets multiple entities by their IDs from Supabase
  ResultFuture<List<T>> getAllByIds(List<String> ids) async {
    try {
      final response = await _client
          .from(tableName)
          .select()
          .filter('id', 'in', ids)
          .asStream()
          .toList();

      return right(
        response.map((json) => fromJson(json as Map<String, dynamic>)).toList(),
      );
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to get $tableName by ids: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error getting $tableName by ids: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }
}
