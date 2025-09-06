import 'package:redux/redux.dart';
import '../app_state.dart';
import 'housekeeping_actions.dart';
import 'housekeeping_models.dart';

/// Middleware for handling housekeeping async operations
List<Middleware<AppState>> createHousekeepingMiddleware() {
  return [
    TypedMiddleware<AppState, LoadHousekeepingMetricsAction>(_loadMetricsMiddleware),
    TypedMiddleware<AppState, RefreshHousekeepingMetricsAction>(_refreshMetricsMiddleware),
    TypedMiddleware<AppState, LoadBookingsAction>(_loadBookingsMiddleware),
    TypedMiddleware<AppState, LoadCleanersAction>(_loadCleanersMiddleware),
    TypedMiddleware<AppState, LoadCustomersAction>(_loadCustomersMiddleware),
    TypedMiddleware<AppState, LoadServicesAction>(_loadServicesMiddleware),
    TypedMiddleware<AppState, CreateBookingAction>(_createBookingMiddleware),
    TypedMiddleware<AppState, UpdateBookingAction>(_updateBookingMiddleware),
    TypedMiddleware<AppState, CreateCleanerAction>(_createCleanerMiddleware),
    TypedMiddleware<AppState, UpdateCleanerAction>(_updateCleanerMiddleware),
    TypedMiddleware<AppState, CreateCustomerAction>(_createCustomerMiddleware),
    TypedMiddleware<AppState, UpdateCustomerAction>(_updateCustomerMiddleware),
    TypedMiddleware<AppState, CreateServiceAction>(_createServiceMiddleware),
    TypedMiddleware<AppState, UpdateServiceAction>(_updateServiceMiddleware),
  ];
}

// ============================================================================
// METRICS MIDDLEWARE
// ============================================================================

void _loadMetricsMiddleware(Store<AppState> store, LoadHousekeepingMetricsAction action, NextDispatcher next) {
  next(action);
  
  store.dispatch(const SetHousekeepingLoadingAction(true));
  store.dispatch(const ClearHousekeepingErrorAction());
  
  _fetchHousekeepingMetrics().then((metrics) {
    store.dispatch(SetHousekeepingMetricsAction(metrics));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  });
}

void _refreshMetricsMiddleware(Store<AppState> store, RefreshHousekeepingMetricsAction action, NextDispatcher next) {
  next(action);
  
  store.dispatch(const SetHousekeepingRefreshingAction(true));
  store.dispatch(const ClearHousekeepingErrorAction());
  
  _fetchHousekeepingMetrics().then((metrics) {
    store.dispatch(SetHousekeepingMetricsAction(metrics));
    store.dispatch(const SetHousekeepingRefreshingAction(false));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
    store.dispatch(const SetHousekeepingRefreshingAction(false));
  });
}

// ============================================================================
// BOOKING MIDDLEWARE
// ============================================================================

void _loadBookingsMiddleware(Store<AppState> store, LoadBookingsAction action, NextDispatcher next) {
  next(action);
  
  store.dispatch(const SetHousekeepingLoadingAction(true));
  store.dispatch(const ClearHousekeepingErrorAction());
  
  _fetchBookings(action.filters).then((bookings) {
    store.dispatch(SetBookingsAction(bookings));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  });
}

void _createBookingMiddleware(Store<AppState> store, CreateBookingAction action, NextDispatcher next) {
  _createBooking(action.booking).then((createdBooking) {
    next(CreateBookingAction(createdBooking));
    // Refresh metrics after creating booking
    store.dispatch(const RefreshHousekeepingMetricsAction());
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
  });
}

void _updateBookingMiddleware(Store<AppState> store, UpdateBookingAction action, NextDispatcher next) {
  _updateBooking(action.booking).then((updatedBooking) {
    next(UpdateBookingAction(updatedBooking));
    // Refresh metrics after updating booking
    store.dispatch(const RefreshHousekeepingMetricsAction());
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
  });
}

// ============================================================================
// CLEANER MIDDLEWARE
// ============================================================================

void _loadCleanersMiddleware(Store<AppState> store, LoadCleanersAction action, NextDispatcher next) {
  next(action);
  
  store.dispatch(const SetHousekeepingLoadingAction(true));
  store.dispatch(const ClearHousekeepingErrorAction());
  
  _fetchCleaners(action.filters).then((cleaners) {
    store.dispatch(SetCleanersAction(cleaners));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  });
}

void _createCleanerMiddleware(Store<AppState> store, CreateCleanerAction action, NextDispatcher next) {
  _createCleaner(action.cleaner).then((createdCleaner) {
    next(CreateCleanerAction(createdCleaner));
    // Refresh metrics after creating cleaner
    store.dispatch(const RefreshHousekeepingMetricsAction());
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
  });
}

void _updateCleanerMiddleware(Store<AppState> store, UpdateCleanerAction action, NextDispatcher next) {
  _updateCleaner(action.cleaner).then((updatedCleaner) {
    next(UpdateCleanerAction(updatedCleaner));
    // Refresh metrics after updating cleaner
    store.dispatch(const RefreshHousekeepingMetricsAction());
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
  });
}

// ============================================================================
// CUSTOMER MIDDLEWARE
// ============================================================================

void _loadCustomersMiddleware(Store<AppState> store, LoadCustomersAction action, NextDispatcher next) {
  next(action);
  
  store.dispatch(const SetHousekeepingLoadingAction(true));
  store.dispatch(const ClearHousekeepingErrorAction());
  
  _fetchCustomers(action.filters).then((customers) {
    store.dispatch(SetCustomersAction(customers));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  });
}

void _createCustomerMiddleware(Store<AppState> store, CreateCustomerAction action, NextDispatcher next) {
  _createCustomer(action.customer).then((createdCustomer) {
    next(CreateCustomerAction(createdCustomer));
    // Refresh metrics after creating customer
    store.dispatch(const RefreshHousekeepingMetricsAction());
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
  });
}

void _updateCustomerMiddleware(Store<AppState> store, UpdateCustomerAction action, NextDispatcher next) {
  _updateCustomer(action.customer).then((updatedCustomer) {
    next(UpdateCustomerAction(updatedCustomer));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
  });
}

// ============================================================================
// SERVICE MIDDLEWARE
// ============================================================================

void _loadServicesMiddleware(Store<AppState> store, LoadServicesAction action, NextDispatcher next) {
  next(action);
  
  store.dispatch(const SetHousekeepingLoadingAction(true));
  store.dispatch(const ClearHousekeepingErrorAction());
  
  _fetchServices().then((services) {
    store.dispatch(SetServicesAction(services));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
    store.dispatch(const SetHousekeepingLoadingAction(false));
  });
}

void _createServiceMiddleware(Store<AppState> store, CreateServiceAction action, NextDispatcher next) {
  _createService(action.service).then((createdService) {
    next(CreateServiceAction(createdService));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
  });
}

void _updateServiceMiddleware(Store<AppState> store, UpdateServiceAction action, NextDispatcher next) {
  _updateService(action.service).then((updatedService) {
    next(UpdateServiceAction(updatedService));
  }).catchError((error) {
    store.dispatch(SetHousekeepingErrorAction(error.toString()));
  });
}

// ============================================================================
// API SIMULATION FUNCTIONS (Replace with actual Supabase calls)
// ============================================================================

Future<HousekeepingMetrics> _fetchHousekeepingMetrics() async {
  // Simulate API delay
  await Future.delayed(const Duration(milliseconds: 1500));
  
  // Mock data - replace with actual Supabase queries
  return HousekeepingMetrics(
    totalBookings: 1247,
    activeBookings: 23,
    completedBookings: 1180,
    totalRevenue: 89750.50,
    monthlyRevenue: 12450.75,
    totalCustomers: 456,
    activeCleaners: 18,
    averageRating: 4.7,
    bookingGrowthRate: 15.3,
    revenueGrowthRate: 22.1,
    recentActivities: [
      HousekeepingActivity(
        id: '1',
        title: 'New Booking Created',
        description: 'Deep cleaning service booked by Sarah Johnson',
        timestamp: DateTime.now().subtract(const Duration(minutes: 15)),
        type: HousekeepingActivityType.bookingCreated,
        bookingId: 'booking_001',
        customerId: 'customer_001',
      ),
      HousekeepingActivity(
        id: '2',
        title: 'Cleaner Assigned',
        description: 'Maria Rodriguez assigned to regular cleaning',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        type: HousekeepingActivityType.cleanerAssigned,
        bookingId: 'booking_002',
        cleanerId: 'cleaner_001',
      ),
      HousekeepingActivity(
        id: '3',
        title: 'Service Completed',
        description: 'Move-out cleaning completed successfully',
        timestamp: DateTime.now().subtract(const Duration(hours: 4)),
        type: HousekeepingActivityType.bookingCompleted,
        bookingId: 'booking_003',
      ),
    ],
    upcomingBookings: [],
  );
}

Future<List<Booking>> _fetchBookings(filters) async {
  await Future.delayed(const Duration(milliseconds: 800));
  
  // Mock data - replace with actual Supabase queries
  return [
    Booking(
      id: 'booking_001',
      customerId: 'customer_001',
      serviceId: 'service_001',
      scheduledDate: DateTime.now().add(const Duration(days: 1)),
      status: BookingStatus.confirmed,
      address: const Address(
        street: '123 Main St',
        city: 'Springfield',
        state: 'IL',
        zipCode: '62701',
      ),
      totalPrice: 150.00,
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      cleanerId: 'cleaner_001',
      notes: 'Please focus on kitchen and bathrooms',
    ),
  ];
}

Future<List<Cleaner>> _fetchCleaners(filters) async {
  await Future.delayed(const Duration(milliseconds: 600));
  
  // Mock data - replace with actual Supabase queries
  return [
    Cleaner(
      id: 'cleaner_001',
      firstName: 'Maria',
      lastName: 'Rodriguez',
      email: 'maria.rodriguez@tidaro.com',
      phone: '+1-555-0123',
      status: CleanerStatus.active,
      joinedAt: DateTime.now().subtract(const Duration(days: 180)),
      specialties: [ServiceCategory.regularCleaning, ServiceCategory.deepCleaning],
      rating: 4.8,
      totalJobs: 156,
      isAvailable: true,
      hourlyRate: 25.00,
    ),
  ];
}

Future<List<Customer>> _fetchCustomers(filters) async {
  await Future.delayed(const Duration(milliseconds: 600));
  
  // Mock data - replace with actual Supabase queries
  return [
    Customer(
      id: 'customer_001',
      firstName: 'Sarah',
      lastName: 'Johnson',
      email: 'sarah.johnson@email.com',
      phone: '+1-555-0456',
      createdAt: DateTime.now().subtract(const Duration(days: 90)),
      addresses: [
        const Address(
          street: '123 Main St',
          city: 'Springfield',
          state: 'IL',
          zipCode: '62701',
          isDefault: true,
        ),
      ],
      totalBookings: 8,
      isActive: true,
    ),
  ];
}

Future<List<HousekeepingService>> _fetchServices() async {
  await Future.delayed(const Duration(milliseconds: 400));
  
  // Mock data - replace with actual Supabase queries
  return [
    const HousekeepingService(
      id: 'service_001',
      name: 'Regular Cleaning',
      description: 'Standard house cleaning service including all rooms',
      basePrice: 120.00,
      duration: Duration(hours: 3),
      category: ServiceCategory.regularCleaning,
      isActive: true,
      requirements: ['Basic cleaning supplies', 'Vacuum cleaner'],
      addOns: [
        ServiceAddOn(
          id: 'addon_001',
          name: 'Inside Oven Cleaning',
          price: 25.00,
          description: 'Deep clean inside of oven',
        ),
      ],
    ),
  ];
}

// Create/Update operations (replace with actual Supabase calls)
Future<Booking> _createBooking(Booking booking) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return booking;
}

Future<Booking> _updateBooking(Booking booking) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return booking;
}

Future<Cleaner> _createCleaner(Cleaner cleaner) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return cleaner;
}

Future<Cleaner> _updateCleaner(Cleaner cleaner) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return cleaner;
}

Future<Customer> _createCustomer(Customer customer) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return customer;
}

Future<Customer> _updateCustomer(Customer customer) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return customer;
}

Future<HousekeepingService> _createService(HousekeepingService service) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return service;
}

Future<HousekeepingService> _updateService(HousekeepingService service) async {
  await Future.delayed(const Duration(milliseconds: 500));
  return service;
}
