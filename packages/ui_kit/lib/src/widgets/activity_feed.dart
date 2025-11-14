import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'package:ui_kit/src/widgets/card.dart';
import 'package:ui_kit/src/widgets/empty_state.dart';
import 'package:ui_kit/src/widgets/housekeeping_activity_helpers.dart';
import 'package:ui_kit/src/widgets/utils/time_formatting.dart';

/// Generic activity feed component that can display any type of activities
/// T is the type of activity item
/// E is the type of activity enum (optional)
class ActivityFeed<T, E> extends StatelessWidget {
  const ActivityFeed({
    super.key,
    required this.activities,
    required this.titleExtractor,
    required this.descriptionExtractor,
    required this.timestampExtractor,
    this.typeExtractor,
    this.title = 'Recent Activity',
    this.iconBuilder,
    this.colorBuilder,
    this.emptyText,
    this.viewAllText,
    this.onViewAllPressed,
    this.maxItems,
    this.useGlassyCard = true,
  });

  /// List of activity items
  final List<T> activities;

  /// Function to extract title from an activity item
  final String Function(T activity) titleExtractor;

  /// Function to extract description from an activity item
  final String Function(T activity) descriptionExtractor;

  /// Function to extract timestamp from an activity item
  final DateTime Function(T activity) timestampExtractor;

  /// Optional function to extract type from an activity item
  final E? Function(T activity)? typeExtractor;

  /// Title of the activity feed
  final String title;

  /// Builder for activity icon based on type
  final IconData Function(E type)? iconBuilder;

  /// Builder for activity color based on type
  final Color Function(E type)? colorBuilder;

  /// Text to display when there are no activities
  final String? emptyText;

  /// Text for the "View All" button
  final String? viewAllText;

  /// Callback for when "View All" is pressed
  final VoidCallback? onViewAllPressed;

  /// Maximum number of items to display
  final int? maxItems;

  /// Whether to use GlassyCard as container
  final bool useGlassyCard;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final displayItems = maxItems != null && activities.length > maxItems!
        ? activities.take(maxItems!).toList()
        : activities;

    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (activities.length > (maxItems ?? activities.length) &&
                  viewAllText != null &&
                  onViewAllPressed != null)
                TextButton(
                  onPressed: onViewAllPressed,
                  child: Text(viewAllText!),
                ),
            ],
          ),
          const SizedBox(height: 16),
          if (activities.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.info_outline,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                      title: Text(
                        emptyText ?? 'l10n.noData',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: displayItems.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(height: 1),
              itemBuilder: (BuildContext context, int index) {
                final activity = displayItems[index];
                return _ActivityTile<T, E>(
                  activity: activity,
                  titleExtractor: titleExtractor,
                  descriptionExtractor: descriptionExtractor,
                  timestampExtractor: timestampExtractor,
                  typeExtractor: typeExtractor,
                  iconBuilder: iconBuilder,
                  colorBuilder: colorBuilder,
                );
              },
            ),
        ],
      ),
    );

    return useGlassyCard ? KuiCard.glass(child: content) : content;
  }
}

class _ActivityTile<T, E> extends StatelessWidget {
  const _ActivityTile({
    required this.activity,
    required this.titleExtractor,
    required this.descriptionExtractor,
    required this.timestampExtractor,
    this.typeExtractor,
    this.iconBuilder,
    this.colorBuilder,
  });

  final T activity;
  final String Function(T activity) titleExtractor;
  final String Function(T activity) descriptionExtractor;
  final DateTime Function(T activity) timestampExtractor;
  final E? Function(T activity)? typeExtractor;
  final IconData Function(E type)? iconBuilder;
  final Color Function(E type)? colorBuilder;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final title = titleExtractor(activity);
    final description = descriptionExtractor(activity);
    final timestamp = timestampExtractor(activity);
    final type = typeExtractor?.call(activity);

    final Color iconColor;
    final IconData iconData;

    if (type != null && colorBuilder != null) {
      iconColor = colorBuilder!(type);
    } else {
      iconColor = Colors.grey;
    }

    if (type != null && iconBuilder != null) {
      iconData = iconBuilder!(type);
    } else {
      iconData = Icons.info_outline;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(iconData, size: 20, color: iconColor),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
          Text(
            formatTimestampShort(timestamp),
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }
}

/// Activity feed component for housekeeping operations
/// Now implemented using the generic ActivityFeed component
class HousekeepingActivityFeed extends StatelessWidget {
  const HousekeepingActivityFeed({super.key, required this.activities});

  final List<HousekeepingActivity> activities;

  @override
  Widget build(BuildContext context) {
    return ActivityFeed<HousekeepingActivity, HousekeepingActivityType>(
      activities: activities,
      title: 'Recent Activity',
      emptyText: 'No recent housekeeping activities',
      viewAllText: 'View All Activities',
      onViewAllPressed: activities.length > 10
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => ActivityLogPage(activities: activities),
                ),
              );
            }
          : null,
      maxItems: 10,
      titleExtractor: (activity) => activity.title,
      descriptionExtractor: (activity) => activity.description,
      timestampExtractor: (activity) => activity.timestamp,
      typeExtractor: (activity) => activity.type,
      iconBuilder: getActivityIcon,
      colorBuilder: getActivityColor,
    );
  }
}

/// Backward compatibility adapter for the ActivityFeed component
/// This adapter allows using the new generic ActivityFeed with the old API
class ActivityFeedAdapter extends StatelessWidget {
  const ActivityFeedAdapter({
    super.key,
    required this.activities,
    this.title = 'Recent Activity',
    this.emptyText,
    this.viewAllText,
    this.onViewAllPressed,
    this.maxItems,
    this.useGlassyCard = true,
  });

  final List<ActivityItem> activities;
  final String title;
  final String? emptyText;
  final String? viewAllText;
  final VoidCallback? onViewAllPressed;
  final int? maxItems;
  final bool useGlassyCard;

  @override
  Widget build(BuildContext context) {
    return ActivityFeed<ActivityItem, ActivityType>(
      activities: activities,
      title: title,
      emptyText: emptyText,
      viewAllText: viewAllText,
      onViewAllPressed: onViewAllPressed,
      maxItems: maxItems,
      useGlassyCard: useGlassyCard,
      titleExtractor: (activity) => activity.title,
      descriptionExtractor: (activity) => activity.description,
      timestampExtractor: (activity) => activity.timestamp,
      typeExtractor: (activity) => activity.type,
      iconBuilder: _buildIconForType,
      colorBuilder: _buildColorForType,
    );
  }

  IconData _buildIconForType(ActivityType type) {
    switch (type) {
      case ActivityType.user:
        return Icons.person_add_outlined;
      case ActivityType.order:
        return Icons.shopping_cart_outlined;
      case ActivityType.system:
        return Icons.settings_outlined;
      case ActivityType.revenue:
        return Icons.attach_money_outlined;
    }
  }

  Color _buildColorForType(ActivityType type) {
    switch (type) {
      case ActivityType.user:
        return Colors.blue;
      case ActivityType.order:
        return Colors.green;
      case ActivityType.system:
        return Colors.orange;
      case ActivityType.revenue:
        return Colors.purple;
    }
  }
}

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

    return Scaffold(
      appBar: AppBar(
        title: Text('10n.activityLog'),
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        scrolledUnderElevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: _showFilterDialog,
            tooltip: 'l10n.filter',
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
                hintText: 'l10n.searchActivities',
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
                    label: Text(getActivityTypeName(context, _selectedFilter!)),
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
    return EmptyState(
      icon: Icons.timeline,
      title: 'l10n.noActivitiesFound',
      description: 'l10n.noActivitiesFoundDescription',
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
                color: getActivityColor(activity.type).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: getActivityColor(activity.type).withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Icon(
                getActivityIcon(activity.type),
                color: getActivityColor(activity.type),
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
                          color: getActivityColor(
                            activity.type,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          getActivityTypeName(context, activity.type),
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: getActivityColor(activity.type),
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
                        formatFullTimestamp(activity.timestamp),
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
    return AlertDialog(
      title: Text('10n.filterActivities'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.clear_all),
              title: Text('l10n.allActivities'),
              selected: selectedFilter == null,
              onTap: () {
                onFilterSelected(null);
                Navigator.of(context).pop();
              },
            ),
            const Divider(),
            ...HousekeepingActivityType.values.map((type) {
              return ListTile(
                leading: Icon(getActivityIcon(type)),
                title: Text(getActivityTypeName(context, type)),
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
          child: Text('l10n.commonCancel'),
        ),
      ],
    );
  }
}
