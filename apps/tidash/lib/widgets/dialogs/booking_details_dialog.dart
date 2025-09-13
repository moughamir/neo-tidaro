import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

/// Dialog for viewing booking details
class BookingDetailsDialog extends StatelessWidget {
  const BookingDetailsDialog({super.key, required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header
            Row(
              children: <Widget>[
                Icon(
                  Icons.event_note,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Booking Details',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Booking ID and Status
                    InfoCard(
                      title: 'Booking Information',
                      icon: Icons.info_outline,
                      children: <Widget>[
                        InfoRow(label: 'Booking ID', value: booking.id),
                        InfoRow(
                          label: 'Status',
                          value: _getStatusName(booking.status),
                        ),
                        InfoRow(
                          label: 'Created',
                          value: booking.createdAt != null
                              ? _formatDateTime(booking.createdAt!)
                              : 'N/A',
                        ),
                        InfoRow(
                          label: 'Scheduled',
                          value: _formatDateTime(booking.scheduledStartTime),
                        ),
                        if (booking.actualEndTime != null)
                          InfoRow(
                            label: 'Completed',
                            value: booking.actualEndTime != null
                                ? _formatDateTime(booking.actualEndTime!)
                                : 'N/A',
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Service Information
                    InfoCard(
                      title: 'Service Details',
                      icon: Icons.cleaning_services,
                      children: <Widget>[
                        InfoRow(label: 'Service ID', value: booking.serviceId),
                        InfoRow(
                          label: 'Total Price',
                          value: '\$${booking.totalAmount.toStringAsFixed(2)}',
                        ),
                        const InfoRow(label: 'Payment Status', value: 'TBD'),
                        if (booking.specialInstructions != null)
                          InfoRow(
                            label: 'Notes',
                            value: booking.specialInstructions!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Customer Information
                    InfoCard(
                      title: 'Customer Information',
                      icon: Icons.person,
                      children: <Widget>[
                        InfoRow(label: 'Customer ID', value: booking.clientId),
                        InfoRow(
                          label: 'Assigned Professional',
                          value: booking.professionalId,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Address Information
                    InfoCard(
                      title: 'Service Address',
                      icon: Icons.location_on,
                      children: <Widget>[
                        InfoRow(label: 'Street', value: booking.address.street),
                        InfoRow(
                          label: 'Apartment',
                          value: booking.address.apartment,
                        ),
                        InfoRow(label: 'City', value: booking.address.city),
                        InfoRow(label: 'State', value: booking.address.state),
                        InfoRow(
                          label: 'ZIP Code',
                          value: booking.address.zipCode,
                        ),
                        if (booking.address.instructions != null)
                          InfoRow(
                            label: 'Instructions',
                            value: booking.address.instructions!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: <Widget>[
                if (booking.status == BookingActivityStatus.pending ||
                    booking.status == BookingActivityStatus.confirmed)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _updateBookingStatus(
                        context,
                        BookingActivityStatus.cancelled,
                      ),
                      icon: const Icon(Icons.cancel),
                      label: Text(l10n.cancel),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                      ),
                    ),
                  ),
                if (booking.status == BookingActivityStatus.pending ||
                    booking.status == BookingActivityStatus.confirmed)
                  const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _updateBookingStatus(
                      context,
                      _getNextStatus(booking.status),
                    ),
                    icon: Icon(_getNextStatusIcon(booking.status)),
                    label: Text(_getNextStatusText(booking.status)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusName(BookingActivityStatus status) {
    switch (status) {
      case BookingActivityStatus.pending:
        return 'Pending';
      case BookingActivityStatus.confirmed:
        return 'Confirmed';
      case BookingActivityStatus.assigned:
        return 'Assigned';
      case BookingActivityStatus.inProgress:
        return 'In Progress';
      case BookingActivityStatus.completed:
        return 'Completed';
      case BookingActivityStatus.cancelled:
        return 'Cancelled';
      case BookingActivityStatus.rescheduled:
        return 'Rescheduled';
      case BookingActivityStatus.noShow:
        return 'No Show';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  BookingActivityStatus _getNextStatus(BookingActivityStatus currentStatus) {
    switch (currentStatus) {
      case BookingActivityStatus.pending:
        return BookingActivityStatus.confirmed;
      case BookingActivityStatus.confirmed:
        return BookingActivityStatus.assigned;
      case BookingActivityStatus.assigned:
        return BookingActivityStatus.inProgress;
      case BookingActivityStatus.inProgress:
        return BookingActivityStatus.completed;
      default:
        return currentStatus;
    }
  }

  IconData _getNextStatusIcon(BookingActivityStatus currentStatus) {
    switch (currentStatus) {
      case BookingActivityStatus.pending:
        return Icons.check_circle;
      case BookingActivityStatus.confirmed:
        return Icons.assignment_ind;
      case BookingActivityStatus.assigned:
        return Icons.play_arrow;
      case BookingActivityStatus.inProgress:
        return Icons.done_all;
      case BookingActivityStatus.noShow:
        return Icons.report_gmailerrorred;
      default:
        return Icons.info;
    }
  }

  String _getNextStatusText(BookingActivityStatus currentStatus) {
    switch (currentStatus) {
      case BookingActivityStatus.pending:
        return 'Confirm';
      case BookingActivityStatus.confirmed:
        return 'Assign Professional';
      case BookingActivityStatus.assigned:
        return 'Start Service';
      case BookingActivityStatus.inProgress:
        return 'Complete';
      case BookingActivityStatus.completed:
        return 'Completed';
      case BookingActivityStatus.cancelled:
        return 'Cancelled';
      case BookingActivityStatus.rescheduled:
        return 'Rescheduled';
      case BookingActivityStatus.noShow:
        return 'No Show';
    }
  }

  void _updateBookingStatus(
    BuildContext context,
    BookingActivityStatus newStatus,
  ) {
    StoreProvider.of<AppState>(context, listen: false).dispatch(
      UpdateBookingStatusAction(bookingId: booking.id, status: newStatus),
    );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Booking status updated to ${_getStatusName(newStatus)}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}

extension on Address {
  String get apartment => street;

  String get zipCode => postalCode;
}

extension on Booking {
  Address get address => Address(
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    type: AddressType.other,
    street: '',
    city: '',
    state: '',
    country: '',
    postalCode: '',
  );

  double get rating => overallRating;

  Review get review => Review(
    id: id,
    createdAt: createdAt,
    updatedAt: updatedAt,
    bookingId: bookingId,
    reviewerId: reviewerId,
    revieweeId: revieweeId,
    overallRating: overallRating,
  );
}
