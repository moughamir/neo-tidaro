import 'package:shared/utils/type_defs.dart';

/// Base interface for database services.
///
/// This defines the standard operations that any database service should provide.
/// Implementations will depend on the specific database provider (Supabase, Firebase, etc.).
abstract class DatabaseService {
  /// Fetches multiple rows from a table.
  ResultFuture<List<Map<String, dynamic>>> getTableData({
    required String table,
    Map<String, dynamic> equals = const {},
    String? orderBy,
    bool ascending = true,
    int? limit,
  });
  
  /// Fetches a single row from a table.
  ResultFuture<Map<String, dynamic>> getSingleTableData({
    required String table,
    Map<String, dynamic> equals = const {},
  });
  
  /// Inserts data into a table.
  ResultFuture<List<Map<String, dynamic>>> insertTableData({
    required String table,
    required List<Map<String, dynamic>> data,
  });
  
  /// Updates data in a table.
  ResultFuture<List<Map<String, dynamic>>> updateTableData({
    required String table,
    required Map<String, dynamic> data,
    required Map<String, dynamic> where,
  });
  
  /// Deletes data from a table.
  ResultFuture<void> deleteTableData({
    required String table,
    required Map<String, dynamic> where,
  });
  
  /// Executes a custom query.
  ResultFuture<dynamic> executeQuery(String query, {Map<String, dynamic>? params});
  
  /// Subscribes to table changes for realtime updates.
  Stream<List<Map<String, dynamic>>> subscribeToTable({required String table});
}
