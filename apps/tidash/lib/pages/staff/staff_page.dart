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

    return StoreConnector<AppState, CleanerState>(
      converter: (Store<AppState> store) => store.state.cleanerState,
      builder: (BuildContext context, CleanerState cleanerState) {
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // Search and filter bar
                Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: l10n.search,
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (String value) {
                          // Update search filter
                          final CleanerFilters updatedFilters = cleanerState
                              .filters
                              .copyWith(
                                searchQuery: value.isEmpty ? null : value,
                              );
                          StoreProvider.of<AppState>(
                            context,
                            listen: false,
                          ).dispatch(
                            UpdateCleanerFiltersAction(filters: updatedFilters),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    FilterChip(
                      label: Text(_getFilterLabel(cleanerState.filters, l10n)),
                      selected: _hasActiveFilters(cleanerState.filters),
                      onSelected: (bool selected) {
                        if (!selected) {
                          StoreProvider.of<AppState>(
                            context,
                            listen: false,
                          ).dispatch(const ClearCleanerFiltersAction());
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Staff grid
                Expanded(child: _buildStaffGrid(context, cleanerState)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStaffGrid(BuildContext context, CleanerState cleanerState) {
    return StoreConnector<AppState, StaffViewModel>(
      converter: (Store<AppState> store) => StaffViewModel.fromStore(store),
      builder: (BuildContext context, StaffViewModel viewModel) {
        if (viewModel.isLoading && viewModel.cleaners.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.cleaners.isEmpty) {
          final IntlLocalizations l10n = Languist.of(context);
          return EmptyState(
            icon: Icons.people_outline,
            title: l10n.noStaff,
            description: l10n.noStaffDescription,
            action: ElevatedButton.icon(
              onPressed: () => _showAddStaffDialog(context),
              icon: const Icon(Icons.person_add),
              label: Text(l10n.addStaff),
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            viewModel.onRefresh();
          },
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: viewModel.cleaners.length,
            itemBuilder: (BuildContext context, int index) {
              final Cleaner cleaner = viewModel.cleaners[index];
              return StaffCard(
                cleaner: cleaner,
                onTap: () => _navigateToStaffDetails(context, cleaner),
                onStatusChanged: (CleanerStatus status) =>
                    viewModel.onUpdateCleanerStatus(cleaner.id, status),
              );
            },
          ),
        );
      },
    );
  }

  String _getFilterLabel(CleanerFilters filters, IntlLocalizations l10n) {
    if (filters.status != null) {
      return filters.status!.name;
    }
    return 'All';
  }

  bool _hasActiveFilters(CleanerFilters filters) {
    return filters.status != null ||
        (filters.searchQuery != null && filters.searchQuery!.isNotEmpty);
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
                null, // TODO: Implement cleaner filters
            builder: (BuildContext context, CleanerStatus? currentFilter) =>
                StaffFilterDialog(
                  currentFilter: currentFilter,
                  onFilterChanged: (CleanerStatus? filter) {
                    StoreProvider.of<AppState>(context, listen: false).dispatch(
                      UpdateCleanerFiltersAction(
                        filters: CleanerFilters(status: filter),
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
      cleaners.where((Cleaner c) => c.status == CleanerStatus.available).length;

  int get busyStaff =>
      cleaners.where((Cleaner c) => c.status == CleanerStatus.offline).length;

  static StaffViewModel fromStore(Store<AppState> store) {
    return StaffViewModel(
      cleaners: const <Cleaner>[], // TODO: Implement cleaners data source
      isLoading: false, // TODO: Connect to appropriate state
      error: null, // TODO: Connect to appropriate error handling
      currentFilter: null, // TODO: Implement cleaner filters
      onRefresh: () {}, // TODO: Implement refresh action
      onFilterChanged: (CleanerStatus? filter) => store.dispatch(
        UpdateCleanerFiltersAction(filters: CleanerFilters(status: filter)),
      ),
      onUpdateCleanerStatus: (String cleanerId, CleanerStatus status) =>
          store.dispatch(
            UpdateCleanerStatusAction(cleanerId: cleanerId, status: status),
          ),
    );
  }
}
