library;

import 'package:domain/domain.dart';
import 'package:redux/redux.dart';

import 'package:shared/redux/actions/professional_actions.dart';
import 'package:shared/redux/core/core.dart';
import 'package:shared/redux/states/app_state.dart';

List<Middleware<AppState>> createProfessionalMiddleware() {
  return [
    TypedMiddleware<AppState, LoadProfessionalsAction>(_loadProfessionals).call,
    TypedMiddleware<AppState, CreateProfessionalAction>(_createProfessional).call,
    TypedMiddleware<AppState, UpdateProfessionalStatusAction>(_updateProfessionalStatus).call,
  ];
}

void _loadProfessionals(
  Store<AppState> store,
  LoadProfessionalsAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // TODO: Replace with actual repository calls when ready
    // For now, dispatch success with empty list to prevent errors
    store.dispatch(
      ActionCreators.success(
        ProfessionalActionTypes.loadProfessionals,
        <ProfessionalProfile>[],
      ),
    );
  } catch (e) {
    store.dispatch(
      ActionCreators.failure(
        ProfessionalActionTypes.loadProfessionals,
        Exception('Failed to load professionals: $e'),
      ),
    );
  }
}

void _createProfessional(
  Store<AppState> store,
  CreateProfessionalAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // TODO: Replace with actual repository calls when ready
    // For now, dispatch success with the provided professional
    store.dispatch(
      ActionCreators.success(
        ProfessionalActionTypes.createProfessional,
        action.professional,
      ),
    );
  } catch (e) {
    store.dispatch(
      ActionCreators.failure(
        ProfessionalActionTypes.createProfessional,
        Exception('Failed to create professional: $e'),
      ),
    );
  }
}

void _updateProfessionalStatus(
  Store<AppState> store,
  UpdateProfessionalStatusAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // TODO: Replace with actual repository calls when ready
    // For now, dispatch success with the updated status
    store.dispatch(
      ActionCreators.success(
        ProfessionalActionTypes.updateProfessionalStatus,
        action.status,
      ),
    );
  } catch (e) {
    store.dispatch(
      ActionCreators.failure(
        ProfessionalActionTypes.updateProfessionalStatus,
        Exception('Failed to update professional status: $e'),
      ),
    );
  }
}
