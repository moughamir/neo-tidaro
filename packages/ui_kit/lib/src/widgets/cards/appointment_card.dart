import 'package:flutter/material.dart';
import 'package:ui_kit/src/widgets/card.dart';
import 'package:ui_kit/src/widgets/utils/time_formatting.dart';

/// A generic card component for displaying appointment information
/// Can be used for any type of appointment, booking, or scheduled event
class AppointmentCard<T, S> extends StatelessWidget {
  const AppointmentCard({
    super.key,
    required this.appointment,
    required this.id,
    required this.status,
    required this.price,
    required this.scheduledDate,
    this.customerId,
    this.customerName,
    this.serviceCategory,
    this.serviceName,
    this.address,
    this.onTap,
    this.onStatusChanged,
    this.getStatusInfo,
    this.formatDateTime,
    this.shouldShowActionButtons,
    this.buildActionButtons,
  });

  /// The appointment object
  final T appointment;

  /// The ID of the appointment (will be shortened for display)
  final String id;

  /// The status of the appointment (enum or string)
  final S status;

  /// The price of the appointment
  final double price;

  /// The scheduled date and time of the appointment
  final DateTime scheduledDate;

  /// Optional customer ID
  final String? customerId;

  /// Optional customer name
  final String? customerName;

  /// Optional service category
  final String? serviceCategory;

  /// Optional service name
  final String? serviceName;

  /// Optional address information
  final ({String? street, String? city})? address;

  /// Callback for when the card is tapped
  final VoidCallback? onTap;

  /// Callback for when the status is changed
  final Function(S)? onStatusChanged;

  /// Function to get status label and color
  final ({String label, Color color})? Function(BuildContext context, S status)?
      getStatusInfo;

  /// Function to format date and time
  final String Function(DateTime dateTime)? formatDateTime;

  /// Function to determine if action buttons should be shown
  final bool Function(S status)? shouldShowActionButtons;

  /// Function to build custom action buttons
  final Widget Function(BuildContext context, S status)? buildActionButtons;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return KuiCard(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 0,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with ID and status
            Row(
              children: [
                Expanded(
                  child: Text(
                    id.length > 8 ? 'ID #${id.substring(0, 8)}' : 'ID #$id',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                if (getStatusInfo != null) _buildStatusChip(context, status),
              ],
            ),
            const SizedBox(height: 12),

            // Customer info
            if (customerId != null || customerName != null) ...[
              _buildInfoRow(
                context,
                icon: Icons.person_outline,
                text: customerName ??
                    (customerId != null && customerId!.length > 8
                        ? 'Customer #${customerId!.substring(0, 8)}'
                        : 'Customer #$customerId'),
              ),
              const SizedBox(height: 8),
            ],

            // Service info
            if (serviceCategory != null || serviceName != null) ...[
              _buildInfoRow(
                context,
                icon: Icons.category_outlined,
                text: serviceName ?? serviceCategory ?? 'Service',
              ),
              const SizedBox(height: 8),
            ],

            // Date and time
            _buildInfoRow(
              context,
              icon: Icons.schedule_outlined,
              text: formatDateTime?.call(scheduledDate) ??
                  formatFullTimestamp(scheduledDate),
              trailing: Text(
                '\${price.toStringAsFixed(2)}',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.primary,
                ),
              ),
            ),

            // Address
            if (address != null &&
                (address!.street != null || address!.city != null)) ...[
              const SizedBox(height: 8),
              _buildInfoRow(
                context,
                icon: Icons.location_on_outlined,
                text: [address!.street, address!.city]
                    .where((e) => e != null)
                    .join(', '),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withOpacity(0.7),
                ),
              ),
            ],

            // Action buttons
            if (shouldShowActionButtons?.call(status) == true &&
                buildActionButtons != null) ...[
              const SizedBox(height: 12),
              buildActionButtons!(context, status),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
      {
    required IconData icon,
    required String text,
    TextStyle? style,
    Widget? trailing,
  }) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: style ?? theme.textTheme.bodyMedium,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        if (trailing != null) trailing,
      ],
    );
  }

  // TODO(refactor): Extract to a shared widget/helper.
  Widget _buildStatusChip(BuildContext context, S status) {
    final theme = Theme.of(context);
    final statusInfo =
        getStatusInfo?.call(context, status) ??
        (label: status.toString(), color: Colors.grey);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusInfo.color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusInfo.color.withOpacity(0.3)),
      ),
      child: Text(
        statusInfo.label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: statusInfo.color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }
}
