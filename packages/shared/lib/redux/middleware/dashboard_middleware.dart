import 'package:core/network/supabase_service.dart';
import 'package:domain/entities/entities.dart';
import 'package:domain/enums/enums.dart';
import 'package:shared/redux/redux.dart';

List<Middleware<AppState>> createDashboardMiddleware(
  SupabaseServiceInterface supabase,
) {
  return [
    TypedMiddleware<AppState, LoadDashboardAction>(
      _loadDashboard(supabase),
    ).call,
    TypedMiddleware<AppState, RefreshDashboardAction>(
      _refreshDashboard(supabase),
    ).call,
  ];
}

void Function(Store<AppState>, LoadDashboardAction, NextDispatcher)
_loadDashboard(SupabaseServiceInterface supabase) {
  return (
    Store<AppState> store,
    LoadDashboardAction action,
    NextDispatcher next,
  ) {
    next(action);

    // Fetch all views in parallel
    Future.wait([
          supabase.getTableData(table: 'v_admin_metrics_daily', limit: 1),
          supabase.getTableData(table: 'v_admin_activity_feed', limit: 50),
          supabase.getTableData(table: 'v_admin_revenue_summary', limit: 1),
          supabase.getTableData(table: 'v_admin_booking_stats', limit: 1),
          supabase.getTableData(table: 'v_admin_revenue_rolling', limit: 1),
        ])
        .then((results) {
          final metricsResult = results[0] as dynamic;
          final activityResult = results[1] as dynamic;
          final revenueResult = results[2] as dynamic;
          final statsResult = results[3] as dynamic;
          final rollingResult = results[4] as dynamic;

          final metrics = metricsResult.getOrElse(
            (_) => <Map<String, dynamic>>[],
          );
          final m = metrics.isNotEmpty ? metrics.first : <String, dynamic>{};

          final activitiesRows = activityResult.getOrElse(
            (_) => <Map<String, dynamic>>[],
          );
          final activities = activitiesRows.map((row) {
            final entity = (row['entity_type'] as String?) ?? 'system';
            final actionStr = (row['action'] as String?) ?? 'activity';
            final fullName = (row['full_name'] as String?) ?? '';
            final ts = row['timestamp']?.toString();
            final when = ts != null
                ? DateTime.tryParse(ts) ?? DateTime.now()
                : DateTime.now();
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

          final revenueRows = revenueResult.getOrElse(
            (_) => <Map<String, dynamic>>[],
          );
          final r = revenueRows.isNotEmpty
              ? revenueRows.first
              : <String, dynamic>{};
          final totalRevenue = (r['total_revenue'] as num?)?.toDouble() ?? 0.0;
          final monthlyRevenue =
              (r['monthly_revenue'] as num?)?.toDouble() ?? 0.0;

          final statsRows = statsResult.getOrElse(
            (_) => <Map<String, dynamic>>[],
          );
          final s = statsRows.isNotEmpty
              ? statsRows.first
              : <String, dynamic>{};
          final completionRate =
              (s['completion_rate'] as num?)?.toDouble() ?? 0.0;
          final confirmationRate =
              (s['confirmation_rate'] as num?)?.toDouble() ?? 0.0;

          final rollingRows = rollingResult.getOrElse(
            (_) => <Map<String, dynamic>>[],
          );
          final rr = rollingRows.isNotEmpty
              ? rollingRows.first
              : <String, dynamic>{};
          final revenue7d = (rr['revenue_7d'] as num?)?.toDouble() ?? 0.0;
          final revenue30d = (rr['revenue_30d'] as num?)?.toDouble() ?? 0.0;

          final DashboardMetrics metricsEntity = DashboardMetrics(
            id: 'admin_metrics_daily',
            totalBookings: openBookings + completedTotal + cancelledTotal,
            pendingBookings: openBookings,
            completedBookings: completedTotal,
            totalRevenue: totalRevenue,
            monthlyRevenue: monthlyRevenue,
            activeProfessionals: totalProviders,
            totalCustomers: totalClients,
            averageRating: avgRating,
            completionRate: completionRate,
            confirmationRate: confirmationRate,
            revenue7d: revenue7d,
            revenue30d: revenue30d,
            recentActivities: activities,
          );

          store.dispatch(
            ActionCreators.success(
              DashboardActionTypes.loadDashboard,
              metricsEntity,
            ),
          );
        })
        .catchError((error) {
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
_refreshDashboard(SupabaseServiceInterface supabase) {
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
