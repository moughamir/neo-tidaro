// ignore_for_file: unrelated_type_equality_checks

import 'package:shared/shared.dart';
import 'package:tidash/widgets/dialogs/add_staff_dialog.dart';
import 'package:tidash/widgets/dialogs/staff_details_dialog.dart';
import 'package:tidash/widgets/dialogs/staff_filter_dialog.dart';
import 'package:ui_kit/ui_kit.dart';

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
    // Load professionals when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Store<AppState> store = StoreProvider.of<AppState>(
        context,
        listen: false,
      );
      store.dispatch(const LoadProfessionalsAction());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return StoreConnector<AppState, ProfessionalState>(
      converter: (Store<AppState> store) => store.state.professionalState,
      builder: (BuildContext context, ProfessionalState professionalState) {
        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          appBar: AppBar(
            title: Text('l10n.staff'),
            backgroundColor: Colors.transparent,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.person_add),
                onPressed: () => _showAddStaffDialog(context),
                tooltip: 'l10n.add',
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterDialog(context),
                tooltip: 'l10n.filter',
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
                          hintText: 'l10n.search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onChanged: (String value) {
                          // Update search filter
                          final dynamic updatedFilters = professionalState
                              .filters
                              .copyWith(
                                searchQuery: value.isEmpty ? null : value,
                              );
                          StoreProvider.of<AppState>(
                            context,
                            listen: false,
                          ).dispatch(
                            UpdateProfessionalsFiltersAction(
                              filters: updatedFilters,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    FilterChip(
                      label: Text(_getFilterLabel(professionalState.filters)),
                      selected: _hasActiveFilters(professionalState.filters),
                      onSelected: (bool selected) {
                        if (!selected) {
                          StoreProvider.of<AppState>(
                            context,
                            listen: false,
                          ).dispatch(const ClearProfessionalsFiltersAction());
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Staff grid
                Expanded(child: _buildStaffGrid(context, professionalState)),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildStaffGrid(
    BuildContext context,
    ProfessionalState professionalState,
  ) {
    return StoreConnector<AppState, StaffViewModel>(
      converter: (Store<AppState> store) => StaffViewModel.fromStore(store),
      builder: (BuildContext context, StaffViewModel viewModel) {
        if (viewModel.isLoading && viewModel.professionals.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        if (viewModel.professionals.isEmpty) {
          return EmptyState(
            icon: Icons.people_outline,
            title: 'l10n.noStaff',
            description: 'l10n.noStaffDescription',
            action: ElevatedButton.icon(
              onPressed: () => _showAddStaffDialog(context),
              icon: const Icon(Icons.person_add),
              label: Text('l10n.addStaff'),
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
            itemCount: viewModel.professionals.length,
            itemBuilder: (BuildContext context, int index) {
              final ProfessionalProfile professional =
                  viewModel.professionals[index];
              return StaffCard(
                professional: professional,
                onTap: () => _navigateToStaffDetails(context, professional),
                onStatusChanged: (ProfessionalKycStatus status) => viewModel
                    .onUpdateProfessionalStatus(professional.id, status),
              );
            },
          ),
        );
      },
    );
  }

  String _getFilterLabel(filters) {
    if (filters.status != null) {
      return filters.status!.name;
    }
    return 'All';
  }

  bool _hasActiveFilters(dynamic filters) {
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
          StoreConnector<AppState, ProfessionalActionTypes?>(
            converter: (Store<AppState> store) =>
                null, // TODO: Implement professional filters
            builder:
                (
                  BuildContext context,
                  ProfessionalActionTypes? currentFilter,
                ) => StaffFilterDialog(
                  onFilterChanged: (ProfessionalActivityStatus? filter) {
                    StoreProvider.of<AppState>(context, listen: false).dispatch(
                      UpdateProfessionalsFiltersAction(filters: currentFilter),
                    );
                  },
                  currentFilter: null,
                ),
          ),
    );
  }

  void _navigateToStaffDetails(
    BuildContext context,
    ProfessionalProfile professional,
  ) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          StaffDetailsDialog(professional: professional),
    );
  }
}

/// ViewModel for staff page
class StaffViewModel {
  const StaffViewModel({
    required this.professionals,
    required this.isLoading,
    required this.error,
    required this.currentFilter,
    required this.onRefresh,
    required this.onFilterChanged,
    required this.onUpdateProfessionalStatus,
  });

  final List<ProfessionalProfile> professionals;
  final bool isLoading;
  final String? error;
  final ProfessionalKycStatus? currentFilter;
  final VoidCallback onRefresh;
  final Function(ProfessionalActivityStatus?) onFilterChanged;
  final Function(String professionalId, ProfessionalKycStatus status)
  onUpdateProfessionalStatus;

  int get availableStaff => professionals
      .where(
        (ProfessionalProfile p) =>
            p.status == ProfessionalActivityStatus.available,
      )
      .length;

  int get busyStaff => professionals
      .where(
        (ProfessionalProfile p) =>
            p.status == ProfessionalActivityStatus.offline,
      )
      .length;

  static StaffViewModel fromStore(Store<AppState> store) {
    return StaffViewModel(
      professionals: const <ProfessionalProfile>[],
      isLoading: false,
      error: null,
      currentFilter: null,
      onRefresh: () {},

      onUpdateProfessionalStatus:
          (String professionalId, ProfessionalKycStatus status) =>
              store.dispatch(
                UpdateProfessionalStatusAction(
                  professionalId: professionalId,
                  status: status,
                ),
              ),
      onFilterChanged: (ProfessionalActivityStatus? p1) {
        return p1;
      },
    );
  }
}
