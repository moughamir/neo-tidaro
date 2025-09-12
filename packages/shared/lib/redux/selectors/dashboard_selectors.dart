import '../app_state.dart';
import '../states/dashboard_state.dart';
import '../../../../domain/lib/models/models.dart';

class DashboardSelectors {
  static DashboardState getDashboardState(AppState state) {
    return state.dashboardState;
  }

  static bool isLoading(AppState state) {
    return state.dashboardState.isLoading;
  }

  static bool isMetricsLoading(AppState state) {
    return state.dashboardState.metricsLoading;
  }

  static bool isActivitiesLoading(AppState state) {
    return state.dashboardState.activitiesLoading;
  }

  static DashboardMetrics? getMetrics(AppState state) {
    return state.dashboardState.data.fold(() => null, (data) => data);
  }

  static String? getError(AppState state) {
    return state.dashboardState.error.fold(
      () => null,
      (error) => error.toString(),
    );
  }

  static DateTime? getLastRefresh(AppState state) {
    return state.dashboardState.lastRefresh.fold(() => null, (date) => date);
  }

  static int getTotalBookings(AppState state) {
    return getMetrics(state)?.totalBookings ?? 0;
  }

  static int getPendingBookings(AppState state) {
    return getMetrics(state)?.pendingBookings ?? 0;
  }

  static int getCompletedBookings(AppState state) {
    return getMetrics(state)?.completedBookings ?? 0;
  }

  static double getTotalRevenue(AppState state) {
    return getMetrics(state)?.totalRevenue ?? 0.0;
  }

  static double getMonthlyRevenue(AppState state) {
    return getMetrics(state)?.monthlyRevenue ?? 0.0;
  }

  static int getActiveCleaners(AppState state) {
    return getMetrics(state)?.activeCleaners ?? 0;
  }

  static int getTotalCustomers(AppState state) {
    return getMetrics(state)?.totalCustomers ?? 0;
  }

  static double getAverageRating(AppState state) {
    return getMetrics(state)?.averageRating ?? 0.0;
  }

  static double getCompletionRate(AppState state) {
    return getMetrics(state)?.completionRate ?? 0.0;
  }

  static List<ActivityItem> getRecentActivities(AppState state) {
    return getMetrics(state)?.recentActivities ?? [];
  }

  static List<ServiceMetric> getTopServices(AppState state) {
    return getMetrics(state)?.topServices ?? [];
  }
}
