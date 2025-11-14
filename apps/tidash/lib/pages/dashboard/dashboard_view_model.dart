import 'package:shared/shared.dart';

class DashboardViewModel {
  factory DashboardViewModel.fromStore(Store<AppState> store) {
    return DashboardViewModel(
      isLoading: DashboardSelectors.isLoading(store.state),
      isRefreshing: store.state.dashboardState.isRefreshing,
      dashboardMetrics: DashboardSelectors.getMetrics(store.state),
      error: DashboardSelectors.getError(store.state),
      lastUpdated: DashboardSelectors.getLastRefresh(store.state),
      onRefresh: () => store.dispatch(const LoadDashboardAction()),
    );
  }
  const DashboardViewModel({
    required this.isLoading,
    required this.isRefreshing,
    required this.dashboardMetrics,
    required this.error,
    required this.lastUpdated,
    required this.onRefresh,
  });

  final bool isLoading;
  final bool isRefreshing;
  final DashboardMetrics? dashboardMetrics;
  final String? error;
  final DateTime? lastUpdated;
  final VoidCallback onRefresh;
}
