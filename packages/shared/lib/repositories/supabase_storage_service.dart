import 'dart:io';
import 'dart:typed_data';

import 'package:core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/utils/failures/failure.dart';
import 'package:shared/utils/type_defs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Comprehensive Supabase Storage Service for file management
class SupabaseStorageService {
  SupabaseStorageService(this._client);

  final SupabaseClient _client;

  /// Upload file to storage bucket
  ResultFuture<String> uploadFile({
    required String bucket,
    required String path,
    required File file,
    FileOptions? options,
  }) async {
    try {
      final result = await _client.storage
          .from(bucket)
          .upload(path, file, fileOptions: options);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Storage upload failed: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Upload file from bytes
  ResultFuture<String> uploadBytes({
    required String bucket,
    required String path,
    required Uint8List bytes,
    FileOptions? options,
  }) async {
    try {
      final result = await _client.storage
          .from(bucket)
          .uploadBinary(path, bytes, fileOptions: options);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Storage upload from bytes failed: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Download file as bytes
  ResultFuture<Uint8List> downloadFile({
    required String bucket,
    required String path,
  }) async {
    try {
      final result = await _client.storage.from(bucket).download(path);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Storage download failed: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Get public URL for a file
  String getPublicUrl({
    required String bucket,
    required String path,
    TransformOptions? transform,
  }) {
    return _client.storage
        .from(bucket)
        .getPublicUrl(path, transform: transform);
  }

  /// Get signed URL with expiration
  ResultFuture<String> getSignedUrl({
    required String bucket,
    required String path,
    required int expiresIn,
    TransformOptions? transform,
  }) async {
    try {
      final result = await _client.storage
          .from(bucket)
          .createSignedUrl(path, expiresIn, transform: transform);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to create signed URL: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// List files in a bucket
  ResultFuture<List<FileObject>> listFiles({
    required String bucket,
    String? path,
    SearchOptions? searchOptions,
  }) async {
    try {
      final result = await _client.storage
          .from(bucket)
          .list(path: path, searchOptions: searchOptions);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to list files: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Delete file from storage
  ResultFuture<List<FileObject>> deleteFile({
    required String bucket,
    required String path,
  }) async {
    try {
      final result = await _client.storage.from(bucket).remove([path]);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to delete file: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Delete multiple files
  ResultFuture<List<FileObject>> deleteFiles({
    required String bucket,
    required List<String> paths,
  }) async {
    try {
      final result = await _client.storage.from(bucket).remove(paths);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to delete files: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Move/rename file
  ResultFuture<String> moveFile({
    required String bucket,
    required String fromPath,
    required String toPath,
  }) async {
    try {
      final result = await _client.storage.from(bucket).move(fromPath, toPath);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to move file: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Copy file
  ResultFuture<String> copyFile({
    required String bucket,
    required String fromPath,
    required String toPath,
  }) async {
    try {
      final result = await _client.storage.from(bucket).copy(fromPath, toPath);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to copy file: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Create storage bucket
  ResultFuture<String> createBucket({
    required String bucketId,
    CreateBucketOptions? options,
  }) async {
    try {
      final result = await _client.storage.createBucket(bucketId, options);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to create bucket: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Get bucket details
  ResultFuture<Bucket> getBucket(String bucketId) async {
    try {
      final result = await _client.storage.getBucket(bucketId);
      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to get bucket: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// List all buckets
  ResultFuture<List<Bucket>> listBuckets() async {
    try {
      final result = await _client.storage.listBuckets();
      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to list buckets: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Update bucket
  ResultFuture<String> updateBucket({
    required String bucketId,
    required BucketOptions options,
  }) async {
    try {
      final result = await _client.storage.updateBucket(bucketId, options);

      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to update bucket: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Delete bucket
  ResultFuture<String> deleteBucket(String bucketId) async {
    try {
      final result = await _client.storage.deleteBucket(bucketId);
      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to delete bucket: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Empty bucket (delete all files)
  ResultFuture<List<FileObject>> emptyBucket(String bucketId) async {
    try {
      final result = await _client.storage.emptyBucket(bucketId);
      return right(result);
    } on StorageException catch (e) {
      CoreLogger.error('Failed to empty bucket: ${e.message}');
      return left(Failure.storage(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected storage error: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }
}

/// File upload helper with progress tracking
class FileUploadHelper {
  FileUploadHelper(this._storageService);

  final SupabaseStorageService _storageService;

  /// Upload file with progress callback
  Future<Either<Failure, String>> uploadFileWithProgress({
    required String bucket,
    required String path,
    required File file,
    void Function(double progress)? onProgress,
    FileOptions? options,
  }) async {
    try {
      // For now, we'll use the standard upload
      // In a real implementation, you might want to implement chunked upload
      // with progress tracking

      final result = await _storageService.uploadFile(
        bucket: bucket,
        path: path,
        file: file,
        options: options,
      );

      // Simulate progress completion
      onProgress?.call(1.0);

      return result;
    } catch (e) {
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Upload multiple files with progress
  Stream<FileUploadResult> uploadMultipleFiles({
    required String bucket,
    required List<FileUploadRequest> requests,
  }) async* {
    for (int i = 0; i < requests.length; i++) {
      final request = requests[i];

      yield FileUploadResult(
        fileName: request.fileName,
        status: UploadStatus.uploading,
        progress: 0.0,
      );

      final result = await _storageService.uploadFile(
        bucket: bucket,
        path: request.path,
        file: request.file,
        options: request.options,
      );

      yield result.fold(
        (failure) => FileUploadResult(
          fileName: request.fileName,
          status: UploadStatus.failed,
          error: failure.message,
          progress: 0.0,
        ),
        (path) => FileUploadResult(
          fileName: request.fileName,
          status: UploadStatus.completed,
          progress: 1.0,
          uploadedPath: path,
        ),
      );
    }
  }
}

/// Data classes for file upload
class FileUploadRequest {
  const FileUploadRequest({
    required this.fileName,
    required this.path,
    required this.file,
    this.options,
  });

  final String fileName;
  final String path;
  final File file;
  final FileOptions? options;
}

class FileUploadResult {
  const FileUploadResult({
    required this.fileName,
    required this.status,
    required this.progress,
    this.uploadedPath,
    this.error,
  });

  final String fileName;
  final UploadStatus status;
  final double progress;
  final String? uploadedPath;
  final String? error;
}

enum UploadStatus { waiting, uploading, completed, failed }
