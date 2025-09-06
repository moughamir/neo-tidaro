import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

/// Activity feed component for housekeeping operations
class HousekeepingActivityFeed extends StatelessWidget {
  const HousekeepingActivityFeed({super.key, required this.activities});

  final List<HousekeepingActivity> activities;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    if (activities.isEmpty) {
      return _buildEmptyState(context);
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Icon(
                  Icons.timeline,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'Recent Activity',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(20),
            itemCount: activities.length > 10 ? 10 : activities.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final activity = activities[index];
              return _buildActivityItem(context, activity);
            },
          ),
          if (activities.length > 10)
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: TextButton(
                onPressed: () {
                  // TODO: Navigate to full activity log
                },
                child: Text('View All Activities'),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Icon(
            Icons.timeline,
            size: 48,
            color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 16),
          Text(
            'No Recent Activity',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Activity will appear here as your team manages bookings and services.',
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem(
    BuildContext context,
    HousekeepingActivity activity,
  ) {
    final ThemeData theme = Theme.of(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: _getActivityColor(activity.type).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: _getActivityColor(activity.type).withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Icon(
            _getActivityIcon(activity.type),
            color: _getActivityColor(activity.type),
            size: 18,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activity.title,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: theme.colorScheme.onSurface,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                activity.description,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _formatTimestamp(activity.timestamp),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Color _getActivityColor(HousekeepingActivityType type) {
    switch (type) {
      case HousekeepingActivityType.bookingCreated:
        return Colors.blue;
      case HousekeepingActivityType.bookingConfirmed:
        return Colors.green;
      case HousekeepingActivityType.bookingCompleted:
        return Colors.teal;
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

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      final weeks = (difference.inDays / 7).floor();
      return '${weeks}w ago';
    }
  }
}
