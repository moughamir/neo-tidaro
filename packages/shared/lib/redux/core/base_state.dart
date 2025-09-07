import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

/// Base state interface following SOLID principles
/// All Redux states must implement this interface
abstract class BaseState extends Equatable {
  const BaseState();

  /// State identifier for debugging
  String get stateType;

  @override
  String toString() => '$stateType()';
}

/// Base async state for operations that can fail
/// Uses functional programming with Either<Failure, T>
abstract class BaseAsyncState<T> extends BaseState {
  const BaseAsyncState({
    required this.isLoading,
    required this.data,
    required this.error,
  });

  final bool isLoading;
  final Option<T> data;
  final Option<Exception> error;

  /// Check if state has data
  bool get hasData => data.isSome();

  /// Check if state has error
  bool get hasError => error.isSome();

  /// Get data safely
  T? get dataOrNull => data.toNullable();

  /// Get error safely
  Exception? get errorOrNull => error.toNullable();

  @override
  List<Object?> get props => [isLoading, data, error];
}

/// Initial state factory
class InitialState extends BaseState {
  const InitialState();

  @override
  String get stateType => 'InitialState';

  @override
  List<Object?> get props => [];
}

/// Loading state
class LoadingState extends BaseState {
  const LoadingState();

  @override
  String get stateType => 'LoadingState';

  @override
  List<Object?> get props => [];
}

/// Success state with data
class SuccessState<T> extends BaseState {
  const SuccessState(this.data);

  final T data;

  @override
  String get stateType => 'SuccessState<$T>';

  @override
  List<Object?> get props => [data];
}

/// Error state
class ErrorState extends BaseState {
  const ErrorState(this.error, {this.metadata});

  final Exception error;
  final Map<String, dynamic>? metadata;

  @override
  String get stateType => 'ErrorState';

  @override
  List<Object?> get props => [error, metadata];
}

/// State factory utilities following DRY principles
class StateFactory {
  const StateFactory._();

  /// Create initial state
  static InitialState initial() => const InitialState();

  /// Create loading state
  static LoadingState loading() => const LoadingState();

  /// Create success state
  static SuccessState<T> success<T>(T data) => SuccessState(data);

  /// Create error state
  static ErrorState error(Exception error, {Map<String, dynamic>? metadata}) =>
      ErrorState(error, metadata: metadata);
}
