import 'package:redux/redux.dart';
import 'housekeeping_actions.dart';
import 'housekeeping_state.dart';
import 'housekeeping_models.dart';

/// Main reducer for housekeeping state
final Reducer<HousekeepingState> housekeepingReducer = combineReducers<HousekeepingState>([
  // Loading states
  TypedReducer<HousekeepingState, SetHousekeepingLoadingAction>(_setLoadingReducer),
  TypedReducer<HousekeepingState, SetHousekeepingRefreshingAction>(_setRefreshingReducer),
  
  // Error handling
  TypedReducer<HousekeepingState, SetHousekeepingErrorAction>(_setErrorReducer),
  TypedReducer<HousekeepingState, ClearHousekeepingErrorAction>(_clearErrorReducer),
  TypedReducer<HousekeepingState, SetHousekeepingLastUpdatedAction>(_setLastUpdatedReducer),
  
  // Metrics
  TypedReducer<HousekeepingState, SetHousekeepingMetricsAction>(_setMetricsReducer),
  
  // Bookings
  TypedReducer<HousekeepingState, SetBookingsAction>(_setBookingsReducer),
  TypedReducer<HousekeepingState, SelectBookingAction>(_selectBookingReducer),
  TypedReducer<HousekeepingState, CreateBookingAction>(_createBookingReducer),
  TypedReducer<HousekeepingState, UpdateBookingAction>(_updateBookingReducer),
  TypedReducer<HousekeepingState, UpdateBookingStatusAction>(_updateBookingStatusReducer),
  TypedReducer<HousekeepingState, AssignCleanerToBookingAction>(_assignCleanerToBookingReducer),
  TypedReducer<HousekeepingState, CancelBookingAction>(_cancelBookingReducer),
  TypedReducer<HousekeepingState, UpdateBookingFiltersAction>(_updateBookingFiltersReducer),
  
  // Cleaners
  TypedReducer<HousekeepingState, SetCleanersAction>(_setCleanersReducer),
  TypedReducer<HousekeepingState, SelectCleanerAction>(_selectCleanerReducer),
  TypedReducer<HousekeepingState, CreateCleanerAction>(_createCleanerReducer),
  TypedReducer<HousekeepingState, UpdateCleanerAction>(_updateCleanerReducer),
  TypedReducer<HousekeepingState, UpdateCleanerStatusAction>(_updateCleanerStatusReducer),
  TypedReducer<HousekeepingState, UpdateCleanerAvailabilityAction>(_updateCleanerAvailabilityReducer),
  TypedReducer<HousekeepingState, UpdateCleanerFiltersAction>(_updateCleanerFiltersReducer),
  
  // Customers
  TypedReducer<HousekeepingState, SetCustomersAction>(_setCustomersReducer),
  TypedReducer<HousekeepingState, SelectCustomerAction>(_selectCustomerReducer),
  TypedReducer<HousekeepingState, CreateCustomerAction>(_createCustomerReducer),
  TypedReducer<HousekeepingState, UpdateCustomerAction>(_updateCustomerReducer),
  TypedReducer<HousekeepingState, UpdateCustomerFiltersAction>(_updateCustomerFiltersReducer),
  
  // Services
  TypedReducer<HousekeepingState, SetServicesAction>(_setServicesReducer),
  TypedReducer<HousekeepingState, SelectServiceAction>(_selectServiceReducer),
  TypedReducer<HousekeepingState, CreateServiceAction>(_createServiceReducer),
  TypedReducer<HousekeepingState, UpdateServiceAction>(_updateServiceReducer),
  TypedReducer<HousekeepingState, ToggleServiceStatusAction>(_toggleServiceStatusReducer),
]);

// ============================================================================
// LOADING & ERROR REDUCERS
// ============================================================================

HousekeepingState _setLoadingReducer(HousekeepingState state, SetHousekeepingLoadingAction action) {
  return state.copyWith(isLoading: action.isLoading);
}

HousekeepingState _setRefreshingReducer(HousekeepingState state, SetHousekeepingRefreshingAction action) {
  return state.copyWith(isRefreshing: action.isRefreshing);
}

HousekeepingState _setErrorReducer(HousekeepingState state, SetHousekeepingErrorAction action) {
  return state.copyWith(error: action.error);
}

HousekeepingState _clearErrorReducer(HousekeepingState state, ClearHousekeepingErrorAction action) {
  return state.copyWith(error: null);
}

HousekeepingState _setLastUpdatedReducer(HousekeepingState state, SetHousekeepingLastUpdatedAction action) {
  return state.copyWith(lastUpdated: action.lastUpdated);
}

// ============================================================================
// METRICS REDUCERS
// ============================================================================

HousekeepingState _setMetricsReducer(HousekeepingState state, SetHousekeepingMetricsAction action) {
  return state.copyWith(
    metrics: action.metrics,
    lastUpdated: DateTime.now(),
  );
}

// ============================================================================
// BOOKING REDUCERS
// ============================================================================

HousekeepingState _setBookingsReducer(HousekeepingState state, SetBookingsAction action) {
  return state.copyWith(bookings: action.bookings);
}

HousekeepingState _selectBookingReducer(HousekeepingState state, SelectBookingAction action) {
  return state.copyWith(selectedBooking: action.booking);
}

HousekeepingState _createBookingReducer(HousekeepingState state, CreateBookingAction action) {
  final updatedBookings = List<Booking>.from(state.bookings)..add(action.booking);
  return state.copyWith(bookings: updatedBookings);
}

HousekeepingState _updateBookingReducer(HousekeepingState state, UpdateBookingAction action) {
  final updatedBookings = state.bookings.map((booking) {
    return booking.id == action.booking.id ? action.booking : booking;
  }).toList();
  
  return state.copyWith(
    bookings: updatedBookings,
    selectedBooking: state.selectedBooking?.id == action.booking.id ? action.booking : state.selectedBooking,
  );
}

HousekeepingState _updateBookingStatusReducer(HousekeepingState state, UpdateBookingStatusAction action) {
  final updatedBookings = state.bookings.map((booking) {
    if (booking.id == action.bookingId) {
      return booking.copyWith(status: action.status);
    }
    return booking;
  }).toList();
  
  final updatedSelectedBooking = state.selectedBooking?.id == action.bookingId
      ? state.selectedBooking!.copyWith(status: action.status)
      : state.selectedBooking;
  
  return state.copyWith(
    bookings: updatedBookings,
    selectedBooking: updatedSelectedBooking,
  );
}

HousekeepingState _assignCleanerToBookingReducer(HousekeepingState state, AssignCleanerToBookingAction action) {
  final updatedBookings = state.bookings.map((booking) {
    if (booking.id == action.bookingId) {
      return booking.copyWith(
        cleanerId: action.cleanerId,
        status: BookingStatus.assigned,
      );
    }
    return booking;
  }).toList();
  
  final updatedSelectedBooking = state.selectedBooking?.id == action.bookingId
      ? state.selectedBooking!.copyWith(
          cleanerId: action.cleanerId,
          status: BookingStatus.assigned,
        )
      : state.selectedBooking;
  
  return state.copyWith(
    bookings: updatedBookings,
    selectedBooking: updatedSelectedBooking,
  );
}

HousekeepingState _cancelBookingReducer(HousekeepingState state, CancelBookingAction action) {
  final updatedBookings = state.bookings.map((booking) {
    if (booking.id == action.bookingId) {
      return booking.copyWith(status: BookingStatus.cancelled);
    }
    return booking;
  }).toList();
  
  final updatedSelectedBooking = state.selectedBooking?.id == action.bookingId
      ? state.selectedBooking!.copyWith(status: BookingStatus.cancelled)
      : state.selectedBooking;
  
  return state.copyWith(
    bookings: updatedBookings,
    selectedBooking: updatedSelectedBooking,
  );
}

HousekeepingState _updateBookingFiltersReducer(HousekeepingState state, UpdateBookingFiltersAction action) {
  return state.copyWith(bookingFilters: action.filters);
}

// ============================================================================
// CLEANER REDUCERS
// ============================================================================

HousekeepingState _setCleanersReducer(HousekeepingState state, SetCleanersAction action) {
  return state.copyWith(cleaners: action.cleaners);
}

HousekeepingState _selectCleanerReducer(HousekeepingState state, SelectCleanerAction action) {
  return state.copyWith(selectedCleaner: action.cleaner);
}

HousekeepingState _createCleanerReducer(HousekeepingState state, CreateCleanerAction action) {
  final updatedCleaners = List<Cleaner>.from(state.cleaners)..add(action.cleaner);
  return state.copyWith(cleaners: updatedCleaners);
}

HousekeepingState _updateCleanerReducer(HousekeepingState state, UpdateCleanerAction action) {
  final updatedCleaners = state.cleaners.map((cleaner) {
    return cleaner.id == action.cleaner.id ? action.cleaner : cleaner;
  }).toList();
  
  return state.copyWith(
    cleaners: updatedCleaners,
    selectedCleaner: state.selectedCleaner?.id == action.cleaner.id ? action.cleaner : state.selectedCleaner,
  );
}

HousekeepingState _updateCleanerStatusReducer(HousekeepingState state, UpdateCleanerStatusAction action) {
  final updatedCleaners = state.cleaners.map((cleaner) {
    if (cleaner.id == action.cleanerId) {
      return cleaner.copyWith(status: action.status);
    }
    return cleaner;
  }).toList();
  
  final updatedSelectedCleaner = state.selectedCleaner?.id == action.cleanerId
      ? state.selectedCleaner!.copyWith(status: action.status)
      : state.selectedCleaner;
  
  return state.copyWith(
    cleaners: updatedCleaners,
    selectedCleaner: updatedSelectedCleaner,
  );
}

HousekeepingState _updateCleanerAvailabilityReducer(HousekeepingState state, UpdateCleanerAvailabilityAction action) {
  final updatedCleaners = state.cleaners.map((cleaner) {
    if (cleaner.id == action.cleanerId) {
      return cleaner.copyWith(isAvailable: action.isAvailable);
    }
    return cleaner;
  }).toList();
  
  final updatedSelectedCleaner = state.selectedCleaner?.id == action.cleanerId
      ? state.selectedCleaner!.copyWith(isAvailable: action.isAvailable)
      : state.selectedCleaner;
  
  return state.copyWith(
    cleaners: updatedCleaners,
    selectedCleaner: updatedSelectedCleaner,
  );
}

HousekeepingState _updateCleanerFiltersReducer(HousekeepingState state, UpdateCleanerFiltersAction action) {
  return state.copyWith(cleanerFilters: action.filters);
}

// ============================================================================
// CUSTOMER REDUCERS
// ============================================================================

HousekeepingState _setCustomersReducer(HousekeepingState state, SetCustomersAction action) {
  return state.copyWith(customers: action.customers);
}

HousekeepingState _selectCustomerReducer(HousekeepingState state, SelectCustomerAction action) {
  return state.copyWith(selectedCustomer: action.customer);
}

HousekeepingState _createCustomerReducer(HousekeepingState state, CreateCustomerAction action) {
  final updatedCustomers = List<Customer>.from(state.customers)..add(action.customer);
  return state.copyWith(customers: updatedCustomers);
}

HousekeepingState _updateCustomerReducer(HousekeepingState state, UpdateCustomerAction action) {
  final updatedCustomers = state.customers.map((customer) {
    return customer.id == action.customer.id ? action.customer : customer;
  }).toList();
  
  return state.copyWith(
    customers: updatedCustomers,
    selectedCustomer: state.selectedCustomer?.id == action.customer.id ? action.customer : state.selectedCustomer,
  );
}

HousekeepingState _updateCustomerFiltersReducer(HousekeepingState state, UpdateCustomerFiltersAction action) {
  return state.copyWith(customerFilters: action.filters);
}

// ============================================================================
// SERVICE REDUCERS
// ============================================================================

HousekeepingState _setServicesReducer(HousekeepingState state, SetServicesAction action) {
  return state.copyWith(services: action.services);
}

HousekeepingState _selectServiceReducer(HousekeepingState state, SelectServiceAction action) {
  return state.copyWith(selectedService: action.service);
}

HousekeepingState _createServiceReducer(HousekeepingState state, CreateServiceAction action) {
  final updatedServices = List<HousekeepingService>.from(state.services)..add(action.service);
  return state.copyWith(services: updatedServices);
}

HousekeepingState _updateServiceReducer(HousekeepingState state, UpdateServiceAction action) {
  final updatedServices = state.services.map((service) {
    return service.id == action.service.id ? action.service : service;
  }).toList();
  
  return state.copyWith(
    services: updatedServices,
    selectedService: state.selectedService?.id == action.service.id ? action.service : state.selectedService,
  );
}

HousekeepingState _toggleServiceStatusReducer(HousekeepingState state, ToggleServiceStatusAction action) {
  final updatedServices = state.services.map((service) {
    if (service.id == action.serviceId) {
      return service.copyWith(isActive: !service.isActive);
    }
    return service;
  }).toList();
  
  final updatedSelectedService = state.selectedService?.id == action.serviceId
      ? state.selectedService!.copyWith(isActive: !state.selectedService!.isActive)
      : state.selectedService;
  
  return state.copyWith(
    services: updatedServices,
    selectedService: updatedSelectedService,
  );
}
