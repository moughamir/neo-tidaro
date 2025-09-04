import 'package:shared/utils/type_defs.dart';

/// Base interface for remote data sources.
///
/// Defines the standard operations that any remote data source should provide.
/// Specific implementations (REST API, GraphQL, Supabase, etc.) will implement this interface.
abstract class RemoteDataSource {
  /// Fetches data from a remote endpoint.
  ResultFuture<dynamic> get(String endpoint, {Map<String, dynamic>? params});
  
  /// Posts data to a remote endpoint.
  ResultFuture<dynamic> post(String endpoint, {Map<String, dynamic>? body});
  
  /// Updates data at a remote endpoint.
  ResultFuture<dynamic> put(String endpoint, {Map<String, dynamic>? body});
  
  /// Deletes data at a remote endpoint.
  ResultFuture<dynamic> delete(String endpoint, {Map<String, dynamic>? params});
}
