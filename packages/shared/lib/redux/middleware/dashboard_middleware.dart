import 'package:domain/entities/entities.dart';
import 'package:domain/enums/enums.dart';
import 'package:shared/redux/redux.dart';
import 'package:core/network/supabase_service.dart';

List<Middleware<AppState>> createDashboardMiddleware(SupabaseService supabase) {
  return [
    TypedMiddleware<AppState, LoadDashboardAction>(_loadDashboard(supabase)),
    TypedMiddleware<AppState, RefreshDashboardAction>(_refreshDashboard(supabase)),
  ];
}

void Function(Store<AppState>, LoadDashboardAction, NextDispatcher) _loadDashboard(
    SupabaseService supabase) {
  return (
    Store<AppState> store,
    LoadDashboardAction action,
    NextDispatcher next,
  ) {
    next(action);

    // Fetch metrics and activities in parallel without async/await
    final metricsFuture = supabase.getTableData(
      table: 'v_admin_metrics_daily',
      limit: 1,
    );
    final activityFuture = supabase.getTableData(
      table: 'v_admin_activity_feed',
      limit: 50,
    );

    metricsFuture.then((metricsResult) {
      activityFuture.then((activityResult) {
        final metrics = metricsResult.getOrElse((_) => <Map<String, dynamic>>[]);
        final m = metrics.isNotEmpty ? metrics.first : <String, dynamic>{};

        final activitiesRows = activityResult.getOrElse((_) => <Map<String, dynamic>>[]);

        final activities = activitiesRows.map((row) {
          final entity = (row['entity_type'] as String?) ?? 'system';
          final actionStr = (row['action'] as String?) ?? 'activity';
          final fullName = (row['full_name'] as String?) ?? '';
          final ts = row['timestamp']?.toString();
          final when = ts != null ? DateTime.tryParse(ts) ?? DateTime.now() : DateTime.now();
          final ActivityType type = switch (entity.toLowerCase()) {
            'booking' => ActivityType.order,
            'user' => ActivityType.user,
            'revenue' => ActivityType.revenue,
            _ => ActivityType.system,
          };
          return ActivityItem(
            id: (row['id']?.toString()) ?? '',
            title: actionStr,
            description: fullName.isNotEmpty ? '$fullName · $entity' : entity,
            timestamp: when,
            type: type,
          );
        }).toList();

        final totalProviders = (m['total_providers'] as num?)?.toInt() ?? 0;
        final totalClients = (m['total_clients'] as num?)?.toInt() ?? 0;
        final openBookings = (m['open_bookings'] as num?)?.toInt() ?? 0;
        final completedTotal = (m['completed_total'] as num?)?.toInt() ?? 0;
        final cancelledTotal = (m['cancelled_total'] as num?)?.toInt() ?? 0;
        final avgRating = (m['avg_rating'] as num?)?.toDouble() ?? 0.0;

        final DashboardMetrics metricsEntity = DashboardMetrics(
          id: 'admin_metrics_daily',
          totalBookings: openBookings + completedTotal + cancelledTotal,
          pendingBookings: openBookings,
          completedBookings: completedTotal,
          totalRevenue: 0.0,
          monthlyRevenue: 0.0,
          activeProfessionals: totalProviders,
          totalCustomers: totalClients,
          averageRating: avgRating,
          recentActivities: activities,
        );

        store.dispatch(
          ActionCreators.success(DashboardActionTypes.loadDashboard, metricsEntity),
        );
      }).catchError((error) {
        store.dispatch(
          ActionCreators.failure(
            DashboardActionTypes.loadDashboard,
            Exception(error.toString()),
          ),
        );
      });
    }).catchError((error) {
      store.dispatch(
        ActionCreators.failure(
          DashboardActionTypes.loadDashboard,
          Exception(error.toString()),
        ),
      );
    });
  };
}

void Function(Store<AppState>, RefreshDashboardAction, NextDispatcher)
    _refreshDashboard(SupabaseService supabase) {
  return (
    Store<AppState> store,
    RefreshDashboardAction action,
    NextDispatcher next,
  ) {
    next(action);
    // For now, simply reload metrics and activity
    store.dispatch(const LoadDashboardAction());
  };
}
