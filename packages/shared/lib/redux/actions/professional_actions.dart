library;

import 'package:domain/domain.dart';
import 'package:shared/redux/redux.dart' show BaseAction;

/// Professional action types
class ProfessionalActionTypes {
  static const String loadProfessionals = 'PROFESSIONALS_LOAD';
  static const String updateProfessionalStatus = 'PROFESSIONALS_UPDATE_STATUS';
  static const String createProfessional = 'PROFESSIONALS_CREATE';
  static const String createProfessionalSuccess =
      'PROFESSIONALS_CREATE_SUCCESS';
  static const String createProfessionalFailure =
      'PROFESSIONALS_CREATE_FAILURE';
  static const String updateProfessionalStatusSuccess =
      'PROFESSIONALS_UPDATE_STATUS_SUCCESS';
  static const String updateProfessionalStatusFailure =
      'PROFESSIONALS_UPDATE_STATUS_FAILURE';
  static const String updateProfessionalFilters =
      'PROFESSIONALS_UPDATE_FILTERS';
  static const String clearProfessionalFilters = 'PROFESSIONALS_CLEAR_FILTERS';
  static const String selectProfessional = 'PROFESSIONALS_SELECT';
}

/// Load professionals action
class LoadProfessionalsAction extends BaseAction {
  const LoadProfessionalsAction();

  @override
  List<Object?> get props => [];

  @override
  String get type => ProfessionalActionTypes.loadProfessionals;
}

/// Load professionals success action
class LoadProfessionalsSuccessAction extends BaseAction {
  const LoadProfessionalsSuccessAction({required this.professionals});

  final List<ProfessionalProfile> professionals;

  @override
  List<Object?> get props => [professionals];

  @override
  String get type => ProfessionalActionTypes.loadProfessionals;
}

/// Load professionals failure action
class LoadProfessionalsFailureAction extends BaseAction {
  const LoadProfessionalsFailureAction({required this.error});

  final Exception error;

  @override
  List<Object?> get props => [error];

  @override
  String get type => ProfessionalActionTypes.loadProfessionals;
}

/// Update professional filters action
class UpdateProfessionalsFiltersAction extends BaseAction {
  const UpdateProfessionalsFiltersAction({required this.filters});

  final ProfessionalSearchDto? filters;

  @override
  List<Object?> get props => [filters];

  @override
  String get type => ProfessionalActionTypes.updateProfessionalFilters;
}

/// Clear professional filters action
class ClearProfessionalsFiltersAction extends BaseAction {
  const ClearProfessionalsFiltersAction();

  @override
  List<Object?> get props => [];

  @override
  String get type => ProfessionalActionTypes.clearProfessionalFilters;
}

/// Select professional action
class SelectProfessionalAction extends BaseAction {
  const SelectProfessionalAction({required this.professionalId});

  final String professionalId;

  @override
  List<Object?> get props => [professionalId];

  @override
  String get type => ProfessionalActionTypes.selectProfessional;
}

/// Update professional status action
class UpdateProfessionalStatusAction extends BaseAction {
  const UpdateProfessionalStatusAction({
    required this.professionalId,
    required this.status,
  });

  final String professionalId;
  final ProfessionalKycStatus status;

  @override
  List<Object?> get props => [professionalId, status];

  @override
  String get type => ProfessionalActionTypes.updateProfessionalStatus;
}

/// Update professional status success action
class UpdateProfessionalStatusSuccessAction extends BaseAction {
  const UpdateProfessionalStatusSuccessAction({
    required this.professionalId,
    required this.status,
  });

  final String professionalId;
  final ProfessionalActivityStatus status;

  @override
  List<Object?> get props => [professionalId, status];

  @override
  String get type => ProfessionalActionTypes.updateProfessionalStatus;
}

/// Update professional status failure action
class UpdateProfessionalStatusFailureAction extends BaseAction {
  const UpdateProfessionalStatusFailureAction({required this.error});

  final Exception error;

  @override
  List<Object?> get props => [error];

  @override
  String get type => ProfessionalActionTypes.updateProfessionalStatus;
}

/// Create professional action
class CreateProfessionalAction extends BaseAction {
  const CreateProfessionalAction({required this.professional});

  final ProfessionalProfile professional;

  @override
  List<Object?> get props => [professional];

  @override
  String get type => ProfessionalActionTypes.createProfessional;
}

/// Create professional success action
class CreateProfessionalSuccessAction extends BaseAction {
  const CreateProfessionalSuccessAction({required this.professional});

  final ProfessionalProfile professional;

  @override
  List<Object?> get props => [professional];

  @override
  String get type => ProfessionalActionTypes.createProfessional;
}

/// Create professional failure action
class CreateProfessionalFailureAction extends BaseAction {
  const CreateProfessionalFailureAction({required this.error});

  final Exception error;

  @override
  List<Object?> get props => [error];

  @override
  String get type => ProfessionalActionTypes.createProfessional;
}
