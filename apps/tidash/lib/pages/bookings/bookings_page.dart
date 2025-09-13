import 'package:fpdart/fpdart.dart' hide State;
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:languist/languist.dart';
import '../../widgets/dialogs/create_booking_dialog.dart';
import '../../widgets/dialogs/booking_filter_dialog.dart';
import '../../widgets/dialogs/booking_details_dialog.dart';

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
            return EmptyState(
              icon: Icons.calendar_today_outlined,
              title: l10n.noBookings,
              description: l10n.noBookingsDescription,
              action: ElevatedButton.icon(
                onPressed: () => _showCreateBookingDialog(context),
                icon: const Icon(Icons.add),
                label: Text(l10n.createBooking),
              ),
            );
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
                        onStatusChanged: (BookingActivityStatus status) =>
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

  void _showCreateBookingDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => const CreateBookingDialog(),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) =>
          StoreConnector<AppState, BookingActivityStatus?>(
            builder:
                (BuildContext context, BookingActivityStatus? currentFilter) =>
                    BookingFilterDialog(
                      currentFilter: currentFilter,
                      onFilterChanged: (BookingActivityStatus? filter) {
                        StoreProvider.of<AppState>(
                          context,
                          listen: false,
                        ).dispatch(UpdateBookingFiltersAction(filter));
                      },
                    ),
            converter: (Store<AppState> store) {
              return null;
            },
          ),
    );
  }

  void _navigateToBookingDetails(BuildContext context, Booking booking) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) => BookingDetailsDialog(booking: booking),
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
  final Option<Exception> error;
  final BookingActivityStatus? currentFilter;
  final VoidCallback onRefresh;
  final Function(BookingActivityStatus?) onFilterChanged;
  final Function(String bookingId, BookingActivityStatus status)
  onUpdateBookingStatus;

  int get activeBookings => bookings
      .where(
        (Booking b) =>
            b.status == BookingActivityStatus.confirmed ||
            b.status == BookingActivityStatus.inProgress,
      )
      .length;

  int get completedBookings => bookings
      .where((Booking b) => b.status == BookingActivityStatus.completed)
      .length;

  static BookingsViewModel fromStore(Store<AppState> store) {
    return BookingsViewModel(
      bookings: BookingSelectors.getFilteredBookings(store.state),
      isLoading: BookingSelectors.isBookingsLoading(store.state),
      error: BookingSelectors.getBookingError(store.state),

      onRefresh: () {
        store.dispatch(const LoadBookingsAction());
      },
      onFilterChanged: (BookingActivityStatus? filter) {
        store.dispatch(UpdateBookingFiltersAction(filter));
      },
      onUpdateBookingStatus: (String bookingId, BookingActivityStatus status) {
        store.dispatch(
          UpdateBookingAction(
            bookingId: bookingId,
            updates: <String, dynamic>{'status': status.name},
          ),
        );
      },
      currentFilter: null,
    );
  }
}
