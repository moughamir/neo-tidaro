import '../actions/ui_actions.dart';
import '../ui/ui_state.dart';

/// Reducer for UI state
UiState uiReducer(UiState state, dynamic action) {
  if (action is SetLoadingAction) {
    return state.copyWith(isLoading: action.isLoading);
  }

  if (action is IncrementCounterAction) {
    return state.copyWith(counter: state.counter + 1);
  }

  if (action is DecrementCounterAction) {
    return state.copyWith(counter: state.counter - 1);
  }

  if (action is ResetCounterAction) {
    return state.copyWith(counter: 0);
  }

  if (action is SetCounterAction) {
    return state.copyWith(counter: action.value);
  }

  if (action is ShowErrorAction) {
    return state.copyWith(
      error: action.error,
      successMessage: null,
    );
  }

  if (action is ClearErrorAction) {
    return state.copyWith(error: null);
  }

  if (action is ShowSuccessMessageAction) {
    return state.copyWith(
      successMessage: action.message,
      error: null,
    );
  }

  if (action is ClearSuccessMessageAction) {
    return state.copyWith(successMessage: null);
  }

  if (action is ClearAllMessagesAction) {
    return state.copyWith(
      error: null,
      successMessage: null,
    );
  }

  return state;
}
