import 'package:equatable/equatable.dart';

/// UI state for managing application-wide UI concerns
class UiState extends Equatable {
  const UiState({
    required this.isLoading,
    required this.counter,
    this.error,
    this.successMessage,
  });

  final bool isLoading;
  final int counter;
  final String? error;
  final String? successMessage;

  /// Initial state factory
  const UiState.initial()
      : isLoading = false,
        counter = 0,
        error = null,
        successMessage = null;

  /// Copy with method for immutable updates
  UiState copyWith({
    bool? isLoading,
    int? counter,
    String? error,
    String? successMessage,
  }) {
    return UiState(
      isLoading: isLoading ?? this.isLoading,
      counter: counter ?? this.counter,
      error: error,
      successMessage: successMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, counter, error, successMessage];

  @override
  String toString() => 'UiState(isLoading: $isLoading, counter: $counter, error: $error, successMessage: $successMessage)';
}
