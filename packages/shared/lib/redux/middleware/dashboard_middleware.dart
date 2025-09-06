import 'package:redux/redux.dart';
import '../app_state.dart';
import '../actions/dashboard_actions.dart';
import '../dashboard/dashboard_state.dart';

List<Middleware<AppState>> createDashboardMiddleware() {
  return [
    TypedMiddleware<AppState, LoadDashboardAction>(_loadDashboard),
    TypedMiddleware<AppState, RefreshDashboardAction>(_refreshDashboard),
  ];
}

void _loadDashboard(
  Store<AppState> store,
  LoadDashboardAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // Simulate API call - replace with actual Supabase calls
    await Future.delayed(const Duration(seconds: 1));

    final sampleActivities = [
      ActivityItem(
        id: '1',
        title: 'New user registered',
        description: 'John Doe joined the platform',
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        type: ActivityType.user,
      ),
      ActivityItem(
        id: '2',
        title: 'Order completed',
        description: 'Order #1234 was successfully processed',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        type: ActivityType.order,
      ),
      ActivityItem(
        id: '3',
        title: 'System update',
        description: 'Database backup completed successfully',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        type: ActivityType.system,
      ),
      ActivityItem(
        id: '4',
        title: 'Revenue milestone',
        description: 'Monthly revenue target achieved',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: ActivityType.revenue,
      ),
    ];

    final metrics = DashboardMetrics(
      totalUsers: 1234,
      activeUsers: 856,
      revenue: 45678.90,
      orders: 234,
      growthRate: 12.5,
      recentActivities: sampleActivities,
    );

    store.dispatch(LoadDashboardSuccessAction(metrics));
  } catch (error) {
    store.dispatch(LoadDashboardFailureAction(error.toString()));
  }
}

void _refreshDashboard(
  Store<AppState> store,
  RefreshDashboardAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    await Future.delayed(const Duration(milliseconds: 800));

    final currentMetrics = store.state.dashboardState.metrics;
    if (currentMetrics != null) {
      // Simulate updated metrics
      final updatedMetrics = currentMetrics.copyWith(
        totalUsers: currentMetrics.totalUsers + 5,
        activeUsers: currentMetrics.activeUsers + 2,
        revenue: currentMetrics.revenue + 150.0,
        orders: currentMetrics.orders + 1,
      );

      store.dispatch(RefreshDashboardSuccessAction(updatedMetrics));
    } else {
      // If no metrics exist, load them
      store.dispatch(const LoadDashboardAction());
    }
  } catch (error) {
    store.dispatch(RefreshDashboardFailureAction(error.toString()));
  }
}
