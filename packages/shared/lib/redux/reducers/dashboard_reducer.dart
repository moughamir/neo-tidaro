import 'package:domain/domain.dart';
import 'package:fpdart/fpdart.dart';

import '../actions/dashboard_actions.dart';
import '../core/core.dart';
import '../states/dashboard_state.dart';

/// Dashboard reducer following Clean Architecture and functional programming principles
class DashboardReducer
    extends BaseAsyncReducer<DashboardState, DashboardMetrics> {
  @override
  DashboardState createLoadingState() {
    return DashboardState.loading();
  }

  @override
  DashboardState createSuccessState(DashboardMetrics data) {
    return DashboardState.success(data);
  }

  @override
  DashboardState createErrorState(Exception error) {
    return DashboardState.error(error);
  }

  @override
  DashboardState reduce(DashboardState state, BaseAction action) {
    return switch (action.type) {
      DashboardActionTypes.loadDashboard => handleAsync(
        state,
        action,
        DashboardActionTypes.loadDashboard,
      ),
      DashboardActionTypes.refreshDashboard => handleAsync(
        state,
        action,
        DashboardActionTypes.refreshDashboard,
      ),
      DashboardActionTypes.updateMetrics => _handleUpdateMetrics(state, action),
      DashboardActionTypes.clearError => _handleClearError(state),
      _ => state,
    };
  }

  /// Handle metrics update
  DashboardState _handleUpdateMetrics(DashboardState state, BaseAction action) {
    if (action is! UpdateMetricsAction) return state;

    return state.copyWith(
      data: Some(action.metrics),
      isLoading: false,
      error: const None(),
    );
  }

  /// Handle clear error
  DashboardState _handleClearError(DashboardState state) {
    return state.copyWith(error: const None());
  }
}

/// Dashboard reducer instance
final dashboardReducer = DashboardReducer();
