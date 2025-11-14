import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/widgets/utils/time_formatting.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    this.onRefresh,
    this.isRefreshing = false,
    this.lastUpdated,
  });

  final VoidCallback? onRefresh;
  final bool isRefreshing;
  final DateTime? lastUpdated;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'l10n.dashboard',
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${getGreeting()}! Here\'s your overview.',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                if (lastUpdated != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(
                    'Last updated: ${formatLastUpdated(lastUpdated!)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onRefresh != null)
            IconButton.filled(
              onPressed: isRefreshing ? null : onRefresh,
              icon: isRefreshing
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : const Icon(Icons.refresh),
              tooltip: 'l10n.refresh',
            ),
        ],
      ),
    );
  }
}

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
  final Function(BookingActivityStatus?) onFilterChanged;
  final BookingActivityStatus? currentFilter;

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
              child: _StatCard(
                label: 'Total',
                value: totalBookings.toString(),
                icon: Icons.calendar_today,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Active',
                value: activeBookings.toString(),
                icon: Icons.schedule,
                color: Colors.orange,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Completed',
                value: completedBookings.toString(),
                icon: Icons.check_circle,
                color: Colors.green,
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
              _StatusFilterChip<BookingActivityStatus>(
                label: 'All',
                onSelected: onFilterChanged,
                isSelected: currentFilter == null,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<BookingActivityStatus>(
                label: 'Pending',
                status: BookingActivityStatus.pending,
                onSelected: onFilterChanged,
                isSelected: currentFilter == BookingActivityStatus.pending,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<BookingActivityStatus>(
                label: 'Confirmed',
                status: BookingActivityStatus.confirmed,
                onSelected: onFilterChanged,
                isSelected: currentFilter == BookingActivityStatus.confirmed,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<BookingActivityStatus>(
                label: 'In Progress',
                status: BookingActivityStatus.inProgress,
                onSelected: onFilterChanged,
                isSelected: currentFilter == BookingActivityStatus.inProgress,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<BookingActivityStatus>(
                label: 'Completed',
                status: BookingActivityStatus.completed,
                onSelected: onFilterChanged,
                isSelected: currentFilter == BookingActivityStatus.completed,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<BookingActivityStatus>(
                label: 'Cancelled',
                status: BookingActivityStatus.cancelled,
                onSelected: onFilterChanged,
                isSelected: currentFilter == BookingActivityStatus.cancelled,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Header component for the housekeeping dashboard
class HousekeepingDashboardHeader extends StatelessWidget {
  const HousekeepingDashboardHeader({
    super.key,
    required this.onRefresh,
    this.isRefreshing = false,
    this.lastUpdated,
  });

  final VoidCallback onRefresh;
  final bool isRefreshing;
  final DateTime? lastUpdated;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 60, 24, 32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.colorScheme.primary.withValues(alpha: 0.1),
            theme.colorScheme.secondary.withValues(alpha: 0.05),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      getGreeting(),
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'TiDaro Housekeeping Dashboard',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                    if (lastUpdated != null) ...[
                      const SizedBox(height: 4),
                      Text(
                        'Last updated: ${formatTimestampShort(lastUpdated!)}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: isRefreshing ? null : onRefresh,
                    borderRadius: BorderRadius.circular(12),
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: isRefreshing
                          ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  theme.colorScheme.primary,
                                ),
                              ),
                            )
                          : Icon(
                              Icons.refresh,
                              color: theme.colorScheme.primary,
                              size: 20,
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Quick stats row
          Row(
            children: [
              _buildQuickStat(
                context,
                icon: Icons.cleaning_services_outlined,
                label: 'Services',
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 16),
              _buildQuickStat(
                context,
                icon: Icons.people_outline,
                label: 'Staff',
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 16),
              _buildQuickStat(
                context,
                icon: Icons.calendar_today_outlined,
                label: 'Bookings',
                color: theme.colorScheme.tertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickStat(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    final ThemeData theme = Theme.of(context);

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.2), width: 1),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 18),
            const SizedBox(width: 8),
            Text(
              label,
              style: theme.textTheme.bodySmall?.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
  final Function(ProfessionalActivityStatus?) onFilterChanged;
  final ProfessionalActivityStatus? currentFilter;

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
              child: _StatCard(
                label: 'Total Staff',
                value: totalStaff.toString(),
                icon: Icons.people,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Available',
                value: availableStaff.toString(),
                icon: Icons.check_circle,
                color: Colors.green,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                label: 'Busy',
                value: busyStaff.toString(),
                icon: Icons.schedule,
                color: Colors.orange,
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
              _StatusFilterChip<ProfessionalActivityStatus>(
                label: 'All',
                onSelected: onFilterChanged,
                isSelected: currentFilter == null,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<ProfessionalActivityStatus>(
                label: 'Available',
                status: ProfessionalActivityStatus.available,
                onSelected: onFilterChanged,
                isSelected:
                    currentFilter == ProfessionalActivityStatus.available,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<ProfessionalActivityStatus>(
                label: 'On Job',
                status: ProfessionalActivityStatus.onJob,
                onSelected: onFilterChanged,
                isSelected: currentFilter == ProfessionalActivityStatus.onJob,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<ProfessionalActivityStatus>(
                label: 'Offline',
                status: ProfessionalActivityStatus.offline,
                onSelected: onFilterChanged,
                isSelected: currentFilter == ProfessionalActivityStatus.offline,
              ),
              const SizedBox(width: 8),
              _StatusFilterChip<ProfessionalActivityStatus>(
                label: 'On Break',
                status: ProfessionalActivityStatus.onBreak,
                onSelected: onFilterChanged,
                isSelected: currentFilter == ProfessionalActivityStatus.onBreak,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
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
}

class _StatusFilterChip<T> extends StatelessWidget {
  const _StatusFilterChip({
    required this.label,
    required this.onSelected,
    required this.isSelected,
    this.status,
  });

  final String label;
  final T? status;
  final Function(T?) onSelected;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(status),
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
