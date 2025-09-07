import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
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
    // Load dashboard and housekeeping data on init
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Store<AppState> store = StoreProvider.of<AppState>(context);
      store.dispatch(const LoadDashboardAction());
      store.dispatch(const LoadHousekeepingMetricsAction());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      body: StoreConnector<AppState, HousekeepingDashboardViewModel>(
        converter: (Store<AppState> store) =>
            HousekeepingDashboardViewModel.fromStore(store),
        builder: (BuildContext context, HousekeepingDashboardViewModel viewModel) {
          if (viewModel.isLoading && viewModel.housekeepingMetrics == null) {
            return const Center(child: CircularProgressIndicator());
          }

          final IntlLocalizations l10n = Languist.of(context);

          return CustomScrollView(
            slivers: <Widget>[
              // Header
              SliverToBoxAdapter(
                child: HousekeepingDashboardHeader(
                  onRefresh: viewModel.onRefresh,
                  isRefreshing: viewModel.isRefreshing,
                  lastUpdated: viewModel.lastUpdated,
                ),
              ),

              // Housekeeping Metrics Grid
              if (viewModel.housekeepingMetrics != null)
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
                            title: l10n.totalBookings,
                            value: _formatNumber(
                              viewModel.housekeepingMetrics!.totalBookings,
                            ),
                            icon: Icons.calendar_today_outlined,
                            color: Colors.blue,
                            trend: TrendDirection.up,
                            trendValue:
                                '+${viewModel.housekeepingMetrics!.bookingGrowthRate.toStringAsFixed(1)}%',
                            subtitle: 'from last month',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: l10n.activeBookings,
                            value: _formatNumber(
                              viewModel.housekeepingMetrics!.activeBookings,
                            ),
                            icon: Icons.pending_actions_outlined,
                            color: Colors.orange,
                            trend: TrendDirection.up,
                            trendValue:
                                '+${((viewModel.housekeepingMetrics!.activeBookings / viewModel.housekeepingMetrics!.totalBookings) * 100).toStringAsFixed(1)}%',
                            subtitle: 'currently active',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: l10n.monthlyRevenue,
                            value:
                                '\$${_formatCurrency(viewModel.housekeepingMetrics!.monthlyRevenue)}',
                            icon: Icons.attach_money,
                            color: Colors.green,
                            trend: TrendDirection.up,
                            trendValue:
                                '+${viewModel.housekeepingMetrics!.revenueGrowthRate.toStringAsFixed(1)}%',
                            subtitle: 'this month',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: l10n.activeCleaners,
                            value: _formatNumber(
                              viewModel.housekeepingMetrics!.activeCleaners,
                            ),
                            icon: Icons.cleaning_services_outlined,
                            color: Colors.purple,
                            trend: TrendDirection.up,
                            trendValue:
                                '${viewModel.housekeepingMetrics!.averageRating.toStringAsFixed(1)}★',
                            subtitle: 'avg rating',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: l10n.totalCustomers,
                            value: _formatNumber(
                              viewModel.housekeepingMetrics!.totalCustomers,
                            ),
                            icon: Icons.people_outline,
                            color: Colors.indigo,
                            trend: TrendDirection.up,
                            trendValue:
                                '${viewModel.housekeepingMetrics!.completedBookings} completed',
                            subtitle: 'total services',
                          ),
                        ),
                        StaggeredGridTile.count(
                          crossAxisCellCount: 2,
                          mainAxisCellCount: 1,
                          child: MetricCard(
                            title: l10n.totalRevenue,
                            value:
                                '\$${_formatCurrency(viewModel.housekeepingMetrics!.totalRevenue)}',
                            icon: Icons.trending_up,
                            color: Colors.teal,
                            trend: TrendDirection.up,
                            trendValue: 'All time',
                            subtitle: 'lifetime earnings',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 24)),

              // Housekeeping Activity Feed
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                sliver: SliverToBoxAdapter(
                  child: HousekeepingActivityFeed(
                    activities:
                        viewModel.housekeepingMetrics?.recentActivities ??
                        <HousekeepingActivity>[],
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

class HousekeepingDashboardViewModel {
  const HousekeepingDashboardViewModel({
    required this.isLoading,
    required this.isRefreshing,
    required this.housekeepingMetrics,
    required this.error,
    required this.lastUpdated,
    required this.onRefresh,
  });

  final bool isLoading;
  final bool isRefreshing;
  final HousekeepingMetrics? housekeepingMetrics;
  final String? error;
  final DateTime? lastUpdated;
  final VoidCallback onRefresh;

  factory HousekeepingDashboardViewModel.fromStore(Store<AppState> store) {
    return HousekeepingDashboardViewModel(
      isLoading: HousekeepingSelectors.isLoading(store.state),
      isRefreshing: HousekeepingSelectors.isRefreshing(store.state),
      housekeepingMetrics: HousekeepingSelectors.getMetrics(store.state),
      error: HousekeepingSelectors.getError(store.state),
      lastUpdated: HousekeepingSelectors.getLastUpdated(store.state),
      onRefresh: () => store.dispatch(const RefreshHousekeepingMetricsAction()),
    );
  }
}
