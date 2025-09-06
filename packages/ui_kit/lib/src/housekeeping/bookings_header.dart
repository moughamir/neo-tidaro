import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

/// Header component for bookings page with stats and filters
class BookingsHeader extends StatelessWidget {
  const BookingsHeader({
    super.key,
    required this.totalBookings,
    required this.activeBookings,
    required this.completedBookings,
    required this.onFilterChanged,
    this.currentFilter,
  });

  final int totalBookings;
  final int activeBookings;
  final int completedBookings;
  final Function(BookingStatus?) onFilterChanged;
  final BookingStatus? currentFilter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Stats cards
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                context,
                'Total',
                totalBookings.toString(),
                Icons.calendar_today,
                theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Active',
                activeBookings.toString(),
                Icons.schedule,
                Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Completed',
                completedBookings.toString(),
                Icons.check_circle,
                Colors.green,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Filter chips
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              _buildFilterChip(context, 'All', null, currentFilter == null),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'Pending',
                BookingStatus.pending,
                currentFilter == BookingStatus.pending,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'Confirmed',
                BookingStatus.confirmed,
                currentFilter == BookingStatus.confirmed,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'In Progress',
                BookingStatus.inProgress,
                currentFilter == BookingStatus.inProgress,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'Completed',
                BookingStatus.completed,
                currentFilter == BookingStatus.completed,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'Cancelled',
                BookingStatus.cancelled,
                currentFilter == BookingStatus.cancelled,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: color),
              const Spacer(),
              Text(
                value,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    BookingStatus? status,
    bool isSelected,
  ) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onFilterChanged(status),
      backgroundColor: theme.colorScheme.surface,
      selectedColor: theme.colorScheme.primary.withValues(alpha: 0.1),
      checkmarkColor: theme.colorScheme.primary,
      labelStyle: TextStyle(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.onSurface,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
      ),
      side: BorderSide(
        color: isSelected
            ? theme.colorScheme.primary
            : theme.colorScheme.outline.withValues(alpha: 0.2),
      ),
    );
  }
}
