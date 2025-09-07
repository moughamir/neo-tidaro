import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import '../l10n/localization_extensions.dart';

/// Card component for displaying booking information
class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    required this.onTap,
    required this.onStatusChanged,
  });

  final Booking booking;
  final VoidCallback onTap;
  final Function(BookingStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header row with booking ID and status
              Row(
                children: [
                  Expanded(
                    child: Text(
                      'Booking #${booking.id.substring(0, 8)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  _buildStatusChip(context, booking.status),
                ],
              ),
              const SizedBox(height: 12),

              // Customer and service info
              Row(
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Customer #${booking.customerId.substring(0, 8)}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Icon(
                    Icons.cleaning_services_outlined,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      // Display service category label instead of service id
                      booking.serviceCategory.label(context),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Date and time
              Row(
                children: [
                  Icon(
                    Icons.schedule_outlined,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    _formatDateTime(booking.scheduledDate),
                    style: theme.textTheme.bodyMedium,
                  ),
                  const Spacer(),
                  Text(
                    '\$${booking.price.toStringAsFixed(2)}',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),

              // Address
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${booking.address.street}, ${booking.address.city}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              // Action buttons for certain statuses
              if (_shouldShowActionButtons(booking.status)) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    if (booking.status == BookingStatus.pending) ...[
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () =>
                              onStatusChanged(BookingStatus.cancelled),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.red,
                            side: const BorderSide(color: Colors.red),
                          ),
                          child: const Text('Cancel'),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              onStatusChanged(BookingStatus.confirmed),
                          child: const Text('Confirm'),
                        ),
                      ),
                    ],
                    if (booking.status == BookingStatus.confirmed) ...[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              onStatusChanged(BookingStatus.inProgress),
                          child: const Text('Start'),
                        ),
                      ),
                    ],
                    if (booking.status == BookingStatus.inProgress) ...[
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () =>
                              onStatusChanged(BookingStatus.completed),
                          child: const Text('Complete'),
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, BookingStatus status) {
    final theme = Theme.of(context);
    final statusInfo = _getStatusInfo(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusInfo.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusInfo.color.withValues(alpha: 0.3)),
      ),
      child: Text(
        statusInfo.label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: statusInfo.color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  ({String label, Color color}) _getStatusInfo(BookingStatus status) {
    // Use humanized, localized labels via extensions to avoid hardcoded strings
    final ctx = WidgetsBinding.instance.focusManager.primaryFocus?.context;
    final label = ctx != null ? status.label(ctx) : status.name;
    switch (status) {
      case BookingStatus.pending:
        return (label: label, color: Colors.orange);
      case BookingStatus.confirmed:
        return (label: label, color: Colors.blue);
      case BookingStatus.assigned:
        return (label: label, color: Colors.teal);
      case BookingStatus.inProgress:
        return (label: label, color: Colors.purple);
      case BookingStatus.completed:
        return (label: label, color: Colors.green);
      case BookingStatus.cancelled:
        return (label: label, color: Colors.red);
      case BookingStatus.rescheduled:
        return (label: label, color: Colors.amber);
      case BookingStatus.noShow:
        return (label: label, color: Colors.grey);
    }
  }

  String _formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = dateTime.difference(now);

    if (difference.inDays == 0) {
      return 'Today ${_formatTime(dateTime)}';
    } else if (difference.inDays == 1) {
      return 'Tomorrow ${_formatTime(dateTime)}';
    } else if (difference.inDays == -1) {
      return 'Yesterday ${_formatTime(dateTime)}';
    } else if (difference.inDays > 0 && difference.inDays <= 7) {
      return '${_getDayName(dateTime.weekday)} ${_formatTime(dateTime)}';
    } else {
      return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${_formatTime(dateTime)}';
    }
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  String _getDayName(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  bool _shouldShowActionButtons(BookingStatus status) {
    return status == BookingStatus.pending ||
        status == BookingStatus.confirmed ||
        status == BookingStatus.assigned ||
        status == BookingStatus.inProgress;
  }
}
