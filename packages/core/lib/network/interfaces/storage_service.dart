import 'dart:io';

import 'package:shared/utils/type_defs.dart';

/// Base interface for storage services.
///
/// This defines the standard operations that any storage service should provide.
/// Implementations will depend on the specific storage provider (Supabase, Firebase, etc.).
abstract class StorageService {
  /// Uploads a file to storage.
  ResultFuture<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
  });
  
  /// Downloads a file from storage.
  ResultFuture<File> downloadFile({
    required String bucket,
    required String path,
    required String destinationPath,
  });
  
  /// Deletes a file from storage.
  ResultFuture<void> deleteFile({
    required String bucket,
    required String path,
  });
  
  /// Gets the public URL of a file.
  String getPublicUrl({
    required String bucket,
    required String path,
  });
  
  /// Lists files in a bucket or directory.
  ResultFuture<List<String>> listFiles({
    required String bucket,
    String? prefix,
  });
}
