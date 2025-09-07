import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:languist/languist.dart';
import 'package:ui_kit/ui_kit.dart' as ui;

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
                    ui.InfoCard(
                      title: 'Booking Information',
                      icon: Icons.info_outline,
                      children: <Widget>[
                        ui.InfoRow(label: 'Booking ID', value: booking.id),
                        ui.InfoRow(label: 'Status', value: _getStatusName(booking.status)),
                        ui.InfoRow(label: 'Created', value: _formatDateTime(booking.createdAt)),
                        ui.InfoRow(label: 'Scheduled', value: _formatDateTime(booking.scheduledDate)),
                        if (booking.completedAt != null)
                          ui.InfoRow(label: 'Completed', value: _formatDateTime(booking.completedAt!)),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Service Information
                    ui.InfoCard(
                      title: 'Service Details',
                      icon: Icons.cleaning_services,
                      children: <Widget>[
                        ui.InfoRow(label: 'Service ID', value: booking.serviceId),
                        ui.InfoRow(label: 'Total Price', value: '\$${booking.totalPrice.toStringAsFixed(2)}'),
                        ui.InfoRow(label: 'Payment Status', value: _getPaymentStatusName(booking.paymentStatus)),
                        if (booking.notes != null) ui.InfoRow(label: 'Notes', value: booking.notes!),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Customer Information
                    ui.InfoCard(
                      title: 'Customer Information',
                      icon: Icons.person,
                      children: <Widget>[
                        ui.InfoRow(label: 'Customer ID', value: booking.customerId),
                        if (booking.cleanerId != null)
                          ui.InfoRow(label: 'Assigned Cleaner', value: booking.cleanerId!),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Address Information
                    ui.InfoCard(
                      title: 'Service Address',
                      icon: Icons.location_on,
                      children: <Widget>[
                        ui.InfoRow(label: 'Street', value: booking.address.street),
                        if (booking.address.apartment != null)
                          ui.InfoRow(label: 'Apartment', value: booking.address.apartment!),
                        ui.InfoRow(label: 'City', value: booking.address.city),
                        ui.InfoRow(label: 'State', value: booking.address.state),
                        ui.InfoRow(label: 'ZIP Code', value: booking.address.zipCode),
                        if (booking.address.instructions != null)
                          ui.InfoRow(label: 'Instructions', value: booking.address.instructions!),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Rating and Review (if completed)
                    if (booking.status == BookingStatus.completed)
                      ui.InfoCard(title: 'Feedback', icon: Icons.star, children: <Widget>[
                        if (booking.rating != null) _buildRatingRow(booking.rating!),
                        if (booking.review != null) ui.InfoRow(label: 'Review', value: booking.review!),
                      ]),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: <Widget>[
                if (booking.status == BookingStatus.pending ||
                    booking.status == BookingStatus.confirmed)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _updateBookingStatus(
                        context,
                        BookingStatus.cancelled,
                      ),
                      icon: const Icon(Icons.cancel),
                      label: Text(l10n.cancel),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                      ),
                    ),
                  ),
                if (booking.status == BookingStatus.pending ||
                    booking.status == BookingStatus.confirmed)
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

  

  Widget _buildRatingRow(int rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 120,
            child: Text(
              'Rating:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: List<Widget>.generate(5, (int index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          const SizedBox(width: 8),
          Text('($rating/5)'),
        ],
      ),
    );
  }

  String _getStatusName(BookingStatus status) {
    switch (status) {
      case BookingStatus.pending:
        return 'Pending';
      case BookingStatus.confirmed:
        return 'Confirmed';
      case BookingStatus.assigned:
        return 'Assigned';
      case BookingStatus.inProgress:
        return 'In Progress';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.rescheduled:
        return 'Rescheduled';
      case BookingStatus.noShow:
        return 'No Show';
    }
  }

  String _getPaymentStatusName(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.processing:
        return 'Processing';
      case PaymentStatus.completed:
        return 'Paid';
      case PaymentStatus.failed:
        return 'Failed';
      case PaymentStatus.refunded:
        return 'Refunded';
    }
  }

  String _formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year} ${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}';
  }

  BookingStatus _getNextStatus(BookingStatus currentStatus) {
    switch (currentStatus) {
      case BookingStatus.pending:
        return BookingStatus.confirmed;
      case BookingStatus.confirmed:
        return BookingStatus.assigned;
      case BookingStatus.assigned:
        return BookingStatus.inProgress;
      case BookingStatus.inProgress:
        return BookingStatus.completed;
      default:
        return currentStatus;
    }
  }

  IconData _getNextStatusIcon(BookingStatus currentStatus) {
    switch (currentStatus) {
      case BookingStatus.pending:
        return Icons.check_circle;
      case BookingStatus.confirmed:
        return Icons.assignment_ind;
      case BookingStatus.assigned:
        return Icons.play_arrow;
      case BookingStatus.inProgress:
        return Icons.done_all;
      case BookingStatus.noShow:
        return Icons.report_gmailerrorred;
      default:
        return Icons.info;
    }
  }

  String _getNextStatusText(BookingStatus currentStatus) {
    switch (currentStatus) {
      case BookingStatus.pending:
        return 'Confirm';
      case BookingStatus.confirmed:
        return 'Assign Cleaner';
      case BookingStatus.assigned:
        return 'Start Service';
      case BookingStatus.inProgress:
        return 'Complete';
      case BookingStatus.completed:
        return 'Completed';
      case BookingStatus.cancelled:
        return 'Cancelled';
      case BookingStatus.rescheduled:
        return 'Rescheduled';
      case BookingStatus.noShow:
        return 'No Show';
    }
  }

  void _updateBookingStatus(BuildContext context, BookingStatus newStatus) {
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
