import 'package:shared/shared.dart';
import 'package:languist/languist.dart';
import 'package:ui_kit/ui_kit.dart';

/// Dialog for filtering bookings
class BookingFilterDialog extends StatefulWidget {
  const BookingFilterDialog({
    super.key,
    required this.currentFilter,
    required this.onFilterChanged,
  });

  final BookingActivityStatus? currentFilter;
  final Function(BookingActivityStatus?) onFilterChanged;

  @override
  State<BookingFilterDialog> createState() => _BookingFilterDialogState();
}

class _BookingFilterDialogState extends State<BookingFilterDialog> {
  BookingActivityStatus? _selectedFilter;
  DateTimeRange? _dateRange;
  double _minPrice = 0;
  double _maxPrice = 1000;

  @override
  void initState() {
    super.initState();
    _selectedFilter = widget.currentFilter;
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
                      title: 'Booking Status',
                      icon: Icons.assignment,
                    ),
                    const SizedBox(height: 16),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        _buildStatusChip(null, 'All Bookings'),
                        ...BookingActivityStatus.values.map(
                          (BookingActivityStatus status) =>
                              _buildStatusChip(status, _getStatusName(status)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Date Range Filter
                    const SectionHeader(
                      title: 'Date Range',
                      icon: Icons.date_range,
                    ),
                    const SizedBox(height: 16),

                    InkWell(
                      onTap: () => _selectDateRange(context),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.colorScheme.outline),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.calendar_today,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                _dateRange != null
                                    ? '${_formatDate(_dateRange!.start)} - ${_formatDate(_dateRange!.end)}'
                                    : 'Select Date Range',
                                style: theme.textTheme.bodyLarge,
                              ),
                            ),
                            if (_dateRange != null)
                              IconButton(
                                onPressed: () =>
                                    setState(() => _dateRange = null),
                                icon: const Icon(Icons.clear),
                                iconSize: 20,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Price Range Filter
                    const SectionHeader(
                      title: 'Price Range',
                      icon: Icons.attach_money,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Price: \$${_minPrice.toInt()} - \$${_maxPrice.toInt()}',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),

                    RangeSlider(
                      values: RangeValues(_minPrice, _maxPrice),
                      min: 0,
                      max: 1000,
                      divisions: 20,
                      labels: RangeLabels(
                        '\$${_minPrice.toInt()}',
                        '\$${_maxPrice.toInt()}',
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _minPrice = values.start;
                          _maxPrice = values.end;
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

  Widget _buildStatusChip(BookingActivityStatus? status, String label) {
    final ThemeData theme = Theme.of(context);
    final bool isSelected = _selectedFilter == status;

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          _selectedFilter = selected ? status : null;
        });
      },
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primaryContainer,
      checkmarkColor: theme.colorScheme.primary,
    );
  }

  String _getStatusName(BookingActivityStatus status) {
    switch (status) {
      case BookingActivityStatus.pending:
        return 'Pending';
      case BookingActivityStatus.confirmed:
        return 'Confirmed';
      case BookingActivityStatus.assigned:
        return 'Assigned';
      case BookingActivityStatus.inProgress:
        return 'In Progress';
      case BookingActivityStatus.completed:
        return 'Completed';
      case BookingActivityStatus.cancelled:
        return 'Cancelled';
      case BookingActivityStatus.rescheduled:
        return 'Rescheduled';
      case BookingActivityStatus.noShow:
        return 'No Show';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      initialDateRange: _dateRange,
    );
    if (picked != null) {
      setState(() {
        _dateRange = picked;
      });
    }
  }

  void _clearFilters() {
    setState(() {
      _selectedFilter = null;
      _dateRange = null;
      _minPrice = 0;
      _maxPrice = 1000;
    });
  }

  void _applyFilters() {
    widget.onFilterChanged(_selectedFilter);
    Navigator.of(context).pop();

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Filters applied successfully'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
