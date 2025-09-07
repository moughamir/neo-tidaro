library shared.redux.actions.cleaner_actions;

import '../core/core.dart';
import '../../domain/models/models.dart';
import '../../domain/enums/enums.dart';

/// Cleaner action types
class CleanerActionTypes {
  static const String loadCleaners = 'CLEANERS_LOAD';
  static const String updateCleanerStatus = 'CLEANERS_UPDATE_STATUS';
  static const String createCleaner = 'CLEANERS_CREATE';
  static const String createCleanerSuccess = 'CLEANERS_CREATE_SUCCESS';
  static const String createCleanerFailure = 'CLEANERS_CREATE_FAILURE';
  static const String updateCleanerStatusSuccess =
      'CLEANERS_UPDATE_STATUS_SUCCESS';
  static const String updateCleanerStatusFailure =
      'CLEANERS_UPDATE_STATUS_FAILURE';
  static const String updateCleanerFilters = 'CLEANERS_UPDATE_FILTERS';
  static const String clearCleanerFilters = 'CLEANERS_CLEAR_FILTERS';
  static const String selectCleaner = 'CLEANERS_SELECT';
}

/// Load cleaners action
class LoadCleanersAction extends BaseAction {
  const LoadCleanersAction();

  @override
  List<Object?> get props => [];

  @override
  String get type => CleanerActionTypes.loadCleaners;
}

/// Load cleaners success action
class LoadCleanersSuccessAction extends BaseAction {
  const LoadCleanersSuccessAction({required this.cleaners});

  final List<Cleaner> cleaners;

  @override
  List<Object?> get props => [cleaners];

  @override
  String get type => CleanerActionTypes.loadCleaners;
}

/// Load cleaners failure action
class LoadCleanersFailureAction extends BaseAction {
  const LoadCleanersFailureAction({required this.error});

  final Exception error;

  @override
  List<Object?> get props => [error];

  @override
  String get type => CleanerActionTypes.loadCleaners;
}

/// Update cleaner filters action
class UpdateCleanerFiltersAction extends BaseAction {
  const UpdateCleanerFiltersAction({required this.filters});

  final CleanerFilters filters;

  @override
  List<Object?> get props => [filters];

  @override
  String get type => CleanerActionTypes.updateCleanerFilters;
}

/// Clear cleaner filters action
class ClearCleanerFiltersAction extends BaseAction {
  const ClearCleanerFiltersAction();

  @override
  List<Object?> get props => [];

  @override
  String get type => CleanerActionTypes.clearCleanerFilters;
}

/// Select cleaner action
class SelectCleanerAction extends BaseAction {
  const SelectCleanerAction({required this.cleanerId});

  final String cleanerId;

  @override
  List<Object?> get props => [cleanerId];

  @override
  String get type => CleanerActionTypes.selectCleaner;
}

/// Update cleaner status action
class UpdateCleanerStatusAction extends BaseAction {
  const UpdateCleanerStatusAction({
    required this.cleanerId,
    required this.status,
  });

  final String cleanerId;
  final CleanerStatus status;

  @override
  List<Object?> get props => [cleanerId, status];

  @override
  String get type => CleanerActionTypes.updateCleanerStatus;
}

/// Update cleaner status success action
class UpdateCleanerStatusSuccessAction extends BaseAction {
  const UpdateCleanerStatusSuccessAction({
    required this.cleanerId,
    required this.status,
  });

  final String cleanerId;
  final CleanerStatus status;

  @override
  List<Object?> get props => [cleanerId, status];

  @override
  String get type => CleanerActionTypes.updateCleanerStatus;
}

/// Update cleaner status failure action
class UpdateCleanerStatusFailureAction extends BaseAction {
  const UpdateCleanerStatusFailureAction({required this.error});

  final Exception error;

  @override
  List<Object?> get props => [error];

  @override
  String get type => CleanerActionTypes.updateCleanerStatus;
}

/// Create cleaner action
class CreateCleanerAction extends BaseAction {
  const CreateCleanerAction({required this.cleaner});

  final Cleaner cleaner;

  @override
  List<Object?> get props => [cleaner];

  @override
  String get type => CleanerActionTypes.createCleaner;
}

/// Create cleaner success action
class CreateCleanerSuccessAction extends BaseAction {
  const CreateCleanerSuccessAction({required this.cleaner});

  final Cleaner cleaner;

  @override
  List<Object?> get props => [cleaner];

  @override
  String get type => CleanerActionTypes.createCleaner;
}

/// Create cleaner failure action
class CreateCleanerFailureAction extends BaseAction {
  const CreateCleanerFailureAction({required this.error});

  final Exception error;

  @override
  List<Object?> get props => [error];

  @override
  String get type => CleanerActionTypes.createCleaner;
}
