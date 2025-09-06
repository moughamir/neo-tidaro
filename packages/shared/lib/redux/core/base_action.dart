import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

/// Base action interface following SOLID principles
/// All Redux actions must implement this interface
abstract class BaseAction extends Equatable {
  const BaseAction();

  /// Action type identifier
  String get type;

  /// Optional payload for the action
  dynamic get payload => null;

  /// Optional metadata for the action
  Map<String, dynamic> get metadata => const {};

  @override
  List<Object?> get props => [type, payload, metadata];

  @override
  String toString() => 'BaseAction(type: $type, payload: $payload)';
}

/// Base async action for operations that can fail
/// Uses functional programming with Either<Failure, T>
abstract class BaseAsyncAction<T> extends BaseAction {
  const BaseAsyncAction();

  /// Execute the async operation
  Future<Either<Exception, T>> execute();
}

/// Request action for async operations
class RequestAction extends BaseAction {
  const RequestAction(this.actionType, {this.requestPayload});

  final String actionType;
  final dynamic requestPayload;

  @override
  String get type => '${actionType}_REQUEST';

  @override
  dynamic get payload => requestPayload;
}

/// Success action for async operations
class SuccessAction<T> extends BaseAction {
  const SuccessAction(this.actionType, this.data);

  final String actionType;
  final T data;

  @override
  String get type => '${actionType}_SUCCESS';

  @override
  T get payload => data;
}

/// Failure action for async operations
class FailureAction extends BaseAction {
  const FailureAction(this.actionType, this.error, {this.errorMetadata});

  final String actionType;
  final Exception error;
  final Map<String, dynamic>? errorMetadata;

  @override
  String get type => '${actionType}_FAILURE';

  @override
  Exception get payload => error;

  @override
  Map<String, dynamic> get metadata => errorMetadata ?? const {};
}

/// Action creator utilities following DRY principles
class ActionCreators {
  const ActionCreators._();

  /// Create request action
  static RequestAction request(String actionType, {dynamic payload}) =>
      RequestAction(actionType, requestPayload: payload);

  /// Create success action
  static SuccessAction<T> success<T>(String actionType, T data) =>
      SuccessAction(actionType, data);

  /// Create failure action
  static FailureAction failure(
    String actionType,
    Exception error, {
    Map<String, dynamic>? metadata,
  }) =>
      FailureAction(actionType, error, errorMetadata: metadata);
}
