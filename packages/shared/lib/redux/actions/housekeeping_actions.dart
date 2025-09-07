import 'package:equatable/equatable.dart';
import 'package:shared/domain/models/models.dart';

/// Base class for all housekeeping actions
abstract class HousekeepingAction extends Equatable {
  const HousekeepingAction();
}

// ============================================================================
// DASHBOARD & METRICS ACTIONS
// ============================================================================

/// Load housekeeping dashboard metrics
class LoadHousekeepingMetricsAction extends HousekeepingAction {
  const LoadHousekeepingMetricsAction();

  @override
  List<Object?> get props => [];
}

/// Refresh housekeeping dashboard metrics
class RefreshHousekeepingMetricsAction extends HousekeepingAction {
  const RefreshHousekeepingMetricsAction();

  @override
  List<Object?> get props => [];
}

/// Set housekeeping metrics
class SetHousekeepingMetricsAction extends HousekeepingAction {
  const SetHousekeepingMetricsAction(this.metrics);

  final HousekeepingMetrics metrics;

  @override
  List<Object?> get props => [metrics];
}

// ============================================================================
// BOOKING ACTIONS
// ============================================================================

/// Load bookings with optional filters
class LoadBookingsAction extends HousekeepingAction {
  const LoadBookingsAction({this.filters});

  final BookingFilters? filters;

  @override
  List<Object?> get props => [filters];
}

/// Set bookings list
class SetBookingsAction extends HousekeepingAction {
  const SetBookingsAction(this.bookings);

  final List<Booking> bookings;

  @override
  List<Object?> get props => [bookings];
}

/// Select a specific booking
class SelectBookingAction extends HousekeepingAction {
  const SelectBookingAction(this.booking);

  final Booking? booking;

  @override
  List<Object?> get props => [booking];
}

/// Create a new booking
class CreateBookingAction extends HousekeepingAction {
  const CreateBookingAction(this.booking);

  final Booking booking;

  @override
  List<Object?> get props => [booking];
}

/// Update an existing booking
class UpdateBookingAction extends HousekeepingAction {
  const UpdateBookingAction(this.booking);

  final Booking booking;

  @override
  List<Object?> get props => [booking];
}

/// Update booking status
class UpdateBookingStatusAction extends HousekeepingAction {
  const UpdateBookingStatusAction({
    required this.bookingId,
    required this.status,
  });

  final String bookingId;
  final BookingStatus status;

  @override
  List<Object?> get props => [bookingId, status];
}

/// Assign cleaner to booking
class AssignCleanerToBookingAction extends HousekeepingAction {
  const AssignCleanerToBookingAction({
    required this.bookingId,
    required this.cleanerId,
  });

  final String bookingId;
  final String cleanerId;

  @override
  List<Object?> get props => [bookingId, cleanerId];
}

/// Cancel booking
class CancelBookingAction extends HousekeepingAction {
  const CancelBookingAction({required this.bookingId, this.reason});

  final String bookingId;
  final String? reason;

  @override
  List<Object?> get props => [bookingId, reason];
}

/// Update booking filters
class UpdateBookingFiltersAction extends HousekeepingAction {
  const UpdateBookingFiltersAction(this.filters);

  final BookingFilters filters;

  @override
  List<Object?> get props => [filters];
}

// ============================================================================
// CLEANER ACTIONS
// ============================================================================

/// Load cleaners with optional filters
class LoadCleanersAction extends HousekeepingAction {
  const LoadCleanersAction({this.filters});

  final CleanerFilters? filters;

  @override
  List<Object?> get props => [filters];
}

/// Set cleaners list
class SetCleanersAction extends HousekeepingAction {
  const SetCleanersAction(this.cleaners);

  final List<Cleaner> cleaners;

  @override
  List<Object?> get props => [cleaners];
}

/// Select a specific cleaner
class SelectCleanerAction extends HousekeepingAction {
  const SelectCleanerAction(this.cleaner);

  final Cleaner? cleaner;

  @override
  List<Object?> get props => [cleaner];
}

/// Create a new cleaner
class CreateCleanerAction extends HousekeepingAction {
  const CreateCleanerAction(this.cleaner);

  final Cleaner cleaner;

  @override
  List<Object?> get props => [cleaner];
}

/// Update an existing cleaner
class UpdateCleanerAction extends HousekeepingAction {
  const UpdateCleanerAction(this.cleaner);

  final Cleaner cleaner;

  @override
  List<Object?> get props => [cleaner];
}

/// Update cleaner status
class UpdateCleanerStatusAction extends HousekeepingAction {
  const UpdateCleanerStatusAction({
    required this.cleanerId,
    required this.status,
  });

  final String cleanerId;
  final CleanerStatus status;

  @override
  List<Object?> get props => [cleanerId, status];
}

/// Update cleaner availability
class UpdateCleanerAvailabilityAction extends HousekeepingAction {
  const UpdateCleanerAvailabilityAction({
    required this.cleanerId,
    required this.isAvailable,
  });

  final String cleanerId;
  final bool isAvailable;

  @override
  List<Object?> get props => [cleanerId, isAvailable];
}

/// Update cleaner filters
class UpdateCleanerFiltersAction extends HousekeepingAction {
  const UpdateCleanerFiltersAction(this.filters);

  final CleanerFilters filters;

  @override
  List<Object?> get props => [filters];
}

// ============================================================================
// CUSTOMER ACTIONS
// ============================================================================

/// Load customers with optional filters
class LoadCustomersAction extends HousekeepingAction {
  const LoadCustomersAction({this.filters});

  final CustomerFilters? filters;

  @override
  List<Object?> get props => [filters];
}

/// Set customers list
class SetCustomersAction extends HousekeepingAction {
  const SetCustomersAction(this.customers);

  final List<Customer> customers;

  @override
  List<Object?> get props => [customers];
}

/// Select a specific customer
class SelectCustomerAction extends HousekeepingAction {
  const SelectCustomerAction(this.customer);

  final Customer? customer;

  @override
  List<Object?> get props => [customer];
}

/// Create a new customer
class CreateCustomerAction extends HousekeepingAction {
  const CreateCustomerAction(this.customer);

  final Customer customer;

  @override
  List<Object?> get props => [customer];
}

/// Update an existing customer
class UpdateCustomerAction extends HousekeepingAction {
  const UpdateCustomerAction(this.customer);

  final Customer customer;

  @override
  List<Object?> get props => [customer];
}

/// Update customer filters
class UpdateCustomerFiltersAction extends HousekeepingAction {
  const UpdateCustomerFiltersAction(this.filters);

  final CustomerFilters filters;

  @override
  List<Object?> get props => [filters];
}

// ============================================================================
// SERVICE ACTIONS
// ============================================================================

/// Load services
class LoadServicesAction extends HousekeepingAction {
  const LoadServicesAction();

  @override
  List<Object?> get props => [];
}

/// Set services list
class SetServicesAction extends HousekeepingAction {
  const SetServicesAction(this.services);

  final List<HousekeepingService> services;

  @override
  List<Object?> get props => [services];
}

/// Select a specific service
class SelectServiceAction extends HousekeepingAction {
  const SelectServiceAction(this.service);

  final HousekeepingService? service;

  @override
  List<Object?> get props => [service];
}

/// Create a new service
class CreateServiceAction extends HousekeepingAction {
  const CreateServiceAction(this.service);

  final HousekeepingService service;

  @override
  List<Object?> get props => [service];
}

/// Update an existing service
class UpdateServiceAction extends HousekeepingAction {
  const UpdateServiceAction(this.service);

  final HousekeepingService service;

  @override
  List<Object?> get props => [service];
}

/// Toggle service active status
class ToggleServiceStatusAction extends HousekeepingAction {
  const ToggleServiceStatusAction(this.serviceId);

  final String serviceId;

  @override
  List<Object?> get props => [serviceId];
}

// ============================================================================
// GENERAL ACTIONS
// ============================================================================

/// Set loading state
class SetHousekeepingLoadingAction extends HousekeepingAction {
  const SetHousekeepingLoadingAction(this.isLoading);

  final bool isLoading;

  @override
  List<Object?> get props => [isLoading];
}

/// Set refreshing state
class SetHousekeepingRefreshingAction extends HousekeepingAction {
  const SetHousekeepingRefreshingAction(this.isRefreshing);

  final bool isRefreshing;

  @override
  List<Object?> get props => [isRefreshing];
}

/// Set error state
class SetHousekeepingErrorAction extends HousekeepingAction {
  const SetHousekeepingErrorAction(this.error);

  final String? error;

  @override
  List<Object?> get props => [error];
}

/// Clear error state
class ClearHousekeepingErrorAction extends HousekeepingAction {
  const ClearHousekeepingErrorAction();

  @override
  List<Object?> get props => [];
}

/// Set last updated timestamp
class SetHousekeepingLastUpdatedAction extends HousekeepingAction {
  const SetHousekeepingLastUpdatedAction(this.lastUpdated);

  final DateTime lastUpdated;

  @override
  List<Object?> get props => [lastUpdated];
}
