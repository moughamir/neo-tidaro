import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:languist/languist.dart';

/// Bookings management page for TiDash
class BookingsPage extends StatefulWidget {
  const BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  @override
  void initState() {
    super.initState();
    // Load bookings when page initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final Store<AppState> store = StoreProvider.of<AppState>(
        context,
        listen: false,
      );
      store.dispatch(const LoadBookingsAction());
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surface,
      appBar: AppBar(
        title: Text(l10n.bookings),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateBookingDialog(context),
            tooltip: l10n.add,
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
            tooltip: l10n.filter,
          ),
        ],
      ),
      body: StoreConnector<AppState, BookingsViewModel>(
        converter: (Store<AppState> store) =>
            BookingsViewModel.fromStore(store),
        builder: (BuildContext context, BookingsViewModel viewModel) {
          if (viewModel.isLoading && viewModel.bookings.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.bookings.isEmpty) {
            return _buildEmptyState(context, l10n);
          }

          return RefreshIndicator(
            onRefresh: () async {
              viewModel.onRefresh();
            },
            child: CustomScrollView(
              slivers: <Widget>[
                // Filters and stats header
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BookingsHeader(
                      totalBookings: viewModel.bookings.length,
                      activeBookings: viewModel.activeBookings,
                      completedBookings: viewModel.completedBookings,
                      onFilterChanged: viewModel.onFilterChanged,
                      currentFilter: viewModel.currentFilter,
                    ),
                  ),
                ),
                // Bookings list
                SliverList(
                  delegate: SliverChildBuilderDelegate((
                    BuildContext context,
                    int index,
                  ) {
                    final Booking booking = viewModel.bookings[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 4.0,
                      ),
                      child: BookingCard(
                        booking: booking,
                        onTap: () =>
                            _navigateToBookingDetails(context, booking),
                        onStatusChanged: (BookingStatus status) =>
                            viewModel.onUpdateBookingStatus(booking.id, status),
                      ),
                    );
                  }, childCount: viewModel.bookings.length),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, IntlLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.calendar_today_outlined,
            size: 64,
            color: Theme.of(context).colorScheme.outline,
          ),
          const SizedBox(height: 16),
          Text(
            l10n.noBookings,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.noBookingsDescription,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => _showCreateBookingDialog(context),
            icon: const Icon(Icons.add),
            label: Text(l10n.createBooking),
          ),
        ],
      ),
    );
  }

  void _showCreateBookingDialog(BuildContext context) {
    // TODO: Implement create booking dialog
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(Languist.of(context).comingSoon)));
  }

  void _showFilterDialog(BuildContext context) {
    // TODO: Implement filter dialog
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(Languist.of(context).comingSoon)));
  }

  void _navigateToBookingDetails(BuildContext context, Booking booking) {
    // TODO: Navigate to booking details page
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${Languist.of(context).viewDetails}: ${booking.id}'),
      ),
    );
  }
}

/// ViewModel for bookings page
class BookingsViewModel {
  const BookingsViewModel({
    required this.bookings,
    required this.isLoading,
    required this.error,
    required this.currentFilter,
    required this.onRefresh,
    required this.onFilterChanged,
    required this.onUpdateBookingStatus,
  });

  final List<Booking> bookings;
  final bool isLoading;
  final String? error;
  final BookingStatus? currentFilter;
  final VoidCallback onRefresh;
  final Function(BookingStatus?) onFilterChanged;
  final Function(String bookingId, BookingStatus status) onUpdateBookingStatus;

  int get activeBookings => bookings
      .where(
        (Booking b) =>
            b.status == BookingStatus.confirmed ||
            b.status == BookingStatus.inProgress,
      )
      .length;

  int get completedBookings =>
      bookings.where((Booking b) => b.status == BookingStatus.completed).length;

  static BookingsViewModel fromStore(Store<AppState> store) {
    return BookingsViewModel(
      bookings: HousekeepingSelectors.getFilteredBookings(store.state),
      isLoading: store.state.housekeepingState.isLoading,
      error: store.state.housekeepingState.error,
      currentFilter: HousekeepingSelectors.getBookingFilters(store.state).status,
      onRefresh: () => store.dispatch(const LoadBookingsAction()),
      onFilterChanged: (BookingStatus? filter) =>
          store.dispatch(UpdateBookingFiltersAction(BookingFilters(status: filter))),
      onUpdateBookingStatus: (String bookingId, BookingStatus status) =>
          store.dispatch(
            UpdateBookingStatusAction(
              bookingId: bookingId,
              status: status,
            ),
          ),
    );
  }
}
