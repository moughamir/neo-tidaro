library;

import 'package:domain/domain.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/redux/core/core.dart';

/// Professional state for Redux store
class ProfessionalState extends BaseState {

  /// Initial state factory
  factory ProfessionalState.initial() {
    return ProfessionalState(
      professionals: const [],
      isLoading: false,
      error: none(),
      filters: const ProfessionalSearchDto(),
      selectedProfessionalId: null,
    );
  }

  /// Loading state factory
  factory ProfessionalState.loading() {
    return ProfessionalState(
      professionals: const [],
      isLoading: true,
      error: none(),
      filters: const ProfessionalSearchDto(),
      selectedProfessionalId: null,
    );
  }

  /// Success state factory
  factory ProfessionalState.success({
    required List<ProfessionalProfile> professionals,
    ProfessionalSearchDto? filters,
    String? selectedProfessionalId,
  }) {
    return ProfessionalState(
      professionals: professionals,
      isLoading: false,
      error: none(),
      filters: filters ?? const ProfessionalSearchDto(),
      selectedProfessionalId: selectedProfessionalId,
    );
  }

  /// Error state factory
  factory ProfessionalState.error({
    required Exception error,
    List<ProfessionalProfile>? professionals,
    ProfessionalSearchDto? filters,
    String? selectedProfessionalId,
  }) {
    return ProfessionalState(
      professionals: professionals ?? const [],
      isLoading: false,
      error: some(error),
      filters: filters ?? const ProfessionalSearchDto(),
      selectedProfessionalId: selectedProfessionalId,
    );
  }
  const ProfessionalState({
    required this.professionals,
    required this.isLoading,
    required this.error,
    required this.filters,
    this.selectedProfessionalId,
  });

  final List<ProfessionalProfile> professionals;
  final bool isLoading;
  final Option<Exception> error;
  final ProfessionalSearchDto filters;
  final String? selectedProfessionalId;

  /// Copy with method
  ProfessionalState copyWith({
    List<ProfessionalProfile>? professionals,
    bool? isLoading,
    Option<Exception>? error,
    ProfessionalSearchDto? filters,
    String? selectedProfessionalId,
  }) {
    return ProfessionalState(
      professionals: professionals ?? this.professionals,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      filters: filters ?? this.filters,
      selectedProfessionalId:
          selectedProfessionalId ?? this.selectedProfessionalId,
    );
  }

  /// Get filtered professionals based on current filters
  List<ProfessionalProfile> get filteredProfessionals {
    return professionals.where((professional) {
      // Service categories filter
      if (filters.categories != null && filters.categories!.isNotEmpty) {
        final hasMatchingCategory = professional.categories.any(
          (category) => filters.categories!.contains(category),
        );
        if (!hasMatchingCategory) return false;
      }

      // Rating filter
      if (filters.minRating != null) {
        if (professional.rating < filters.minRating!) return false;
      }

      return true;
    }).toList();
  }

  /// Get selected professional
  ProfessionalProfile? get selectedProfessional {
    if (selectedProfessionalId == null) return null;
    try {
      return professionals.firstWhere(
        (professional) => professional.id == selectedProfessionalId,
      );
    } catch (e) {
      return null;
    }
  }

  @override
  String get stateType => 'ProfessionalState';

  @override
  List<Object?> get props => [
    professionals,
    isLoading,
    error,
    filters,
    selectedProfessionalId,
  ];

  @override
  String toString() {
    return 'ProfessionalState('
        'professionals: ${professionals.length}, '
        'isLoading: $isLoading, '
        'error: $error, '
        'filters: $filters, '
        'selectedProfessionalId: $selectedProfessionalId'
        ')';
  }
}
