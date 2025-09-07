import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

/// Header component for staff page with stats and filters
class StaffHeader extends StatelessWidget {
  const StaffHeader({
    super.key,
    required this.totalStaff,
    required this.availableStaff,
    required this.busyStaff,
    required this.onFilterChanged,
    this.currentFilter,
  });

  final int totalStaff;
  final int availableStaff;
  final int busyStaff;
  final Function(CleanerStatus?) onFilterChanged;
  final CleanerStatus? currentFilter;

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
                'Total Staff',
                totalStaff.toString(),
                Icons.people,
                theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Available',
                availableStaff.toString(),
                Icons.check_circle,
                Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                context,
                'Busy',
                busyStaff.toString(),
                Icons.schedule,
                Colors.orange,
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
                'Available',
                CleanerStatus.available,
                currentFilter == CleanerStatus.available,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'On Job',
                CleanerStatus.onJob,
                currentFilter == CleanerStatus.onJob,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'Offline',
                CleanerStatus.offline,
                currentFilter == CleanerStatus.offline,
              ),
              const SizedBox(width: 8),
              _buildFilterChip(
                context,
                'On Break',
                CleanerStatus.onBreak,
                currentFilter == CleanerStatus.onBreak,
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
    CleanerStatus? status,
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
