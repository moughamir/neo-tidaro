// Dashboard Actions
import 'package:domain/domain.dart';

class LoadDashboardAction {
  const LoadDashboardAction();
}

class LoadDashboardSuccessAction {
  const LoadDashboardSuccessAction(this.metrics);
  final DashboardMetrics metrics;
}

class LoadDashboardFailureAction {
  const LoadDashboardFailureAction(this.error);
  final String error;
}

class RefreshDashboardAction {
  const RefreshDashboardAction();
}

class RefreshDashboardSuccessAction {
  const RefreshDashboardSuccessAction(this.metrics);
  final DashboardMetrics metrics;
}

class RefreshDashboardFailureAction {
  const RefreshDashboardFailureAction(this.error);
  final String error;
}

class UpdateDashboardMetricsAction {
  const UpdateDashboardMetricsAction(this.metrics);
  final DashboardMetrics metrics;
}

class ClearDashboardErrorAction {
  const ClearDashboardErrorAction();
}
