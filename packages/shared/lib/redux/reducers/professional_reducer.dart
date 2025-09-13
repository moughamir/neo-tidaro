library shared.redux.reducers.professional_reducer;

import 'package:redux/redux.dart';

import '../actions/professional_actions.dart';
import '../states/professional_state.dart';

/// Professional reducer
ProfessionalState professionalReducer(ProfessionalState state, dynamic action) {
  return combineReducers<ProfessionalState>([
    TypedReducer<ProfessionalState, LoadProfessionalsAction>(
      _loadProfessionals,
    ),
    TypedReducer<ProfessionalState, LoadProfessionalsSuccessAction>(
      _loadProfessionalsSuccess,
    ),
    TypedReducer<ProfessionalState, LoadProfessionalsFailureAction>(
      _loadProfessionalsFailure,
    ),
    TypedReducer<ProfessionalState, UpdateProfessionalsFiltersAction>(
      _updateFilters,
    ),
    TypedReducer<ProfessionalState, ClearProfessionalsFiltersAction>(
      _clearFilters,
    ),
    TypedReducer<ProfessionalState, SelectProfessionalAction>(
      _selectProfessional,
    ),
    TypedReducer<ProfessionalState, CreateProfessionalAction>(
      _createProfessional,
    ),
    TypedReducer<ProfessionalState, CreateProfessionalSuccessAction>(
      _createProfessionalSuccess,
    ),
    TypedReducer<ProfessionalState, CreateProfessionalFailureAction>(
      _createProfessionalFailure,
    ),
  ])(state, action);
}

ProfessionalState _loadProfessionals(
  ProfessionalState state,
  LoadProfessionalsAction action,
) {
  return state.copyWith(isLoading: true);
}

ProfessionalState _loadProfessionalsSuccess(
  ProfessionalState state,
  LoadProfessionalsSuccessAction action,
) {
  return ProfessionalState.success(
    professionals: action.professionals,
    filters: state.filters,
    selectedProfessionalId: state.selectedProfessionalId,
  );
}

ProfessionalState _loadProfessionalsFailure(
  ProfessionalState state,
  LoadProfessionalsFailureAction action,
) {
  return ProfessionalState.error(
    error: action.error,
    professionals: state.professionals,
    filters: state.filters,
    selectedProfessionalId: state.selectedProfessionalId,
  );
}

ProfessionalState _updateFilters(
  ProfessionalState state,
  UpdateProfessionalsFiltersAction action,
) {
  return state.copyWith(filters: action.filters);
}

ProfessionalState _clearFilters(
  ProfessionalState state,
  ClearProfessionalsFiltersAction action,
) {
  return state.copyWith();
}

ProfessionalState _selectProfessional(
  ProfessionalState state,
  SelectProfessionalAction action,
) {
  return state.copyWith(selectedProfessionalId: action.professionalId);
}

ProfessionalState _createProfessional(
  ProfessionalState state,
  CreateProfessionalAction action,
) {
  return state.copyWith(isLoading: true);
}

ProfessionalState _createProfessionalSuccess(
  ProfessionalState state,
  CreateProfessionalSuccessAction action,
) {
  final updatedProfessionals = [...state.professionals, action.professional];
  return state.copyWith(professionals: updatedProfessionals, isLoading: false);
}

ProfessionalState _createProfessionalFailure(
  ProfessionalState state,
  CreateProfessionalFailureAction action,
) {
  return ProfessionalState.error(
    error: action.error,
    professionals: state.professionals,
    filters: state.filters,
    selectedProfessionalId: state.selectedProfessionalId,
  );
}
