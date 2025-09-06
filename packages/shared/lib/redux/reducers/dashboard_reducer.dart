import '../actions/dashboard_actions.dart';
import '../dashboard/dashboard_state.dart';

DashboardState dashboardReducer(DashboardState state, dynamic action) {
  switch (action.runtimeType) {
    case LoadDashboardAction:
      return state.copyWith(isLoading: true, error: null);

    case LoadDashboardSuccessAction:
      final successAction = action as LoadDashboardSuccessAction;
      return state.copyWith(
        isLoading: false,
        metrics: successAction.metrics,
        lastUpdated: DateTime.now(),
        error: null,
      );

    case LoadDashboardFailureAction:
      final failureAction = action as LoadDashboardFailureAction;
      return state.copyWith(
        isLoading: false,
        error: failureAction.error,
      );

    case RefreshDashboardAction:
      return state.copyWith(isRefreshing: true, error: null);

    case RefreshDashboardSuccessAction:
      final successAction = action as RefreshDashboardSuccessAction;
      return state.copyWith(
        isRefreshing: false,
        metrics: successAction.metrics,
        lastUpdated: DateTime.now(),
        error: null,
      );

    case RefreshDashboardFailureAction:
      final failureAction = action as RefreshDashboardFailureAction;
      return state.copyWith(
        isRefreshing: false,
        error: failureAction.error,
      );

    case UpdateDashboardMetricsAction:
      final updateAction = action as UpdateDashboardMetricsAction;
      return state.copyWith(metrics: updateAction.metrics);

    case ClearDashboardErrorAction:
      return state.copyWith(error: null);

    default:
      return state;
  }
}
