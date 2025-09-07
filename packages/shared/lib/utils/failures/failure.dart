import 'package:equatable/equatable.dart';

/// Base failure class for error handling across the app
///
/// Used with Either<Failure, Success> pattern from fpdart for functional error handling
abstract class Failure extends Equatable {
  final String message;
  final int? code;

  const Failure(this.message, {this.code});
  
  @override
  List<Object?> get props => [message, code];
  
  /// Creates a server failure with optional error code
  factory Failure.server(String message, {int? code}) = ServerFailure;
  
  /// Creates a connection failure when network issues occur
  factory Failure.connection(String message) = ConnectionFailure;
  
  /// Creates a validation failure for input validation errors
  factory Failure.validation(String message) = ValidationFailure;
  
  /// Creates an unexpected failure for unhandled errors
  factory Failure.unexpected(String message) = UnexpectedFailure;
}

/// Failure related to server errors
class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

/// Failure related to network connection issues
class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message) : super(code: null);
}

/// Failure related to input validation
class ValidationFailure extends Failure {
  const ValidationFailure(super.message) : super(code: null);
}

/// Failure for unexpected errors
class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message) : super(code: null);
}
