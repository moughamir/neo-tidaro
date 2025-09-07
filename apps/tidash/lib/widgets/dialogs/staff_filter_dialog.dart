import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:languist/languist.dart';

/// Dialog for filtering staff members
class StaffFilterDialog extends StatefulWidget {
  const StaffFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final CleanerStatus? currentFilter;
  final Function(CleanerStatus?) onFilterChanged;

  @override
  State<StaffFilterDialog> createState() => _StaffFilterDialogState();
}

class _StaffFilterDialogState extends State<StaffFilterDialog> {
  CleanerStatus? _selectedStatus;
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
                    _buildSectionHeader(
                      'Employment Status',
                      Icons.assignment_ind,
                    ),
                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        _buildStatusChip(null, 'All Staff'),
                        ...CleanerStatus.values.map(
                          (CleanerStatus status) =>
                              _buildStatusChip(status, _getStatusName(status)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Availability Filter
                    _buildSectionHeader('Availability', Icons.schedule),
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
                    _buildSectionHeader('Specialties', Icons.star),
                    const SizedBox(height: 16),

                    Text(
                      'Filter by service specialties:',
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
                    _buildSectionHeader('Rating Range', Icons.star_rate),
                    const SizedBox(height: 16),

                    Text(
                      'Rating: ${_minRating.toStringAsFixed(1)} - ${_maxRating.toStringAsFixed(1)} stars',
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
                    child: Text(l10n.clear),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _applyFilters(),
                    child: Text(l10n.apply),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final ThemeData theme = Theme.of(context);
    return Row(
      children: <Widget>[
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.primary,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(CleanerStatus? status, String label) {
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

  String _getStatusName(CleanerStatus status) {
    switch (status) {
      case CleanerStatus.active:
        return 'Active';
      case CleanerStatus.inactive:
        return 'Inactive';
      case CleanerStatus.suspended:
        return 'Suspended';
      case CleanerStatus.pending:
        return 'Pending';
    }
  }

  String _getServiceCategoryName(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.regularCleaning:
        return 'Regular Cleaning';
      case ServiceCategory.deepCleaning:
        return 'Deep Cleaning';
      case ServiceCategory.moveInOut:
        return 'Move In/Out';
      case ServiceCategory.postConstruction:
        return 'Post Construction';
      case ServiceCategory.commercial:
        return 'Commercial';
      case ServiceCategory.specialized:
        return 'Specialized';
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
        content: const Text('Staff filters applied successfully'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
