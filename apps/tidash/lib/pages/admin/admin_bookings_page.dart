import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

/// Minimal admin bookings oversight page
/// - Lists bookings
/// - Allows status updates via UpdateBookingAction({ status })
class AdminBookingsPage extends StatelessWidget {
  const AdminBookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _Vm>(
      converter: (store) => _Vm.fromStore(store),
      onInit: (store) => store.dispatch(const LoadBookingsAction()),
      builder: (context, vm) {
        final theme = Theme.of(context);
        return Scaffold(
          appBar: AppBar(title: const Text('Bookings Oversight')),
          body: vm.isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: vm.bookings.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final b = vm.bookings[index];
                    return Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                        side: BorderSide(
                          color: theme.colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Booking #${b.id.substring(0, 6)}',
                                    style: theme.textTheme.titleSmall?.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Client: ${b.clientId} · Pro: ${b.professionalId}',
                                    style: theme.textTheme.bodySmall,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'When: ${b.scheduledStartTime.toLocal()} — ${b.scheduledEndTime.toLocal()}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            _StatusDropdown(
                              value: b.status,
                              onChanged: (newStatus) {
                                if (newStatus == null) return;
                                vm.updateStatus(b.id, newStatus);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        );
      },
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown({required this.value, required this.onChanged});

  final BookingActivityStatus value;
  final ValueChanged<BookingActivityStatus?> onChanged;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<BookingActivityStatus>(
      value: value,
      onChanged: onChanged,
      items: BookingActivityStatus.values.map((s) {
        final label = s.toString().split('.').last;
        return DropdownMenuItem(
          value: s,
          child: Text(label),
        );
      }).toList(),
    );
  }
}

class _Vm {
  _Vm({
    required this.isLoading,
    required this.bookings,
    required this.updateStatus,
  });

  final bool isLoading;
  final List<Booking> bookings;
  final void Function(String bookingId, BookingActivityStatus status) updateStatus;

  static _Vm fromStore(Store<AppState> store) {
    final s = store.state.bookingState;
    final list = s.data.fold(() => <Booking>[], (b) => b);
    return _Vm(
      isLoading: s.isLoading,
      bookings: list,
      updateStatus: (id, status) => store.dispatch(
        UpdateBookingAction(bookingId: id, updates: {'status': status}),
      ),
    );
  }
}
