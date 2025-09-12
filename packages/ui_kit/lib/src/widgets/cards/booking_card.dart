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
  final Function(BookingStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return AppointmentCard<Booking, BookingStatus>(
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
      getStatusInfo: (context, status) => getStatusInfo(status),
      formatDateTime: formatFullTimestamp,
      shouldShowActionButtons: shouldShowActionButtons,
      buildActionButtons: _buildActionButtons,
    );
  }

  Widget _buildActionButtons(BuildContext context, BookingStatus status) {
    return Row(
      children: [
        if (status == BookingStatus.pending) ...[
          Expanded(
            child: OutlinedButton(
              onPressed: () => onStatusChanged(BookingStatus.cancelled),
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
              onPressed: () => onStatusChanged(BookingStatus.confirmed),
              child: const Text('Confirm'),
            ),
          ),
        ],
        if (status == BookingStatus.confirmed) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: () => onStatusChanged(BookingStatus.inProgress),
              child: const Text('Start'),
            ),
          ),
        ],
        if (status == BookingStatus.inProgress) ...[
          Expanded(
            child: ElevatedButton(
              onPressed: () => onStatusChanged(BookingStatus.completed),
              child: const Text('Complete'),
            ),
          ),
        ],
      ],
    );
  }
}
