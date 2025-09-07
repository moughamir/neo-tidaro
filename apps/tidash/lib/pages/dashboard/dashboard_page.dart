import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:languist/languist.dart';

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

          final IntlLocalizations l10n = Languist.of(context);

          return CustomScrollView(
            slivers: <Widget>[
              // Header
              SliverToBoxAdapter(
                child: DashboardHeader(
                  onRefresh: viewModel.onRefresh,
                  isRefreshing: viewModel.isRefreshing,
                  lastUpdated: viewModel.lastUpdated,
                ),
              ),

              // Metrics Grid
              if (viewModel.dashboardMetrics != null)
                SliverPadding(
                  padding: const EdgeInsets.all(16.0),
                  sliver: SliverGrid(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: 1.5,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final metrics = viewModel.dashboardMetrics!;
                        return _buildMetricCard(context, index, metrics, l10n);
                      },
                      childCount: 4,
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Activity Feed
              if (viewModel.dashboardMetrics != null)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(
                    child: ActivityFeed(
                      activities: viewModel.dashboardMetrics!.recentActivities,
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
    IntlLocalizations l10n,
  ) {
    switch (index) {
      case 0:
        return MetricCard(
          title: 'Total Customers',
          value: metrics.totalCustomers.toString(),
          icon: Icons.people,
        );
      case 1:
        return MetricCard(
          title: 'Active Cleaners',
          value: metrics.activeCleaners.toString(),
          icon: Icons.assignment,
        );
      case 2:
        return MetricCard(
          title: 'Monthly Revenue',
          value: '\$${metrics.monthlyRevenue.toStringAsFixed(0)}',
          icon: Icons.attach_money,
        );
      case 3:
        return MetricCard(
          title: 'Total Bookings',
          value: metrics.totalBookings.toString(),
          icon: Icons.shopping_cart,
        );
      default:
        return const SizedBox.shrink();
    }
  }

}

class DashboardViewModel {
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
}
