import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../widgets/dialogs/add_staff_dialog.dart';
import '../../widgets/dialogs/staff_details_dialog.dart';
import '../../widgets/dialogs/staff_filter_dialog.dart';
import 'staff_view_model.dart';

class StaffPage extends StatelessWidget {
  const StaffPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, StaffViewModel>(
      converter: (store) => StaffViewModel.fromStore(store),
      onInit: (store) => store.dispatch(const LoadProfessionalsAction()),
      builder: (context, vm) {
        return PageScaffold(
          header: Header(
            title: 'Staff',
            actions: [
              Button(
                label: 'Add Staff',
                icon: Icons.person_add,
                onPressed: () => _showAddStaffDialog(context),
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterDialog(context, vm),
                tooltip: 'Filter',
              ),
            ],
          ),
          body: vm.isLoading && vm.professionals.isEmpty
              ? const LoadingIndicator(message: 'Loading staff...')
              : vm.professionals.isEmpty
                  ? EmptyState(
                      icon: Icons.people_outline,
                      title: 'No Staff Found',
                      description: 'There are no staff members to display.',
                      action: Button(
                        label: 'Add Staff',
                        icon: Icons.person_add,
                        onPressed: () => _showAddStaffDialog(context),
                      ),
                    )
                  : _StaffContent(vm: vm),
        );
      },
    );
  }

  void _showAddStaffDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const AddStaffDialog(),
    );
  }

  void _showFilterDialog(BuildContext context, StaffViewModel vm) {
    showDialog<void>(
      context: context,
      builder: (context) => StaffFilterDialog(
        currentFilter: vm.currentFilter,
        onFilterChanged: vm.onFilterChanged,
      ),
    );
  }
}

class _StaffContent extends StatelessWidget {
  const _StaffContent({required this.vm});

  final StaffViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: _StaffFilter(vm: vm),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => vm.onRefresh(),
            child: _StaffGrid(vm: vm),
          ),
        ),
      ],
    );
  }
}

class _StaffFilter extends StatelessWidget {
  const _StaffFilter({required this.vm});

  final StaffViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: InputField(
            hintText: 'Search',
            prefixIcon: Icons.search,
            onChanged: (value) {
              // TODO: Implement search
            },
          ),
        ),
        const SizedBox(width: 16),
        Select<ProfessionalActivityStatus?>(
          value: vm.currentFilter,
          onChanged: (value) => vm.onFilterChanged(value),
          items: [
            const SelectOption(value: null, label: 'All'),
            ...ProfessionalActivityStatus.values.map(
              (status) => SelectOption(value: status, label: status.name),
            ),
          ],
        ),
      ],
    );
  }
}

class _StaffGrid extends StatelessWidget {
  const _StaffGrid({required this.vm});

  final StaffViewModel vm;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: vm.professionals.length,
      itemBuilder: (context, index) {
        final professional = vm.professionals[index];
        return StaffCard(
          professional: professional,
          onTap: () => _navigateToStaffDetails(context, professional),
          onStatusChanged: (status) =>
              vm.onUpdateProfessionalStatus(professional.id, status),
        );
      },
    );
  }

  void _navigateToStaffDetails(
    BuildContext context,
    ProfessionalProfile professional,
  ) {
    showDialog<void>(
      context: context,
      builder: (context) => StaffDetailsDialog(professional: professional),
    );
  }
}
