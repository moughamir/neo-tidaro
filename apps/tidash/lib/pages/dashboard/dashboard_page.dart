import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import '../admin/admin_users_page.dart';
import 'dashboard_view_model.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, DashboardViewModel>(
      converter: (store) => DashboardViewModel.fromStore(store),
      onInit: (store) => store.dispatch(const LoadDashboardAction()),
      builder: (context, vm) {
        return PageScaffold(
          // header: DashboardHeader(
          //   onRefresh: vm.onRefresh,
          //   isRefreshing: vm.isRefreshing,
          //   lastUpdated: vm.lastUpdated,
          // ),
          content: vm.isLoading && vm.dashboardMetrics == null
              ? const LoadingIndicator(message: 'Loading dashboard...')
              : _DashboardContent(vm: vm),
        );
      },
    );
  }
}

class _DashboardContent extends StatelessWidget {
  const _DashboardContent({required this.vm});

  final DashboardViewModel vm;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Align(
            alignment: Alignment.centerRight,
            child: KuiButton(
              icon: Icon(Icons.supervised_user_circle_outlined),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const AdminUsersPage()),
                );
              },
              child: Text('View Admin Users'),
            ),
          ),
        ),
        if (vm.dashboardMetrics != null)
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: _MetricsGrid(metrics: vm.dashboardMetrics!),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        if (vm.dashboardMetrics != null)
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverToBoxAdapter(
              child: ActivityFeed(
                activities: vm.dashboardMetrics!.recentActivities,
                titleExtractor: (activity) => activity.title,
                descriptionExtractor: (activity) => activity.description,
                timestampExtractor: (activity) => activity.timestamp,
              ),
            ),
          ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
      ],
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid({required this.metrics});

  final DashboardMetrics metrics;

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 1.5,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) => _buildMetricCard(context, index, metrics),
        childCount: 6,
      ),
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    int index,
    DashboardMetrics metrics,
  ) {
    switch (index) {
      case 0:
        return MetricCard(
          title: 'Total Customers',
          value: metrics.totalCustomers.toString(),
          icon: const Icon(Icons.people),
        );
      case 1:
        return MetricCard(
          title: 'Active Professionals',
          value: metrics.activeProfessionals.toString(),
          icon: const Icon(Icons.assignment),
        );
      case 2:
        return MetricCard(
          title: 'Monthly Revenue',
          value: '\${metrics.monthlyRevenue.toStringAsFixed(0)}',
          icon: const Icon(Icons.attach_money),
        );
      case 3:
        return MetricCard(
          title: 'Total Bookings',
          value: metrics.totalBookings.toString(),
          icon: const Icon(Icons.shopping_cart),
        );
      case 4:
        final rev7 = metrics.revenue7d;
        final rev30 = metrics.revenue30d;
        final isPositive = rev30 == 0 ? (rev7 > 0) : (rev7 >= rev30);
        final pct = rev30 == 0
            ? (rev7 > 0 ? 100.0 : 0.0)
            : (((rev7 - rev30) / rev30) * 100.0);
        final trendText = '${pct.isFinite ? pct.toStringAsFixed(0) : '0'}%';
        return MetricCard(
          title: 'Revenue Trend (7d vs 30d)',
          value: '\${rev7.toStringAsFixed(0)}',
          icon: const Icon(Icons.trending_up),
          trend: trendText,
          isPositiveTrend: isPositive,
        );
      case 5:
        final cr = (metrics.confirmationRate * 100).clamp(0, 100).toDouble();
        return MetricCard(
          title: 'Confirmation Rate',
          value: '${cr.toStringAsFixed(0)}%',
          icon: const Icon(Icons.verified),
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
