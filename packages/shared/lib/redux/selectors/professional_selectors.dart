library shared.redux.selectors.professional_selectors;

import 'package:domain/domain.dart' hide AppState, ProfessionalState;

import '../states/app_state.dart';
import '../states/professional_state.dart';

/// Professional selectors for accessing professional state
class ProfessionalSelectors {
  /// Get professional state
  static ProfessionalState getProfessionalState(AppState state) =>
      state.professionalState;

  /// Get all professionals
  static List<ProfessionalProfile> getProfessionals(AppState state) =>
      state.professionalState.professionals;

  /// Get filtered professionals
  static List<ProfessionalProfile> getFilteredProfessionals(AppState state) =>
      state.professionalState.filteredProfessionals;

  /// Get professional filters
  static ProfessionalSearchDto getFilters(AppState state) =>
      state.professionalState.filters;

  /// Get selected professional
  static ProfessionalProfile? getSelectedProfessional(AppState state) =>
      state.professionalState.selectedProfessional;

  /// Get selected professional ID
  static String? getSelectedProfessionalId(AppState state) =>
      state.professionalState.selectedProfessionalId;

  /// Get loading state
  static bool isLoading(AppState state) => state.professionalState.isLoading;

  /// Get error state
  static Exception? getError(AppState state) =>
      state.professionalState.error.fold(() => null, (error) => error);

  /// Get total professionals count
  static int getTotalProfessionalsCount(AppState state) =>
      state.professionalState.professionals.length;

  /// Get filtered professionals count
  static int getFilteredProfessionalsCount(AppState state) =>
      state.professionalState.filteredProfessionals.length;

  /// Get professionals by service category
  static List<ProfessionalProfile> getProfessionalsByServiceCategory(
    AppState state,
    PreBookingServiceCategory category,
  ) {
    return state.professionalState.professionals
        .where((professional) => professional.categories.contains(category))
        .toList();
  }

  /// Get verified professionals
  static List<ProfessionalProfile> getVerifiedProfessionals(AppState state) {
    return state.professionalState.professionals
        .where((professional) => professional.isVerified)
        .toList();
  }

  /// Get top rated professionals
  static List<ProfessionalProfile> getTopRatedProfessionals(
    AppState state, {
    int limit = 10,
  }) {
    final professionalsWithRating = state.professionalState.professionals
        // ignore: unnecessary_null_comparison
        .where((professional) => professional.rating != null)
        .toList();

    professionalsWithRating.sort((a, b) => b.rating.compareTo(a.rating));

    return professionalsWithRating.take(limit).toList();
  }

  /// Check if filters are active
  static bool hasActiveFilters(AppState state) {
    final filters = state.professionalState.filters;
    return (filters.categories?.isNotEmpty ?? false) ||
        filters.minRating != null;
  }
}
