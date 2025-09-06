import 'package:equatable/equatable.dart';
import 'housekeeping_models.dart';

/// State for housekeeping operations
class HousekeepingState extends Equatable {
  const HousekeepingState({
    // Loading states
    this.isLoading = false,
    this.isRefreshing = false,
    
    // Data
    this.metrics,
    this.services = const [],
    this.bookings = const [],
    this.cleaners = const [],
    this.customers = const [],
    
    // Filters and pagination
    this.bookingFilters = const BookingFilters(),
    this.cleanerFilters = const CleanerFilters(),
    this.customerFilters = const CustomerFilters(),
    
    // Error handling
    this.error,
    this.lastUpdated,
    
    // Selected items for detail views
    this.selectedBooking,
    this.selectedCleaner,
    this.selectedCustomer,
    this.selectedService,
  });

  // Loading states
  final bool isLoading;
  final bool isRefreshing;
  
  // Core data
  final HousekeepingMetrics? metrics;
  final List<HousekeepingService> services;
  final List<Booking> bookings;
  final List<Cleaner> cleaners;
  final List<Customer> customers;
  
  // Filters and pagination
  final BookingFilters bookingFilters;
  final CleanerFilters cleanerFilters;
  final CustomerFilters customerFilters;
  
  // Error handling
  final String? error;
  final DateTime? lastUpdated;
  
  // Selected items
  final Booking? selectedBooking;
  final Cleaner? selectedCleaner;
  final Customer? selectedCustomer;
  final HousekeepingService? selectedService;

  factory HousekeepingState.initial() {
    return const HousekeepingState();
  }

  HousekeepingState copyWith({
    bool? isLoading,
    bool? isRefreshing,
    HousekeepingMetrics? metrics,
    List<HousekeepingService>? services,
    List<Booking>? bookings,
    List<Cleaner>? cleaners,
    List<Customer>? customers,
    BookingFilters? bookingFilters,
    CleanerFilters? cleanerFilters,
    CustomerFilters? customerFilters,
    String? error,
    DateTime? lastUpdated,
    Booking? selectedBooking,
    Cleaner? selectedCleaner,
    Customer? selectedCustomer,
    HousekeepingService? selectedService,
  }) {
    return HousekeepingState(
      isLoading: isLoading ?? this.isLoading,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      metrics: metrics ?? this.metrics,
      services: services ?? this.services,
      bookings: bookings ?? this.bookings,
      cleaners: cleaners ?? this.cleaners,
      customers: customers ?? this.customers,
      bookingFilters: bookingFilters ?? this.bookingFilters,
      cleanerFilters: cleanerFilters ?? this.cleanerFilters,
      customerFilters: customerFilters ?? this.customerFilters,
      error: error ?? this.error,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      selectedBooking: selectedBooking ?? this.selectedBooking,
      selectedCleaner: selectedCleaner ?? this.selectedCleaner,
      selectedCustomer: selectedCustomer ?? this.selectedCustomer,
      selectedService: selectedService ?? this.selectedService,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        isRefreshing,
        metrics,
        services,
        bookings,
        cleaners,
        customers,
        bookingFilters,
        cleanerFilters,
        customerFilters,
        error,
        lastUpdated,
        selectedBooking,
        selectedCleaner,
        selectedCustomer,
        selectedService,
      ];
}

/// Filters for booking queries
class BookingFilters extends Equatable {
  const BookingFilters({
    this.status,
    this.dateRange,
    this.cleanerId,
    this.customerId,
    this.serviceId,
    this.sortBy = BookingSortBy.scheduledDate,
    this.sortOrder = SortOrder.descending,
    this.limit = 50,
    this.offset = 0,
  });

  final BookingStatus? status;
  final DateRange? dateRange;
  final String? cleanerId;
  final String? customerId;
  final String? serviceId;
  final BookingSortBy sortBy;
  final SortOrder sortOrder;
  final int limit;
  final int offset;

  BookingFilters copyWith({
    BookingStatus? status,
    DateRange? dateRange,
    String? cleanerId,
    String? customerId,
    String? serviceId,
    BookingSortBy? sortBy,
    SortOrder? sortOrder,
    int? limit,
    int? offset,
  }) {
    return BookingFilters(
      status: status ?? this.status,
      dateRange: dateRange ?? this.dateRange,
      cleanerId: cleanerId ?? this.cleanerId,
      customerId: customerId ?? this.customerId,
      serviceId: serviceId ?? this.serviceId,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => [
        status,
        dateRange,
        cleanerId,
        customerId,
        serviceId,
        sortBy,
        sortOrder,
        limit,
        offset,
      ];
}

/// Filters for cleaner queries
class CleanerFilters extends Equatable {
  const CleanerFilters({
    this.status,
    this.isAvailable,
    this.specialties = const [],
    this.minRating,
    this.sortBy = CleanerSortBy.name,
    this.sortOrder = SortOrder.ascending,
    this.limit = 50,
    this.offset = 0,
  });

  final CleanerStatus? status;
  final bool? isAvailable;
  final List<ServiceCategory> specialties;
  final double? minRating;
  final CleanerSortBy sortBy;
  final SortOrder sortOrder;
  final int limit;
  final int offset;

  CleanerFilters copyWith({
    CleanerStatus? status,
    bool? isAvailable,
    List<ServiceCategory>? specialties,
    double? minRating,
    CleanerSortBy? sortBy,
    SortOrder? sortOrder,
    int? limit,
    int? offset,
  }) {
    return CleanerFilters(
      status: status ?? this.status,
      isAvailable: isAvailable ?? this.isAvailable,
      specialties: specialties ?? this.specialties,
      minRating: minRating ?? this.minRating,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isAvailable,
        specialties,
        minRating,
        sortBy,
        sortOrder,
        limit,
        offset,
      ];
}

/// Filters for customer queries
class CustomerFilters extends Equatable {
  const CustomerFilters({
    this.isActive,
    this.minBookings,
    this.sortBy = CustomerSortBy.name,
    this.sortOrder = SortOrder.ascending,
    this.limit = 50,
    this.offset = 0,
  });

  final bool? isActive;
  final int? minBookings;
  final CustomerSortBy sortBy;
  final SortOrder sortOrder;
  final int limit;
  final int offset;

  CustomerFilters copyWith({
    bool? isActive,
    int? minBookings,
    CustomerSortBy? sortBy,
    SortOrder? sortOrder,
    int? limit,
    int? offset,
  }) {
    return CustomerFilters(
      isActive: isActive ?? this.isActive,
      minBookings: minBookings ?? this.minBookings,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
      limit: limit ?? this.limit,
      offset: offset ?? this.offset,
    );
  }

  @override
  List<Object?> get props => [
        isActive,
        minBookings,
        sortBy,
        sortOrder,
        limit,
        offset,
      ];
}

/// Date range for filtering
class DateRange extends Equatable {
  const DateRange({
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;

  @override
  List<Object?> get props => [start, end];
}

/// Sort options for bookings
enum BookingSortBy {
  scheduledDate,
  createdAt,
  totalPrice,
  status,
}

/// Sort options for cleaners
enum CleanerSortBy {
  name,
  rating,
  totalJobs,
  joinedAt,
}

/// Sort options for customers
enum CustomerSortBy {
  name,
  totalBookings,
  createdAt,
}

/// Sort order
enum SortOrder {
  ascending,
  descending,
}
