import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import '../admin/admin_users_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();
    // Load dashboard data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Store<AppState> store = StoreProvider.of<AppState>(context);
      store.dispatch(const LoadDashboardAction());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: StoreConnector<AppState, DashboardViewModel>(
        converter: (Store<AppState> store) =>
            DashboardViewModel.fromStore(store),
        builder: (BuildContext context, DashboardViewModel viewModel) {
          if (viewModel.isLoading && viewModel.dashboardMetrics == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return CustomScrollView(
            slivers: <Widget>[
              // Header
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DashboardHeader(
                      onRefresh: viewModel.onRefresh,
                      isRefreshing: viewModel.isRefreshing,
                      lastUpdated: viewModel.lastUpdated,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AdminUsersPage(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.supervised_user_circle_outlined),
                        label: const Text('View Admin Users'),
                      ),
                    ),
                  ],
                ),
              ),

              // Metrics Grid
              if (viewModel.dashboardMetrics != null)
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16.0,
                          crossAxisSpacing: 16.0,
                          childAspectRatio: 1.5,
                        ),
                    delegate: SliverChildBuilderDelegate((
                      BuildContext context,
                      int index,
                    ) {
                      final DashboardMetrics metrics =
                          viewModel.dashboardMetrics!;
                      return _buildMetricCard(context, index, metrics);
                    }, childCount: 6),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Activity Feed
              if (viewModel.dashboardMetrics != null)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(
                    // ignore: always_specify_types
                    child: ActivityFeed(
                      activities: viewModel.dashboardMetrics!.recentActivities,
                      titleExtractor: (ActivityItem activity) {
                        return activity.title;
                      },
                      descriptionExtractor: (ActivityItem activity) {
                        return activity.description;
                      },
                      timestampExtractor: (ActivityItem activity) {
                        return activity.timestamp;
                      },
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          );
        },
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
          value: '\$${metrics.monthlyRevenue.toStringAsFixed(0)}',
          icon: const Icon(Icons.attach_money),
        );
      case 3:
        return MetricCard(
          title: 'Total Bookings',
          value: metrics.totalBookings.toString(),
          icon: const Icon(Icons.shopping_cart),
        );
      case 4:
        // Revenue trend: 7d vs 30d
        final rev7 = metrics.revenue7d;
        final rev30 = metrics.revenue30d;
        final isPositive = rev30 == 0 ? (rev7 > 0) : (rev7 >= rev30);
        final pct = rev30 == 0
            ? (rev7 > 0 ? 100.0 : 0.0)
            : (((rev7 - rev30) / rev30) * 100.0);
        final trendText = '${pct.isFinite ? pct.toStringAsFixed(0) : '0'}%';
        return MetricCard(
          title: 'Revenue Trend (7d vs 30d)',
          value: '\$${rev7.toStringAsFixed(0)}',
          icon: const Icon(Icons.trending_up),
          trend: trendText,
          isPositiveTrend: isPositive,
        );
      case 5:
        // Confirmation rate
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

class DashboardViewModel {
  factory DashboardViewModel.fromStore(Store<AppState> store) {
    return DashboardViewModel(
      isLoading: DashboardSelectors.isLoading(store.state),
      isRefreshing: false, // TODO: Add isRefreshing to selectors
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
