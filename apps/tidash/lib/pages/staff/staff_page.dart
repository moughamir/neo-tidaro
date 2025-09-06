import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:languist/languist.dart';
import '../../widgets/dialogs/add_staff_dialog.dart';
import '../../widgets/dialogs/staff_filter_dialog.dart';
import '../../widgets/dialogs/staff_details_dialog.dart';

/// Staff management page for TiDash
class StaffPage extends StatefulWidget {
  const StaffPage({super.key});

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  @override
  void initState() {
    super.initState();
    // Load cleaners when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Store<AppState> store = StoreProvider.of<AppState>(
        context,
        listen: false,
      );
      store.dispatch(const LoadCleanersAction());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.staff),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: () => _showAddStaffDialog(context),
            tooltip: l10n.add,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
            tooltip: l10n.filter,
          ),
        ],
      ),
      body: StoreConnector<AppState, StaffViewModel>(
        converter: (Store<AppState> store) => StaffViewModel.fromStore(store),
        builder: (BuildContext context, StaffViewModel viewModel) {
          if (viewModel.isLoading && viewModel.cleaners.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.cleaners.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return RefreshIndicator(
            onRefresh: () async {
              viewModel.onRefresh();
            },
            child: CustomScrollView(
              slivers: <Widget>[
                // Staff stats header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: StaffHeader(
                      totalStaff: viewModel.cleaners.length,
                      availableStaff: viewModel.availableStaff,
                      busyStaff: viewModel.busyStaff,
                      onFilterChanged: viewModel.onFilterChanged,
                      currentFilter: viewModel.currentFilter,
                    ),
                  ),
                ),
                // Staff grid
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                    delegate: SliverChildBuilderDelegate((
                      BuildContext context,
                      int index,
                    ) {
                      final Cleaner cleaner = viewModel.cleaners[index];
                      return StaffCard(
                        cleaner: cleaner,
                        onTap: () => _navigateToStaffDetails(context, cleaner),
                        onStatusChanged: (CleanerStatus status) =>
                            viewModel.onUpdateCleanerStatus(cleaner.id, status),
                      );
                    }, childCount: viewModel.cleaners.length),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, IntlLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.people_outline,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noStaff,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.noStaffDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showAddStaffDialog(context),
            icon: const Icon(Icons.person_add),
            label: Text(l10n.addStaff),
          ),
        ],
      ),
    );
  }

  void _showAddStaffDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => const AddStaffDialog(),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          StoreConnector<AppState, CleanerStatus?>(
            converter: (Store<AppState> store) =>
                HousekeepingSelectors.getCleanerFilters(store.state).status,
            builder: (BuildContext context, CleanerStatus? currentFilter) =>
                StaffFilterDialog(
                  currentFilter: currentFilter,
                  onFilterChanged: (CleanerStatus? filter) {
                    StoreProvider.of<AppState>(context, listen: false).dispatch(
                      UpdateCleanerFiltersAction(
                        CleanerFilters(status: filter),
                      ),
                    );
                  },
                ),
          ),
    );
  }

  void _navigateToStaffDetails(BuildContext context, Cleaner cleaner) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => StaffDetailsDialog(cleaner: cleaner),
    );
  }
}

/// ViewModel for staff page
class StaffViewModel {
  const StaffViewModel({
    required this.cleaners,
    required this.isLoading,
    required this.error,
    required this.currentFilter,
    required this.onRefresh,
    required this.onFilterChanged,
    required this.onUpdateCleanerStatus,
  });

  final List<Cleaner> cleaners;
  final bool isLoading;
  final String? error;
  final CleanerStatus? currentFilter;
  final VoidCallback onRefresh;
  final Function(CleanerStatus?) onFilterChanged;
  final Function(String cleanerId, CleanerStatus status) onUpdateCleanerStatus;

  int get availableStaff =>
      cleaners.where((Cleaner c) => c.status == CleanerStatus.active).length;

  int get busyStaff =>
      cleaners.where((Cleaner c) => c.status == CleanerStatus.inactive).length;

  static StaffViewModel fromStore(Store<AppState> store) {
    return StaffViewModel(
      cleaners: HousekeepingSelectors.getFilteredCleaners(store.state),
      isLoading: store.state.housekeepingState.isLoading,
      error: store.state.housekeepingState.error,
      currentFilter: HousekeepingSelectors.getCleanerFilters(
        store.state,
      ).status,
      onRefresh: () => store.dispatch(const LoadCleanersAction()),
      onFilterChanged: (CleanerStatus? filter) => store.dispatch(
        UpdateCleanerFiltersAction(CleanerFilters(status: filter)),
      ),
      onUpdateCleanerStatus: (String cleanerId, CleanerStatus status) =>
          store.dispatch(
            UpdateCleanerStatusAction(cleanerId: cleanerId, status: status),
          ),
    );
  }
}
