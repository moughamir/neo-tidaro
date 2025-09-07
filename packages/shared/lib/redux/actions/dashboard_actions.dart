import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import '../../domain/models/models.dart';

/// Dashboard action types
class DashboardActionTypes {
  static const String loadDashboard = 'DASHBOARD_LOAD';
  static const String loadDashboardSuccess = 'DASHBOARD_LOAD_SUCCESS';
  static const String loadDashboardFailure = 'DASHBOARD_LOAD_FAILURE';
  static const String refreshDashboard = 'DASHBOARD_REFRESH';
  static const String refreshDashboardSuccess = 'DASHBOARD_REFRESH_SUCCESS';
  static const String refreshDashboardFailure = 'DASHBOARD_REFRESH_FAILURE';
  static const String updateMetrics = 'DASHBOARD_UPDATE_METRICS';
  static const String clearError = 'DASHBOARD_CLEAR_ERROR';
}

/// Load dashboard action
class LoadDashboardAction extends BaseAsyncAction<DashboardMetrics> {
  const LoadDashboardAction({this.forceRefresh = false});

  final bool forceRefresh;

  @override
  String get type => DashboardActionTypes.loadDashboard;

  @override
  bool get payload => forceRefresh;

  @override
  Future<Either<Exception, DashboardMetrics>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [forceRefresh];
}

/// Refresh dashboard action
class RefreshDashboardAction extends BaseAsyncAction<DashboardMetrics> {
  const RefreshDashboardAction();

  @override
  String get type => DashboardActionTypes.refreshDashboard;

  @override
  Future<Either<Exception, DashboardMetrics>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [];
}

/// Update metrics action
class UpdateMetricsAction extends BaseAsyncAction<DashboardMetrics> {
  const UpdateMetricsAction(this.metrics);

  final DashboardMetrics metrics;

  @override
  String get type => DashboardActionTypes.updateMetrics;

  @override
  DashboardMetrics get payload => metrics;

  @override
  Future<Either<Exception, DashboardMetrics>> execute() async {
    return Right(metrics);
  }

  @override
  List<Object?> get props => [metrics];
}

/// Clear error action
class ClearDashboardErrorAction extends BaseAction {
  const ClearDashboardErrorAction();

  @override
  String get type => DashboardActionTypes.clearError;

  @override
  List<Object?> get props => [];
}
