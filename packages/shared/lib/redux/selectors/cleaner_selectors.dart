library shared.redux.selectors.cleaner_selectors;

import '../app_state.dart';
import '../states/cleaner_state.dart';
import '../../domain/models/models.dart';
import '../../domain/enums/enums.dart';

/// Cleaner selectors for accessing cleaner state
class CleanerSelectors {
  /// Get cleaner state
  static CleanerState getCleanerState(AppState state) => state.cleanerState;

  /// Get all cleaners
  static List<Cleaner> getCleaners(AppState state) =>
      state.cleanerState.cleaners;

  /// Get filtered cleaners
  static List<Cleaner> getFilteredCleaners(AppState state) =>
      state.cleanerState.filteredCleaners;

  /// Get cleaner filters
  static CleanerFilters getFilters(AppState state) =>
      state.cleanerState.filters;

  /// Get selected cleaner
  static Cleaner? getSelectedCleaner(AppState state) =>
      state.cleanerState.selectedCleaner;

  /// Get selected cleaner ID
  static String? getSelectedCleanerId(AppState state) =>
      state.cleanerState.selectedCleanerId;

  /// Get loading state
  static bool isLoading(AppState state) => state.cleanerState.isLoading;

  /// Get error state
  static Exception? getError(AppState state) =>
      state.cleanerState.error.fold(() => null, (error) => error);

  /// Get cleaners by status
  static List<Cleaner> getCleanersByStatus(
    AppState state,
    CleanerStatus status,
  ) {
    return state.cleanerState.cleaners
        .where((cleaner) => cleaner.status == status)
        .toList();
  }

  /// Get available cleaners
  static List<Cleaner> getAvailableCleaners(AppState state) =>
      getCleanersByStatus(state, CleanerStatus.available);

  /// Get cleaners on job
  static List<Cleaner> getCleanersOnJob(AppState state) =>
      getCleanersByStatus(state, CleanerStatus.onJob);

  /// Get offline cleaners
  static List<Cleaner> getOfflineCleaners(AppState state) =>
      getCleanersByStatus(state, CleanerStatus.offline);

  /// Get cleaners on break
  static List<Cleaner> getCleanersOnBreak(AppState state) =>
      getCleanersByStatus(state, CleanerStatus.onBreak);

  /// Get cleaners count by status
  static int getCleanersCountByStatus(AppState state, CleanerStatus status) =>
      getCleanersByStatus(state, status).length;

  /// Get total cleaners count
  static int getTotalCleanersCount(AppState state) =>
      state.cleanerState.cleaners.length;

  /// Get filtered cleaners count
  static int getFilteredCleanersCount(AppState state) =>
      state.cleanerState.filteredCleaners.length;

  /// Get cleaners by service category
  static List<Cleaner> getCleanersByServiceCategory(
    AppState state,
    ServiceCategory category,
  ) {
    return state.cleanerState.cleaners
        .where((cleaner) => cleaner.serviceCategories.contains(category))
        .toList();
  }

  /// Get verified cleaners
  static List<Cleaner> getVerifiedCleaners(AppState state) {
    return state.cleanerState.cleaners
        .where((cleaner) => cleaner.isVerified)
        .toList();
  }

  /// Get top rated cleaners
  static List<Cleaner> getTopRatedCleaners(AppState state, {int limit = 10}) {
    final cleanersWithRating = state.cleanerState.cleaners
        .where((cleaner) => cleaner.rating != null)
        .toList();

    cleanersWithRating.sort((a, b) => b.rating!.compareTo(a.rating!));

    return cleanersWithRating.take(limit).toList();
  }

  /// Check if filters are active
  static bool hasActiveFilters(AppState state) {
    final filters = state.cleanerState.filters;
    return filters.status != null ||
        (filters.serviceCategories?.isNotEmpty ?? false) ||
        filters.minRating != null ||
        filters.isVerified != null;
  }
}
