import '../app_state.dart';
import 'housekeeping_models.dart';
import 'housekeeping_state.dart';

/// Selectors for housekeeping state
class HousekeepingSelectors {
  // ============================================================================
  // BASE SELECTORS
  // ============================================================================
  
  /// Get the housekeeping state from app state
  static HousekeepingState getHousekeepingState(AppState state) {
    return state.housekeepingState;
  }
  
  /// Check if housekeeping data is loading
  static bool isLoading(AppState state) {
    return getHousekeepingState(state).isLoading;
  }
  
  /// Check if housekeeping data is refreshing
  static bool isRefreshing(AppState state) {
    return getHousekeepingState(state).isRefreshing;
  }
  
  /// Get housekeeping error
  static String? getError(AppState state) {
    return getHousekeepingState(state).error;
  }
  
  /// Get last updated timestamp
  static DateTime? getLastUpdated(AppState state) {
    return getHousekeepingState(state).lastUpdated;
  }
  
  // ============================================================================
  // METRICS SELECTORS
  // ============================================================================
  
  /// Get housekeeping metrics
  static HousekeepingMetrics? getMetrics(AppState state) {
    return getHousekeepingState(state).metrics;
  }
  
  /// Get total bookings count
  static int getTotalBookings(AppState state) {
    return getMetrics(state)?.totalBookings ?? 0;
  }
  
  /// Get active bookings count
  static int getActiveBookings(AppState state) {
    return getMetrics(state)?.activeBookings ?? 0;
  }
  
  /// Get completed bookings count
  static int getCompletedBookings(AppState state) {
    return getMetrics(state)?.completedBookings ?? 0;
  }
  
  /// Get total revenue
  static double getTotalRevenue(AppState state) {
    return getMetrics(state)?.totalRevenue ?? 0.0;
  }
  
  /// Get monthly revenue
  static double getMonthlyRevenue(AppState state) {
    return getMetrics(state)?.monthlyRevenue ?? 0.0;
  }
  
  /// Get total customers count
  static int getTotalCustomers(AppState state) {
    return getMetrics(state)?.totalCustomers ?? 0;
  }
  
  /// Get active cleaners count
  static int getActiveCleaners(AppState state) {
    return getMetrics(state)?.activeCleaners ?? 0;
  }
  
  /// Get average rating
  static double getAverageRating(AppState state) {
    return getMetrics(state)?.averageRating ?? 0.0;
  }
  
  /// Get booking growth rate
  static double getBookingGrowthRate(AppState state) {
    return getMetrics(state)?.bookingGrowthRate ?? 0.0;
  }
  
  /// Get revenue growth rate
  static double getRevenueGrowthRate(AppState state) {
    return getMetrics(state)?.revenueGrowthRate ?? 0.0;
  }
  
  /// Get recent activities
  static List<HousekeepingActivity> getRecentActivities(AppState state) {
    return getMetrics(state)?.recentActivities ?? [];
  }
  
  /// Get upcoming bookings
  static List<Booking> getUpcomingBookings(AppState state) {
    return getMetrics(state)?.upcomingBookings ?? [];
  }
  
  // ============================================================================
  // BOOKING SELECTORS
  // ============================================================================
  
  /// Get all bookings
  static List<Booking> getBookings(AppState state) {
    return getHousekeepingState(state).bookings;
  }
  
  /// Get selected booking
  static Booking? getSelectedBooking(AppState state) {
    return getHousekeepingState(state).selectedBooking;
  }
  
  /// Get booking filters
  static BookingFilters getBookingFilters(AppState state) {
    return getHousekeepingState(state).bookingFilters;
  }
  
  /// Get filtered bookings based on current filters
  static List<Booking> getFilteredBookings(AppState state) {
    final bookings = getBookings(state);
    final filters = getBookingFilters(state);
    
    return bookings.where((booking) {
      // Filter by status
      if (filters.status != null && booking.status != filters.status) {
        return false;
      }
      
      // Filter by date range
      if (filters.dateRange != null) {
        final dateRange = filters.dateRange!;
        if (booking.scheduledDate.isBefore(dateRange.start) ||
            booking.scheduledDate.isAfter(dateRange.end)) {
          return false;
        }
      }
      
      // Filter by cleaner
      if (filters.cleanerId != null && booking.cleanerId != filters.cleanerId) {
        return false;
      }
      
      // Filter by customer
      if (filters.customerId != null && booking.customerId != filters.customerId) {
        return false;
      }
      
      // Filter by service
      if (filters.serviceId != null && booking.serviceId != filters.serviceId) {
        return false;
      }
      
      return true;
    }).toList();
  }
  
  /// Get bookings by status
  static List<Booking> getBookingsByStatus(AppState state, BookingStatus status) {
    return getBookings(state).where((booking) => booking.status == status).toList();
  }
  
  /// Get pending bookings
  static List<Booking> getPendingBookings(AppState state) {
    return getBookingsByStatus(state, BookingStatus.pending);
  }
  
  /// Get confirmed bookings
  static List<Booking> getConfirmedBookings(AppState state) {
    return getBookingsByStatus(state, BookingStatus.confirmed);
  }
  
  /// Get in-progress bookings
  static List<Booking> getInProgressBookings(AppState state) {
    return getBookingsByStatus(state, BookingStatus.inProgress);
  }
  
  /// Get booking by ID
  static Booking? getBookingById(AppState state, String id) {
    return getBookings(state).where((booking) => booking.id == id).firstOrNull;
  }
  
  // ============================================================================
  // CLEANER SELECTORS
  // ============================================================================
  
  /// Get all cleaners
  static List<Cleaner> getCleaners(AppState state) {
    return getHousekeepingState(state).cleaners;
  }
  
  /// Get selected cleaner
  static Cleaner? getSelectedCleaner(AppState state) {
    return getHousekeepingState(state).selectedCleaner;
  }
  
  /// Get cleaner filters
  static CleanerFilters getCleanerFilters(AppState state) {
    return getHousekeepingState(state).cleanerFilters;
  }
  
  /// Get filtered cleaners based on current filters
  static List<Cleaner> getFilteredCleaners(AppState state) {
    final cleaners = getCleaners(state);
    final filters = getCleanerFilters(state);
    
    return cleaners.where((cleaner) {
      // Filter by status
      if (filters.status != null && cleaner.status != filters.status) {
        return false;
      }
      
      // Filter by availability
      if (filters.isAvailable != null && cleaner.isAvailable != filters.isAvailable) {
        return false;
      }
      
      // Filter by specialties
      if (filters.specialties.isNotEmpty) {
        final hasSpecialty = filters.specialties.any((specialty) => 
            cleaner.specialties.contains(specialty));
        if (!hasSpecialty) {
          return false;
        }
      }
      
      // Filter by minimum rating
      if (filters.minRating != null && cleaner.rating < filters.minRating!) {
        return false;
      }
      
      return true;
    }).toList();
  }
  
  /// Get available cleaners
  static List<Cleaner> getAvailableCleaners(AppState state) {
    return getCleaners(state).where((cleaner) => 
        cleaner.isAvailable && cleaner.status == CleanerStatus.active).toList();
  }
  
  /// Get active cleaners
  static List<Cleaner> getActiveCleanersOnly(AppState state) {
    return getCleaners(state).where((cleaner) => cleaner.status == CleanerStatus.active).toList();
  }
  
  /// Get cleaner by ID
  static Cleaner? getCleanerById(AppState state, String id) {
    return getCleaners(state).where((cleaner) => cleaner.id == id).firstOrNull;
  }
  
  // ============================================================================
  // CUSTOMER SELECTORS
  // ============================================================================
  
  /// Get all customers
  static List<Customer> getCustomers(AppState state) {
    return getHousekeepingState(state).customers;
  }
  
  /// Get selected customer
  static Customer? getSelectedCustomer(AppState state) {
    return getHousekeepingState(state).selectedCustomer;
  }
  
  /// Get customer filters
  static CustomerFilters getCustomerFilters(AppState state) {
    return getHousekeepingState(state).customerFilters;
  }
  
  /// Get filtered customers based on current filters
  static List<Customer> getFilteredCustomers(AppState state) {
    final customers = getCustomers(state);
    final filters = getCustomerFilters(state);
    
    return customers.where((customer) {
      // Filter by active status
      if (filters.isActive != null && customer.isActive != filters.isActive) {
        return false;
      }
      
      // Filter by minimum bookings
      if (filters.minBookings != null && customer.totalBookings < filters.minBookings!) {
        return false;
      }
      
      return true;
    }).toList();
  }
  
  /// Get active customers
  static List<Customer> getActiveCustomers(AppState state) {
    return getCustomers(state).where((customer) => customer.isActive).toList();
  }
  
  /// Get customer by ID
  static Customer? getCustomerById(AppState state, String id) {
    return getCustomers(state).where((customer) => customer.id == id).firstOrNull;
  }
  
  // ============================================================================
  // SERVICE SELECTORS
  // ============================================================================
  
  /// Get all services
  static List<HousekeepingService> getServices(AppState state) {
    return getHousekeepingState(state).services;
  }
  
  /// Get selected service
  static HousekeepingService? getSelectedService(AppState state) {
    return getHousekeepingState(state).selectedService;
  }
  
  /// Get active services
  static List<HousekeepingService> getActiveServices(AppState state) {
    return getServices(state).where((service) => service.isActive).toList();
  }
  
  /// Get services by category
  static List<HousekeepingService> getServicesByCategory(AppState state, ServiceCategory category) {
    return getServices(state).where((service) => service.category == category).toList();
  }
  
  /// Get service by ID
  static HousekeepingService? getServiceById(AppState state, String id) {
    return getServices(state).where((service) => service.id == id).firstOrNull;
  }
  
  // ============================================================================
  // COMPUTED SELECTORS
  // ============================================================================
  
  /// Get bookings for a specific cleaner
  static List<Booking> getBookingsForCleaner(AppState state, String cleanerId) {
    return getBookings(state).where((booking) => booking.cleanerId == cleanerId).toList();
  }
  
  /// Get bookings for a specific customer
  static List<Booking> getBookingsForCustomer(AppState state, String customerId) {
    return getBookings(state).where((booking) => booking.customerId == customerId).toList();
  }
  
  /// Get bookings for a specific service
  static List<Booking> getBookingsForService(AppState state, String serviceId) {
    return getBookings(state).where((booking) => booking.serviceId == serviceId).toList();
  }
  
  /// Get today's bookings
  static List<Booking> getTodaysBookings(AppState state) {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));
    
    return getBookings(state).where((booking) =>
        booking.scheduledDate.isAfter(startOfDay) &&
        booking.scheduledDate.isBefore(endOfDay)).toList();
  }
  
  /// Get this week's bookings
  static List<Booking> getThisWeeksBookings(AppState state) {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final endOfWeek = startOfWeek.add(const Duration(days: 7));
    
    return getBookings(state).where((booking) =>
        booking.scheduledDate.isAfter(startOfWeek) &&
        booking.scheduledDate.isBefore(endOfWeek)).toList();
  }
  
  /// Get revenue for current month
  static double getCurrentMonthRevenue(AppState state) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 1);
    
    return getBookings(state)
        .where((booking) =>
            booking.status == BookingStatus.completed &&
            booking.completedAt != null &&
            booking.completedAt!.isAfter(startOfMonth) &&
            booking.completedAt!.isBefore(endOfMonth))
        .fold(0.0, (sum, booking) => sum + booking.totalPrice);
  }
  
  /// Get cleaner utilization rate
  static double getCleanerUtilization(AppState state, String cleanerId) {
    final cleanerBookings = getBookingsForCleaner(state, cleanerId);
    final completedBookings = cleanerBookings.where((booking) => 
        booking.status == BookingStatus.completed).length;
    
    if (cleanerBookings.isEmpty) return 0.0;
    return completedBookings / cleanerBookings.length;
  }
}
