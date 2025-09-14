import 'package:domain/domain.dart';
import 'package:fpdart/fpdart.dart';
import 'package:shared/redux/core/core.dart';

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

class ClearDashboardAuthErrorAction {
  const ClearDashboardAuthErrorAction();
}

/// Clear error action
class ClearDashboardErrorAction extends BaseAction {
  const ClearDashboardErrorAction();

  @override
  List<Object?> get props => [];

  @override
  String get type => DashboardActionTypes.clearError;
}

class DashboardAuthFailureAction {
  final String error;
  const DashboardAuthFailureAction(this.error);
}

class DashboardAuthLoadingAction {
  final bool isLoading;
  const DashboardAuthLoadingAction(this.isLoading);
}

class DashboardAuthSuccessAction {
  final Map<String, dynamic> user;

  final String? accessToken;
  const DashboardAuthSuccessAction({required this.user, this.accessToken});
}

class DashboardForgotPasswordAction {
  final String email;

  const DashboardForgotPasswordAction({required this.email});
}

// Dashboard-specific auth actions

class DashboardLoginAction {
  final String email;

  final String password;
  const DashboardLoginAction({required this.email, required this.password});
}

class DashboardLoginWithProviderAction {
  final String provider; // 'github', 'google', 'apple'

  const DashboardLoginWithProviderAction({required this.provider});
}

class DashboardLogoutAction {
  const DashboardLogoutAction();
}

class DashboardResetPasswordAction {
  const DashboardResetPasswordAction({
    required this.token,
    required this.newPassword,
  });
  final String token;
  final String newPassword;
}

class DashboardSignUpAction {
  final String email;

  final String password;
  final String? name;
  const DashboardSignUpAction({
    required this.email,
    required this.password,
    this.name,
  });
}

/// Load dashboard action
class LoadDashboardAction extends BaseAsyncAction<DashboardMetrics> {
  final bool forceRefresh;

  const LoadDashboardAction({this.forceRefresh = false});

  @override
  bool get payload => forceRefresh;

  @override
  List<Object?> get props => [forceRefresh];

  @override
  String get type => DashboardActionTypes.loadDashboard;

  @override
  Future<Either<Exception, DashboardMetrics>> execute() async {
    return Left(Exception('Execute should be handled by middleware'));
  }
}

class LoadDashboardFailureAction {
  final String error;
  const LoadDashboardFailureAction(this.error);
}

class LoadDashboardSuccessAction {
  final DashboardMetrics metrics;
  const LoadDashboardSuccessAction(this.metrics);
}

/// Refresh dashboard action
class RefreshDashboardAction extends BaseAsyncAction<DashboardMetrics> {
  const RefreshDashboardAction();

  @override
  List<Object?> get props => [];

  @override
  String get type => DashboardActionTypes.refreshDashboard;

  @override
  Future<Either<Exception, DashboardMetrics>> execute() async {
    return Left(Exception('Execute should be handled by middleware'));
  }
}

class RefreshDashboardFailureAction {
  final String error;
  const RefreshDashboardFailureAction(this.error);
}

class RefreshDashboardSuccessAction {
  final DashboardMetrics metrics;
  const RefreshDashboardSuccessAction(this.metrics);
}

class UpdateDashboardMetricsAction {
  final DashboardMetrics metrics;
  const UpdateDashboardMetricsAction(this.metrics);
}

/// Update metrics action
class UpdateMetricsAction extends BaseAsyncAction<DashboardMetrics> {
  final DashboardMetrics metrics;

  const UpdateMetricsAction(this.metrics);

  @override
  DashboardMetrics get payload => metrics;

  @override
  List<Object?> get props => [metrics];

  @override
  String get type => DashboardActionTypes.updateMetrics;

  @override
  Future<Either<Exception, DashboardMetrics>> execute() async {
    return Right(metrics);
  }
}
