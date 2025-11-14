import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import '../../widgets/dialogs/booking_details_dialog.dart';
import '../../widgets/dialogs/booking_filter_dialog.dart';
import '../../widgets/dialogs/create_booking_dialog.dart';
import 'bookings_view_model.dart';

class BookingsPage extends StatelessWidget {
  const BookingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, BookingsViewModel>(
      converter: (store) => BookingsViewModel.fromStore(store),
      onInit: (store) => store.dispatch(const LoadBookingsAction()),
      builder: (context, vm) {
        return PageScaffold(
          header: Header(
            title: 'Bookings',
            actions: [
              Button(
                label: 'Create Booking',
                icon: Icons.add,
                onPressed: () => _showCreateBookingDialog(context),
              ),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterDialog(context, vm),
                tooltip: 'Filter',
              ),
            ],
          ),
          body: vm.isLoading && vm.bookings.isEmpty
              ? const LoadingIndicator(message: 'Loading bookings...')
              : vm.bookings.isEmpty
                  ? EmptyState(
                      icon: Icons.calendar_today_outlined,
                      title: 'No Bookings',
                      description: 'There are no bookings to display.',
                      action: Button(
                        label: 'Create Booking',
                        icon: Icons.add,
                        onPressed: () => _showCreateBookingDialog(context),
                      ),
                    )
                  : RefreshIndicator(
                      onRefresh: () async => vm.onRefresh(),
                      child: _BookingList(vm: vm),
                    ),
        );
      },
    );
  }

  void _showCreateBookingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (context) => const CreateBookingDialog(),
    );
  }

  void _showFilterDialog(BuildContext context, BookingsViewModel vm) {
    showDialog<void>(
      context: context,
      builder: (context) => BookingFilterDialog(
        currentFilter: vm.currentFilter,
        onFilterChanged: vm.onFilterChanged,
      ),
    );
  }
}

class _BookingList extends StatelessWidget {
  const _BookingList({required this.vm});

  final BookingsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: BookingsHeader(
              totalBookings: vm.bookings.length,
              activeBookings: vm.activeBookings,
              completedBookings: vm.completedBookings,
              onFilterChanged: vm.onFilterChanged,
              currentFilter: vm.currentFilter,
            ),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final booking = vm.bookings[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 4.0,
                ),
                child: BookingCard(
                  booking: booking,
                  onTap: () => _navigateToBookingDetails(context, booking),
                  onStatusChanged: (status) =>
                      vm.onUpdateBookingStatus(booking.id, status),
                ),
              );
            },
            childCount: vm.bookings.length,
          ),
        ),
      ],
    );
  }

  void _navigateToBookingDetails(BuildContext context, Booking booking) {
    showDialog<void>(
      context: context,
      builder: (context) => BookingDetailsDialog(booking: booking),
    );
  }
}
