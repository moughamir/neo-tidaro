import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:languist/languist.dart';

/// Full activity log page for housekeeping operations
class ActivityLogPage extends StatefulWidget {
  const ActivityLogPage({super.key, required this.activities});

  final List<HousekeepingActivity> activities;

  @override
  State<ActivityLogPage> createState() => _ActivityLogPageState();
}

class _ActivityLogPageState extends State<ActivityLogPage> {
  List<HousekeepingActivity> _filteredActivities = [];
  HousekeepingActivityType? _selectedFilter;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredActivities = widget.activities;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final l10n = IntlLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.activityLog),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
            tooltip: l10n.filter,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              boxShadow: [
                BoxShadow(
                  color: theme.colorScheme.shadow.withValues(alpha: 0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterActivities,
              decoration: InputDecoration(
                hintText: l10n.searchActivities,
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          _filterActivities('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: theme.colorScheme.surfaceContainerHighest,
              ),
            ),
          ),

          // Filter Chips
          if (_selectedFilter != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  FilterChip(
                    label: Text(_getActivityTypeName(_selectedFilter!)),
                    selected: true,
                    onSelected: (_) => _clearFilter(),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: _clearFilter,
                  ),
                ],
              ),
            ),

          // Activity List
          Expanded(
            child: _filteredActivities.isEmpty
                ? _buildEmptyState(context)
                : ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredActivities.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final activity = _filteredActivities[index];
                      return _buildActivityCard(context, activity);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final l10n = IntlLocalizations.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.timeline,
            size: 64,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noActivitiesFound,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.noActivitiesFoundDescription,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityCard(
    BuildContext context,
    HousekeepingActivity activity,
  ) {
    final ThemeData theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: _getActivityColor(activity.type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: _getActivityColor(
                    activity.type,
                  ).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                _getActivityIcon(activity.type),
                color: _getActivityColor(activity.type),
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          activity.title,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getActivityColor(
                            activity.type,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _getActivityTypeName(activity.type),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: _getActivityColor(activity.type),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    activity.description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.access_time,
                        size: 16,
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.5,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        _formatFullTimestamp(activity.timestamp),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _filterActivities(String query) {
    setState(() {
      _filteredActivities = widget.activities.where((activity) {
        final matchesSearch =
            query.isEmpty ||
            activity.title.toLowerCase().contains(query.toLowerCase()) ||
            activity.description.toLowerCase().contains(query.toLowerCase());
        final matchesFilter =
            _selectedFilter == null || activity.type == _selectedFilter;
        return matchesSearch && matchesFilter;
      }).toList();
    });
  }

  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) => _FilterDialog(
        selectedFilter: _selectedFilter,
        onFilterSelected: (filter) {
          setState(() {
            _selectedFilter = filter;
            _filterActivities(_searchController.text);
          });
        },
      ),
    );
  }

  void _clearFilter() {
    setState(() {
      _selectedFilter = null;
      _filterActivities(_searchController.text);
    });
  }

  Color _getActivityColor(HousekeepingActivityType type) {
    switch (type) {
      case HousekeepingActivityType.bookingCreated:
        return Colors.blue;
      case HousekeepingActivityType.bookingConfirmed:
        return Colors.green;
      case HousekeepingActivityType.bookingStarted:
        return Colors.lightGreen;
      case HousekeepingActivityType.bookingCompleted:
        return Colors.lightGreen;
      case HousekeepingActivityType.bookingCancelled:
        return Colors.red;
      case HousekeepingActivityType.bookingRescheduled:
        return Colors.orange;
      case HousekeepingActivityType.cleanerAssigned:
        return Colors.purple;
      case HousekeepingActivityType.cleanerUnassigned:
        return Colors.grey;
      case HousekeepingActivityType.paymentReceived:
        return Colors.green;
      case HousekeepingActivityType.reviewSubmitted:
        return Colors.amber;
      case HousekeepingActivityType.customerRegistered:
        return Colors.indigo;
      case HousekeepingActivityType.cleanerRegistered:
        return Colors.cyan;
    }
  }

  IconData _getActivityIcon(HousekeepingActivityType type) {
    switch (type) {
      case HousekeepingActivityType.bookingCreated:
        return Icons.add_circle_outline;
      case HousekeepingActivityType.bookingConfirmed:
        return Icons.check_circle_outline;
      case HousekeepingActivityType.bookingStarted:
        return Icons.play_circle_outline;
      case HousekeepingActivityType.bookingCompleted:
        return Icons.task_alt;
      case HousekeepingActivityType.bookingCancelled:
        return Icons.cancel_outlined;
      case HousekeepingActivityType.bookingRescheduled:
        return Icons.schedule;
      case HousekeepingActivityType.cleanerAssigned:
        return Icons.person_add_outlined;
      case HousekeepingActivityType.cleanerUnassigned:
        return Icons.person_remove_outlined;
      case HousekeepingActivityType.paymentReceived:
        return Icons.payment;
      case HousekeepingActivityType.reviewSubmitted:
        return Icons.star_outline;
      case HousekeepingActivityType.customerRegistered:
        return Icons.person_outline;
      case HousekeepingActivityType.cleanerRegistered:
        return Icons.cleaning_services_outlined;
    }
  }

  String _getActivityTypeName(HousekeepingActivityType type) {
    final l10n = IntlLocalizations.of(context);
    switch (type) {
      case HousekeepingActivityType.bookingCreated:
        return l10n.bookingCreated;
      case HousekeepingActivityType.bookingConfirmed:
        return l10n.bookingConfirmed;
      case HousekeepingActivityType.bookingStarted:
        return 'Booking Started'; // TODO: Add to languist
      case HousekeepingActivityType.bookingCompleted:
        return l10n.bookingCompleted;
      case HousekeepingActivityType.bookingCancelled:
        return l10n.bookingCancelled;
      case HousekeepingActivityType.bookingRescheduled:
        return l10n.bookingRescheduled;
      case HousekeepingActivityType.cleanerAssigned:
        return l10n.cleanerAssigned;
      case HousekeepingActivityType.cleanerUnassigned:
        return l10n.cleanerUnassigned;
      case HousekeepingActivityType.paymentReceived:
        return l10n.paymentReceived;
      case HousekeepingActivityType.reviewSubmitted:
        return l10n.reviewSubmitted;
      case HousekeepingActivityType.customerRegistered:
        return l10n.customerRegistered;
      case HousekeepingActivityType.cleanerRegistered:
        return l10n.cleanerRegistered;
    }
  }

  String _formatFullTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays == 0) {
      return 'Today at ${_formatTime(timestamp)}';
    } else if (difference.inDays == 1) {
      return 'Yesterday at ${_formatTime(timestamp)}';
    } else if (difference.inDays < 7) {
      return '${_getDayName(timestamp.weekday)} at ${_formatTime(timestamp)}';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year} at ${_formatTime(timestamp)}';
    }
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String _getDayName(int weekday) {
    switch (weekday) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }
}

class _FilterDialog extends StatelessWidget {
  const _FilterDialog({
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final HousekeepingActivityType? selectedFilter;
  final ValueChanged<HousekeepingActivityType?> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final l10n = IntlLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.filterActivities),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: Text(l10n.allActivities),
              selected: selectedFilter == null,
              onTap: () {
                onFilterSelected(null);
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ...HousekeepingActivityType.values.map((type) {
              return ListTile(
                leading: Icon(_getActivityIcon(type)),
                title: Text(_getActivityTypeName(context, type)),
                selected: selectedFilter == type,
                onTap: () {
                  onFilterSelected(type);
                  Navigator.of(context).pop();
                },
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(l10n.cancel),
        ),
      ],
    );
  }

  IconData _getActivityIcon(HousekeepingActivityType type) {
    switch (type) {
      case HousekeepingActivityType.bookingCreated:
        return Icons.add_circle_outline;
      case HousekeepingActivityType.bookingConfirmed:
        return Icons.check_circle_outline;
      case HousekeepingActivityType.bookingStarted:
        return Icons.play_circle_outline;
      case HousekeepingActivityType.bookingCompleted:
        return Icons.task_alt;
      case HousekeepingActivityType.bookingCancelled:
        return Icons.cancel_outlined;
      case HousekeepingActivityType.bookingRescheduled:
        return Icons.schedule;
      case HousekeepingActivityType.cleanerAssigned:
        return Icons.person_add_outlined;
      case HousekeepingActivityType.cleanerUnassigned:
        return Icons.person_remove_outlined;
      case HousekeepingActivityType.paymentReceived:
        return Icons.payment;
      case HousekeepingActivityType.reviewSubmitted:
        return Icons.star_outline;
      case HousekeepingActivityType.customerRegistered:
        return Icons.person_outline;
      case HousekeepingActivityType.cleanerRegistered:
        return Icons.cleaning_services_outlined;
    }
  }

  String _getActivityTypeName(
    BuildContext context,
    HousekeepingActivityType type,
  ) {
    final l10n = IntlLocalizations.of(context);
    switch (type) {
      case HousekeepingActivityType.bookingCreated:
        return l10n.bookingCreated;
      case HousekeepingActivityType.bookingConfirmed:
        return l10n.bookingConfirmed;
      case HousekeepingActivityType.bookingStarted:
        return 'Booking Started'; // TODO: Add to languist
      case HousekeepingActivityType.bookingCompleted:
        return l10n.bookingCompleted;
      case HousekeepingActivityType.bookingCancelled:
        return l10n.bookingCancelled;
      case HousekeepingActivityType.bookingRescheduled:
        return l10n.bookingRescheduled;
      case HousekeepingActivityType.cleanerAssigned:
        return l10n.cleanerAssigned;
      case HousekeepingActivityType.cleanerUnassigned:
        return l10n.cleanerUnassigned;
      case HousekeepingActivityType.paymentReceived:
        return l10n.paymentReceived;
      case HousekeepingActivityType.reviewSubmitted:
        return l10n.reviewSubmitted;
      case HousekeepingActivityType.customerRegistered:
        return l10n.customerRegistered;
      case HousekeepingActivityType.cleanerRegistered:
        return l10n.cleanerRegistered;
    }
  }
}
