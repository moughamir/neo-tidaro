library shared.redux.reducers.cleaner_reducer;

import 'package:redux/redux.dart';
import '../actions/cleaner_actions.dart';
import '../states/cleaner_state.dart';
import '../../domain/models/models.dart';

/// Cleaner reducer
CleanerState cleanerReducer(CleanerState state, dynamic action) {
  return combineReducers<CleanerState>([
    TypedReducer<CleanerState, LoadCleanersAction>(_loadCleaners),
    TypedReducer<CleanerState, LoadCleanersSuccessAction>(_loadCleanersSuccess),
    TypedReducer<CleanerState, LoadCleanersFailureAction>(_loadCleanersFailure),
    TypedReducer<CleanerState, UpdateCleanerFiltersAction>(_updateFilters),
    TypedReducer<CleanerState, ClearCleanerFiltersAction>(_clearFilters),
    TypedReducer<CleanerState, SelectCleanerAction>(_selectCleaner),
    TypedReducer<CleanerState, UpdateCleanerStatusAction>(_updateCleanerStatus),
    TypedReducer<CleanerState, UpdateCleanerStatusSuccessAction>(_updateCleanerStatusSuccess),
    TypedReducer<CleanerState, UpdateCleanerStatusFailureAction>(_updateCleanerStatusFailure),
    TypedReducer<CleanerState, CreateCleanerAction>(_createCleaner),
    TypedReducer<CleanerState, CreateCleanerSuccessAction>(_createCleanerSuccess),
    TypedReducer<CleanerState, CreateCleanerFailureAction>(_createCleanerFailure),
  ])(state, action);
}

CleanerState _loadCleaners(CleanerState state, LoadCleanersAction action) {
  return state.copyWith(isLoading: true);
}

CleanerState _loadCleanersSuccess(CleanerState state, LoadCleanersSuccessAction action) {
  return CleanerState.success(
    cleaners: action.cleaners,
    filters: state.filters,
    selectedCleanerId: state.selectedCleanerId,
  );
}

CleanerState _loadCleanersFailure(CleanerState state, LoadCleanersFailureAction action) {
  return CleanerState.error(
    error: action.error,
    cleaners: state.cleaners,
    filters: state.filters,
    selectedCleanerId: state.selectedCleanerId,
  );
}

CleanerState _updateFilters(CleanerState state, UpdateCleanerFiltersAction action) {
  return state.copyWith(filters: action.filters);
}

CleanerState _clearFilters(CleanerState state, ClearCleanerFiltersAction action) {
  return state.copyWith(filters: const CleanerFilters());
}

CleanerState _selectCleaner(CleanerState state, SelectCleanerAction action) {
  return state.copyWith(selectedCleanerId: action.cleanerId);
}

CleanerState _updateCleanerStatus(CleanerState state, UpdateCleanerStatusAction action) {
  return state.copyWith(isLoading: true);
}

CleanerState _updateCleanerStatusSuccess(CleanerState state, UpdateCleanerStatusSuccessAction action) {
  final updatedCleaners = state.cleaners.map((cleaner) {
    if (cleaner.id == action.cleanerId) {
      return cleaner.copyWith(status: action.status);
    }
    return cleaner;
  }).toList();

  return state.copyWith(
    cleaners: updatedCleaners,
    isLoading: false,
  );
}

CleanerState _updateCleanerStatusFailure(CleanerState state, UpdateCleanerStatusFailureAction action) {
  return CleanerState.error(
    error: action.error,
    cleaners: state.cleaners,
    filters: state.filters,
    selectedCleanerId: state.selectedCleanerId,
  );
}

CleanerState _createCleaner(CleanerState state, CreateCleanerAction action) {
  return state.copyWith(isLoading: true);
}

CleanerState _createCleanerSuccess(CleanerState state, CreateCleanerSuccessAction action) {
  final updatedCleaners = [...state.cleaners, action.cleaner];
  return state.copyWith(
    cleaners: updatedCleaners,
    isLoading: false,
  );
}

CleanerState _createCleanerFailure(CleanerState state, CreateCleanerFailureAction action) {
  return CleanerState.error(
    error: action.error,
    cleaners: state.cleaners,
    filters: state.filters,
    selectedCleanerId: state.selectedCleanerId,
  );
}
