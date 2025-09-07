library shared.redux.states.cleaner_state;

import 'package:fpdart/fpdart.dart';
import '../../domain/models/models.dart';
import '../core/core.dart';

/// Cleaner state for Redux store
class CleanerState extends BaseState {
  const CleanerState({
    required this.cleaners,
    required this.isLoading,
    required this.error,
    required this.filters,
    this.selectedCleanerId,
  });

  final List<Cleaner> cleaners;
  final bool isLoading;
  final Option<Exception> error;
  final CleanerFilters filters;
  final String? selectedCleanerId;

  /// Initial state factory
  factory CleanerState.initial() {
    return CleanerState(
      cleaners: const [],
      isLoading: false,
      error: none(),
      filters: const CleanerFilters(),
      selectedCleanerId: null,
    );
  }

  /// Loading state factory
  factory CleanerState.loading() {
    return CleanerState(
      cleaners: const [],
      isLoading: true,
      error: none(),
      filters: const CleanerFilters(),
      selectedCleanerId: null,
    );
  }

  /// Success state factory
  factory CleanerState.success({
    required List<Cleaner> cleaners,
    CleanerFilters? filters,
    String? selectedCleanerId,
  }) {
    return CleanerState(
      cleaners: cleaners,
      isLoading: false,
      error: none(),
      filters: filters ?? const CleanerFilters(),
      selectedCleanerId: selectedCleanerId,
    );
  }

  /// Error state factory
  factory CleanerState.error({
    required Exception error,
    List<Cleaner>? cleaners,
    CleanerFilters? filters,
    String? selectedCleanerId,
  }) {
    return CleanerState(
      cleaners: cleaners ?? const [],
      isLoading: false,
      error: some(error),
      filters: filters ?? const CleanerFilters(),
      selectedCleanerId: selectedCleanerId,
    );
  }

  /// Copy with method
  CleanerState copyWith({
    List<Cleaner>? cleaners,
    bool? isLoading,
    Option<Exception>? error,
    CleanerFilters? filters,
    String? selectedCleanerId,
  }) {
    return CleanerState(
      cleaners: cleaners ?? this.cleaners,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      filters: filters ?? this.filters,
      selectedCleanerId: selectedCleanerId ?? this.selectedCleanerId,
    );
  }

  /// Get filtered cleaners based on current filters
  List<Cleaner> get filteredCleaners {
    return cleaners.where((cleaner) {
      // Status filter
      if (filters.status != null && cleaner.status != filters.status) {
        return false;
      }

      // Service categories filter
      if (filters.serviceCategories != null &&
          filters.serviceCategories!.isNotEmpty) {
        final hasMatchingCategory = cleaner.serviceCategories
            .any((category) => filters.serviceCategories!.contains(category));
        if (!hasMatchingCategory) return false;
      }

      // Rating filter
      if (filters.minRating != null && cleaner.rating != null) {
        if (cleaner.rating! < filters.minRating!) return false;
      }

      // Verification filter
      if (filters.isVerified != null &&
          cleaner.isVerified != filters.isVerified) {
        return false;
      }

      return true;
    }).toList();
  }

  /// Get selected cleaner
  Cleaner? get selectedCleaner {
    if (selectedCleanerId == null) return null;
    try {
      return cleaners.firstWhere((cleaner) => cleaner.id == selectedCleanerId);
    } catch (e) {
      return null;
    }
  }

  @override
  String get stateType => 'CleanerState';

  @override
  List<Object?> get props => [
        cleaners,
        isLoading,
        error,
        filters,
        selectedCleanerId,
      ];

  @override
  String toString() {
    return 'CleanerState('
        'cleaners: ${cleaners.length}, '
        'isLoading: $isLoading, '
        'error: $error, '
        'filters: $filters, '
        'selectedCleanerId: $selectedCleanerId'
        ')';
  }
}
