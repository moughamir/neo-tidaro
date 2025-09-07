import 'package:fpdart/fpdart.dart';

import 'failures/failure.dart';

/// Type definition for result-returning functions using Either from fpdart
///
/// Standardizes error handling across the application using Either<Failure, T>
typedef Result<T> = Either<Failure, T>;

/// Type definition for async result-returning functions using Either from fpdart
///
/// Standardizes async error handling across the application using Future<Either<Failure, T>>
typedef ResultFuture<T> = Future<Result<T>>;

/// Type definition for void result operations using Either from fpdart
///
/// Standardizes void operations that can fail using Future<Either<Failure, void>>
typedef ResultVoid = ResultFuture<void>;

/// Type definition for void callback functions
///
/// Used for consistent typing of callback functions that don't return a value
typedef VoidCallback = void Function();
