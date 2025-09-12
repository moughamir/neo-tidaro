import 'package:shared/shared.dart';
import 'package:languist/languist.dart';
import 'package:ui_kit/ui_kit.dart';

/// Dialog for filtering staff members
class StaffFilterDialog extends StatefulWidget {
  const StaffFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final ProfessionalActivityStatus? currentFilter;
  final Function(ProfessionalActivityStatus?) onFilterChanged;

  @override
  State<StaffFilterDialog> createState() => _StaffFilterDialogState();
}

class _StaffFilterDialogState extends State<StaffFilterDialog> {
  ProfessionalActivityStatus? _selectedStatus;
  bool? _availabilityFilter;
  final List<ServiceCategory> _selectedSpecialties = <ServiceCategory>[];
  double _minRating = 0;
  double _maxRating = 5;

  @override
  void initState() {
    super.initState();
    _selectedStatus = widget.currentFilter;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header
            Row(
              children: <Widget>[
                Icon(
                  Icons.filter_list,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.filter,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Filter Options
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Status Filter
                    const SectionHeader(
                      title: 'Employment Status',
                      icon: Icons.assignment_ind,
                    ),
                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        _buildStatusChip(null, 'All Staff'),
                        ...ProfessionalActivityStatus.values.map(
                          (ProfessionalActivityStatus status) =>
                              _buildStatusChip(status, _getStatusName(status)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Availability Filter
                    const SectionHeader(
                      title: 'Availability',
                      icon: Icons.schedule,
                    ),
                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        _buildAvailabilityChip(null, 'All'),
                        _buildAvailabilityChip(true, 'Available'),
                        _buildAvailabilityChip(false, 'Unavailable'),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Specialties Filter
                    const SectionHeader(title: 'Specialties', icon: Icons.star),
                    const SizedBox(height: 16),

                    Text(
                      l10n.staffFilterByServiceSpecialties,
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 8),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: ServiceCategory.values.map((
                        ServiceCategory category,
                      ) {
                        final bool isSelected = _selectedSpecialties.contains(
                          category,
                        );
                        return FilterChip(
                          label: Text(_getServiceCategoryName(category)),
                          selected: isSelected,
                          onSelected: (bool selected) {
                            setState(() {
                              if (selected) {
                                _selectedSpecialties.add(category);
                              } else {
                                _selectedSpecialties.remove(category);
                              }
                            });
                          },
                          backgroundColor: theme.colorScheme.surface,
                          selectedColor: theme.colorScheme.primaryContainer,
                          checkmarkColor: theme.colorScheme.primary,
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),

                    // Rating Range Filter
                    SectionHeader(
                      title: Languist.of(context).staffFilterRatingRange,
                      icon: Icons.star_rate,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      '${Languist.of(context).staffFilterRating}: ${_minRating.toStringAsFixed(1)} - ${_maxRating.toStringAsFixed(1)} ${Languist.of(context).staffFilterStar}',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),

                    RangeSlider(
                      values: RangeValues(_minRating, _maxRating),
                      min: 0,
                      max: 5,
                      divisions: 10,
                      labels: RangeLabels(
                        _minRating.toStringAsFixed(1),
                        _maxRating.toStringAsFixed(1),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _minRating = values.start;
                          _maxRating = values.end;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => _clearFilters(),
                    child: Text(Languist.of(context).clear),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _applyFilters(),
                    child: Text(Languist.of(context).apply),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(ProfessionalActivityStatus? status, String label) {
    final ThemeData theme = Theme.of(context);
    final bool isSelected = _selectedStatus == status;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          _selectedStatus = selected ? status : null;
        });
      },
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primaryContainer,
      checkmarkColor: theme.colorScheme.primary,
    );
  }

  Widget _buildAvailabilityChip(bool? availability, String label) {
    final ThemeData theme = Theme.of(context);
    final bool isSelected = _availabilityFilter == availability;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          _availabilityFilter = selected ? availability : null;
        });
      },
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primaryContainer,
      checkmarkColor: theme.colorScheme.primary,
    );
  }

  String _getStatusName(ProfessionalActivityStatus status) {
    final IntlLocalizations l10n = Languist.of(context);
    switch (status) {
      case ProfessionalActivityStatus.available:
        return l10n.cleanerStatusAvailable;
      case ProfessionalActivityStatus.onJob:
        return l10n.cleanerStatusOnJob;
      case ProfessionalActivityStatus.offline:
        return l10n.cleanerStatusOffline;
      case ProfessionalActivityStatus.onBreak:
        return l10n.cleanerStatusOnBreak;
    }
  }

  String _getServiceCategoryName(ServiceCategory category) {
    final IntlLocalizations l10n = Languist.of(context);
    switch (category) {
      case ServiceCategory.regularCleaning:
        return l10n.serviceCategoryRegularCleaning;
      case ServiceCategory.deepCleaning:
        return l10n.serviceCategoryDeepCleaning;
      case ServiceCategory.moveInOut:
        return l10n.serviceCategoryMoveInOut;
      case ServiceCategory.postConstruction:
        return l10n.serviceCategoryPostConstruction;
      case ServiceCategory.commercial:
        return l10n.serviceCategoryCommercial;
      case ServiceCategory.specialized:
        // Fallback: Languist currently has no `serviceCategorySpecialized` key.
        // Consider adding it to Languist ARB files. Using a safe English fallback meanwhile.
        return 'Specialized';
      case ServiceCategory.standardCleaning:
        return l10n.serviceCategoryStandardCleaning;
      case ServiceCategory.residential:
        return l10n.serviceCategoryResidential;
      case ServiceCategory.cleaning:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.laundry:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.cooking:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.babysitting:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.petCare:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.gardening:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.maintenance:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.organization:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.other:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedStatus = null;
      _availabilityFilter = null;
      _selectedSpecialties.clear();
      _minRating = 0;
      _maxRating = 5;
    });
  }

  void _applyFilters() {
    widget.onFilterChanged(_selectedStatus);
    Navigator.of(context).pop();

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(Languist.of(context).staffFiltersAppliedSuccessfully),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
