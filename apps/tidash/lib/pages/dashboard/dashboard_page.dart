import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
          if (viewModel.isLoading && viewModel.metrics == null) {
            return const Center(child: CircularProgressIndicator());
          }

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
              if (viewModel.metrics != null)
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverToBoxAdapter(
                    child: StaggeredGrid.count(
                      crossAxisCount: 4,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: <Widget>[
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: 'Total Users',
                            value: _formatNumber(viewModel.metrics!.totalUsers),
                            icon: Icons.people_outline,
                            color: Colors.blue,
                            trend: TrendDirection.up,
                            trendValue: '+12%',
                            subtitle: 'from last month',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: 'Active Users',
                            value: _formatNumber(
                              viewModel.metrics!.activeUsers,
                            ),
                            icon: Icons.trending_up,
                            color: Colors.green,
                            trend: TrendDirection.up,
                            trendValue: '+8%',
                            subtitle: 'from last week',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: 'Revenue',
                            value:
                                '\$${_formatCurrency(viewModel.metrics!.revenue)}',
                            icon: Icons.attach_money,
                            color: Colors.purple,
                            trend: TrendDirection.up,
                            trendValue:
                                '+${viewModel.metrics!.growthRate.toStringAsFixed(1)}%',
                            subtitle: 'this month',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: 'Orders',
                            value: _formatNumber(viewModel.metrics!.orders),
                            icon: Icons.shopping_cart_outlined,
                            color: Colors.orange,
                            trend: TrendDirection.up,
                            trendValue: '+5%',
                            subtitle: 'from yesterday',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Activity Feed
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: ActivityFeed(
                    activities:
                        viewModel.metrics?.recentActivities ?? <ActivityItem>[],
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

  String _formatNumber(int number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    }
    return number.toString();
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000) {
      return '${(amount / 1000000).toStringAsFixed(1)}M';
    } else if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K';
    }
    return amount.toStringAsFixed(2);
  }
}

class DashboardViewModel {
  const DashboardViewModel({
    required this.isLoading,
    required this.isRefreshing,
    required this.metrics,
    required this.error,
    required this.lastUpdated,
    required this.onRefresh,
  });

  final bool isLoading;
  final bool isRefreshing;
  final DashboardMetrics? metrics;
  final String? error;
  final DateTime? lastUpdated;
  final VoidCallback onRefresh;

  factory DashboardViewModel.fromStore(Store<AppState> store) {
    return DashboardViewModel(
      isLoading: DashboardSelectors.isLoading(store.state),
      isRefreshing: DashboardSelectors.isRefreshing(store.state),
      metrics: DashboardSelectors.getMetrics(store.state),
      error: DashboardSelectors.getError(store.state),
      lastUpdated: DashboardSelectors.getLastUpdated(store.state),
      onRefresh: () => store.dispatch(const RefreshDashboardAction()),
    );
  }
}
