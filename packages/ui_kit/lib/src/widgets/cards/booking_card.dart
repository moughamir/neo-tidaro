import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

import 'package:ui_kit/src/widgets/cards/appointment_card.dart';
import 'package:ui_kit/src/widgets/utils/get_status_info.dart';
import 'package:ui_kit/src/widgets/utils/should_show_action_buttons.dart';
import 'package:ui_kit/src/widgets/utils/time_formatting.dart';

/// Card component for displaying booking information
/// Now implemented using the generic AppointmentCard component
class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    required this.onTap,
    required this.onStatusChanged,
  });

  final Booking booking;
  final VoidCallback onTap;
  final Function(BookingActivityStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return AppointmentCard<Booking, BookingActivityStatus>(
      appointment: booking,
      id: booking.id,
      status: booking.status,
      price: booking.totalAmount,
      scheduledDate: booking.scheduledStartTime,
      customerId: booking.clientId,
      serviceName: booking.serviceId,
      // No direct address property in this model, may need refactoring
      address: (street: booking.addressId, city: booking.addressId),
      onTap: onTap,
      onStatusChanged: onStatusChanged,
      getStatusInfo: getStatusInfo,
      formatDateTime: formatFullTimestamp,
      shouldShowActionButtons: shouldShowActionButtons,
      buildActionButtons: _buildActionButtons,
    );
  }

  Widget _buildActionButtons(
    BuildContext context,
    BookingActivityStatus status,
  ) {
    return Row(
      children: [
        if (status == BookingActivityStatus.pending) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: () => onStatusChanged(BookingActivityStatus.cancelled),
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
              onPressed: () => onStatusChanged(BookingActivityStatus.confirmed),
              child: const Text('Confirm'),
            ),
          ),
        ],
        if (status == BookingActivityStatus.confirmed) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: () =>
                  onStatusChanged(BookingActivityStatus.inProgress),
              child: const Text('Start'),
            ),
          ),
        ],
        if (status == BookingActivityStatus.inProgress) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: () => onStatusChanged(BookingActivityStatus.completed),
              child: const Text('Complete'),
            ),
          ),
        ],
      ],
    );
  }
}
