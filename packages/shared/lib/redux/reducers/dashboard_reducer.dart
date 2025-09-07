import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import '../actions/dashboard_actions.dart';
import '../states/dashboard_state.dart';
import '../../domain/models/models.dart';

/// Dashboard reducer following Clean Architecture and functional programming principles
class DashboardReducer extends BaseAsyncReducer<DashboardState, DashboardMetrics> {
  @override
  DashboardState reduce(DashboardState state, BaseAction action) {
    return switch (action.type) {
      DashboardActionTypes.loadDashboard => handleAsync(state, action, DashboardActionTypes.loadDashboard),
      DashboardActionTypes.refreshDashboard => handleAsync(state, action, DashboardActionTypes.refreshDashboard),
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
