// lib/shared/utils/type_defs.dart

import 'package:kui/kui.dart';

/// A common type definition for a Future that returns an Either type,
/// representing a potential failure or a successful result.
typedef ResultFuture<T> = Future<Either<Failure, T>>;

/// A common type definition for a Future that returns void on success.
typedef ResultVoid = ResultFuture<Unit>;

/// A common type definition for a map of string keys to dynamic values,
/// typically used for JSON serialization and deserialization.
typedef DataMap = Map<String, dynamic>;
