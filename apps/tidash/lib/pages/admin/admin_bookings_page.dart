import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import 'admin_bookings_view_model.dart';

class AdminBookingsPage extends StatelessWidget {
  const AdminBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AdminBookingsViewModel>(
      converter: (store) => AdminBookingsViewModel.fromStore(store),
      onInit: (store) => store.dispatch(const LoadBookingsAction()),
      builder: (context, vm) {
        return PageScaffold(
          header: const Header(title: 'Bookings Oversight'),
          body: vm.isLoading
              ? const LoadingIndicator(message: 'Loading bookings...')
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.bookings.length,
                  itemBuilder: (context, index) {
                    final booking = vm.bookings[index];
                    return BookingCard(
                      booking: booking,
                      onStatusChanged: (status) {
                        vm.updateStatus(booking.id, status);
                      },
                    );
                  },
                ),
        );
      },
    );
  }
}

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    required this.onStatusChanged,
  });

  final Booking booking;
  final ValueChanged<BookingActivityStatus> onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Booking #${booking.id.substring(0, 6)}',
                  style: theme.textTheme.titleMedium,
                ),
                Select<BookingActivityStatus>(
                  value: booking.status,
                  onChanged: (value) {
                    if (value != null) {
                      onStatusChanged(value);
                    }
                  },
                  items: BookingActivityStatus.values
                      .map((status) => SelectOption(
                            value: status,
                            label: status.name,
                          ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Client: ${booking.clientId.substring(0, 6)}...',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 4),
            Text(
              'Professional: ${booking.professionalId.substring(0, 6)}...',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 8),
            Text(
              'Scheduled: ${booking.scheduledStartTime.toLocal()} - ${booking.scheduledEndTime.toLocal()}',
              style: theme.textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
