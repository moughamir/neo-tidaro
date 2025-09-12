import 'package:equatable/equatable.dart';

/// Base failure class for error handling across the app
///
/// Used with Either<Failure, Success> pattern from fpdart for functional error handling
abstract class Failure extends Equatable {
  final String message;
  final int? code;
  final Map<String, dynamic>? details;

  const Failure(this.message, {this.code, this.details});
  
  @override
  List<Object?> get props => [message, code, details];
  
  /// Creates a server failure with optional error code
  factory Failure.server(String message, {int? code, Map<String, dynamic>? details}) = ServerFailure;
  
  /// Creates a connection failure when network issues occur
  factory Failure.connection(String message, {Map<String, dynamic>? details}) = ConnectionFailure;
  
  /// Creates a validation failure for input validation errors
  factory Failure.validation(String message, {Map<String, dynamic>? details}) = ValidationFailure;
  
  /// Creates an unexpected failure for unhandled errors
  factory Failure.unexpected(String message, {Map<String, dynamic>? details}) = UnexpectedFailure;
  
  /// Creates a database operation failure
  factory Failure.database(String message, {int? code, Map<String, dynamic>? details}) = DatabaseFailure;
  
  /// Creates a not found failure
  factory Failure.notFound(String message, {Map<String, dynamic>? details}) = NotFoundFailure;
  
  /// Creates a copy of this failure with the given fields replaced
  Failure copyWith({
    String? message,
    int? code,
    Map<String, dynamic>? details,
  }) {
    return this.runtimeType == ServerFailure
        ? Failure.server(message ?? this.message, code: code ?? this.code, details: details ?? this.details)
        : this.runtimeType == ConnectionFailure
            ? Failure.connection(message ?? this.message, details: details ?? this.details)
            : this.runtimeType == ValidationFailure
                ? Failure.validation(message ?? this.message, details: details ?? this.details)
                : this.runtimeType == DatabaseFailure
                    ? Failure.database(message ?? this.message, code: code ?? this.code, details: details ?? this.details)
                    : this.runtimeType == NotFoundFailure
                        ? Failure.notFound(message ?? this.message, details: details ?? this.details)
                        : Failure.unexpected(message ?? this.message, details: details ?? this.details);
  }
}

/// Failure related to server errors
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code, super.details});
}

/// Failure related to network connection issues
class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message, {super.details}) : super(code: null);
}

/// Failure related to input validation
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {super.details}) : super(code: null);
}

/// Failure for unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message, {super.details}) : super(code: null);
}

/// Failure related to database operations
class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message, {super.code, super.details});
}

/// Failure for when a requested resource is not found
class NotFoundFailure extends Failure {
  const NotFoundFailure(super.message, {super.details}) : super(code: 404);
}
