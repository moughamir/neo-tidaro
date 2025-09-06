import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:languist/languist.dart';

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
                    _buildInfoCard(
                      theme,
                      'Booking Information',
                      Icons.info_outline,
                      <Widget>[
                        _buildInfoRow('Booking ID', booking.id),
                        _buildInfoRow('Status', _getStatusName(booking.status)),
                        _buildInfoRow(
                          'Created',
                          _formatDateTime(booking.createdAt),
                        ),
                        _buildInfoRow(
                          'Scheduled',
                          _formatDateTime(booking.scheduledDate),
                        ),
                        if (booking.completedAt != null)
                          _buildInfoRow(
                            'Completed',
                            _formatDateTime(booking.completedAt!),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Service Information
                    _buildInfoCard(
                      theme,
                      'Service Details',
                      Icons.cleaning_services,
                      <Widget>[
                        _buildInfoRow('Service ID', booking.serviceId),
                        _buildInfoRow(
                          'Total Price',
                          '\$${booking.totalPrice.toStringAsFixed(2)}',
                        ),
                        _buildInfoRow(
                          'Payment Status',
                          _getPaymentStatusName(booking.paymentStatus),
                        ),
                        if (booking.notes != null)
                          _buildInfoRow('Notes', booking.notes!),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Customer Information
                    _buildInfoCard(
                      theme,
                      'Customer Information',
                      Icons.person,
                      <Widget>[
                        _buildInfoRow('Customer ID', booking.customerId),
                        if (booking.cleanerId != null)
                          _buildInfoRow('Assigned Cleaner', booking.cleanerId!),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Address Information
                    _buildInfoCard(
                      theme,
                      'Service Address',
                      Icons.location_on,
                      <Widget>[
                        _buildInfoRow('Street', booking.address.street),
                        if (booking.address.apartment != null)
                          _buildInfoRow(
                            'Apartment',
                            booking.address.apartment!,
                          ),
                        _buildInfoRow('City', booking.address.city),
                        _buildInfoRow('State', booking.address.state),
                        _buildInfoRow('ZIP Code', booking.address.zipCode),
                        if (booking.address.instructions != null)
                          _buildInfoRow(
                            'Instructions',
                            booking.address.instructions!,
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Rating and Review (if completed)
                    if (booking.status == BookingStatus.completed)
                      _buildInfoCard(theme, 'Feedback', Icons.star, <Widget>[
                        if (booking.rating != null)
                          _buildRatingRow(booking.rating!),
                        if (booking.review != null)
                          _buildInfoRow('Review', booking.review!),
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

  Widget _buildInfoCard(
    ThemeData theme,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
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
    }
  }

  String _getPaymentStatusName(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.pending:
        return 'Pending';
      case PaymentStatus.paid:
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
