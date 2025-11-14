import 'package:shared/shared.dart';

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
      professionals: store.state.professionalState.professionals,
      isLoading: store.state.professionalState.isLoading,
      error: store.state.professionalState.error,
      currentFilter: store.state.professionalState.filters.status,
      onRefresh: () => store.dispatch(const LoadProfessionalsAction()),
      onFilterChanged: (ProfessionalActivityStatus? filter) {
        store.dispatch(
          UpdateProfessionalsFiltersAction(
            filters: store.state.professionalState.filters.copyWith(status: filter),
          ),
        );
      },
      onUpdateProfessionalStatus:
          (String professionalId, ProfessionalKycStatus status) =>
              store.dispatch(
                UpdateProfessionalStatusAction(
                  professionalId: professionalId,
                  status: status,
                ),
              ),
    );
  }
}
