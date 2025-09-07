import '../app_state.dart';
import '../dashboard/dashboard_state.dart';

class DashboardSelectors {
  static DashboardState getDashboardState(AppState state) {
    return state.dashboardState;
  }

  static bool isLoading(AppState state) {
    return state.dashboardState.isLoading;
  }

  static bool isRefreshing(AppState state) {
    return state.dashboardState.isRefreshing;
  }

  static DashboardMetrics? getMetrics(AppState state) {
    return state.dashboardState.metrics;
  }

  static String? getError(AppState state) {
    return state.dashboardState.error;
  }

  static DateTime? getLastUpdated(AppState state) {
    return state.dashboardState.lastUpdated;
  }

  static int getTotalUsers(AppState state) {
    return state.dashboardState.metrics?.totalUsers ?? 0;
  }

  static int getActiveUsers(AppState state) {
    return state.dashboardState.metrics?.activeUsers ?? 0;
  }

  static double getRevenue(AppState state) {
    return state.dashboardState.metrics?.revenue ?? 0.0;
  }

  static int getOrders(AppState state) {
    return state.dashboardState.metrics?.orders ?? 0;
  }

  static double getGrowthRate(AppState state) {
    return state.dashboardState.metrics?.growthRate ?? 0.0;
  }

  static List<ActivityItem> getRecentActivities(AppState state) {
    return state.dashboardState.metrics?.recentActivities ?? [];
  }
}
