import 'package:domain/entities/entities.dart';
import 'package:domain/enums/enums.dart';
import 'package:shared/redux/redux.dart';

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
        title: 'Booking completed',
        description: 'Booking #1234 was successfully processed',
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
      totalBookings: 234,
      pendingBookings: 45,
      completedBookings: 189,
      totalRevenue: 45678.90,
      monthlyRevenue: 12500.00,
      activeProfessionals: 25,
      totalCustomers: 856,
      averageRating: 4.7,
      recentActivities: sampleActivities,
      id: '',
    );

    store.dispatch(
      ActionCreators.success(DashboardActionTypes.loadDashboard, metrics),
    );
  } catch (error) {
    store.dispatch(
      ActionCreators.failure(
        DashboardActionTypes.loadDashboard,
        Exception(error.toString()),
      ),
    );
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

    final currentMetrics = store.state.dashboardState.data;
    if (currentMetrics.isSome()) {
      final metrics = currentMetrics.fold(
        () => throw Exception('No metrics'),
        (data) => data,
      );
      // Simulate updated metrics
      final updatedMetrics = metrics.copyWith(
        totalBookings: metrics.totalBookings + 1,
        totalCustomers: metrics.totalCustomers + 2,
        totalRevenue: metrics.totalRevenue + 150.0,
        monthlyRevenue: metrics.monthlyRevenue + 150.0,
        pendingBookings: metrics.pendingBookings,
        completedBookings: metrics.completedBookings,
        activeProfessionals: metrics.activeProfessionals,
        averageRating: metrics.averageRating,
        completionRate: metrics.completionRate,
        recentActivities: metrics.recentActivities,
      );

      store.dispatch(
        ActionCreators.success(
          DashboardActionTypes.refreshDashboard,
          updatedMetrics,
        ),
      );
    } else {
      // If no metrics exist, load them
      store.dispatch(const LoadDashboardAction());
    }
  } catch (error) {
    store.dispatch(
      ActionCreators.failure(
        DashboardActionTypes.refreshDashboard,
        Exception(error.toString()),
      ),
    );
  }
}

extension on DashboardMetrics {
  get totalBookings => 0;

  get totalCustomers => 0;

  get totalRevenue => 0;

  get monthlyRevenue => 0;

  get pendingBookings => 0;

  get completedBookings => 0;

  get activeProfessionals => 0;

  get averageRating => 0;

  get completionRate => 0;

  get recentActivities => 0;
  DashboardMetrics copyWith({
    required totalBookings,
    required totalCustomers,
    required totalRevenue,
    required monthlyRevenue,
    required pendingBookings,
    required completedBookings,
    required activeProfessionals,
    required averageRating,
    required completionRate,
    required recentActivities,
  }) {
    return DashboardMetrics(
      activeProfessionals: 0,
      id: '',
      totalBookings: 0,
      pendingBookings: 0,
      completedBookings: 0,
      totalRevenue: 0,
      monthlyRevenue: 0,
      totalCustomers: 0,
      averageRating: 0,
      recentActivities: [],
    );
  }
}
