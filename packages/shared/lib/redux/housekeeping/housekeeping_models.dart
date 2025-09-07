import 'package:equatable/equatable.dart';

/// Represents a housekeeping service offering
class HousekeepingService extends Equatable {
  const HousekeepingService({
    required this.id,
    required this.name,
    required this.description,
    required this.basePrice,
    required this.duration,
    required this.category,
    this.isActive = true,
    this.imageUrl,
    this.requirements = const [],
    this.addOns = const [],
  });

  final String id;
  final String name;
  final String description;
  final double basePrice;
  final Duration duration;
  final ServiceCategory category;
  final bool isActive;
  final String? imageUrl;
  final List<String> requirements;
  final List<ServiceAddOn> addOns;

  HousekeepingService copyWith({
    String? id,
    String? name,
    String? description,
    double? basePrice,
    Duration? duration,
    ServiceCategory? category,
    bool? isActive,
    String? imageUrl,
    List<String>? requirements,
    List<ServiceAddOn>? addOns,
  }) {
    return HousekeepingService(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      basePrice: basePrice ?? this.basePrice,
      duration: duration ?? this.duration,
      category: category ?? this.category,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
      requirements: requirements ?? this.requirements,
      addOns: addOns ?? this.addOns,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        basePrice,
        duration,
        category,
        isActive,
        imageUrl,
        requirements,
        addOns,
      ];
}

/// Service add-on for additional features
class ServiceAddOn extends Equatable {
  const ServiceAddOn({
    required this.id,
    required this.name,
    required this.price,
    this.description,
  });

  final String id;
  final String name;
  final double price;
  final String? description;

  @override
  List<Object?> get props => [id, name, price, description];
}

/// Categories for housekeeping services
enum ServiceCategory {
  regularCleaning,
  deepCleaning,
  moveInOut,
  postConstruction,
  commercial,
  specialized,
}

/// Represents a booking for housekeeping services
class Booking extends Equatable {
  const Booking({
    required this.id,
    required this.customerId,
    required this.serviceId,
    required this.scheduledDate,
    required this.status,
    required this.address,
    required this.totalPrice,
    required this.createdAt,
    this.cleanerId,
    this.notes,
    this.addOns = const [],
    this.completedAt,
    this.rating,
    this.review,
    this.paymentStatus = PaymentStatus.pending,
  });

  final String id;
  final String customerId;
  final String serviceId;
  final DateTime scheduledDate;
  final BookingStatus status;
  final Address address;
  final double totalPrice;
  final DateTime createdAt;
  final String? cleanerId;
  final String? notes;
  final List<String> addOns;
  final DateTime? completedAt;
  final int? rating;
  final String? review;
  final PaymentStatus paymentStatus;

  Booking copyWith({
    String? id,
    String? customerId,
    String? serviceId,
    DateTime? scheduledDate,
    BookingStatus? status,
    Address? address,
    double? totalPrice,
    DateTime? createdAt,
    String? cleanerId,
    String? notes,
    List<String>? addOns,
    DateTime? completedAt,
    int? rating,
    String? review,
    PaymentStatus? paymentStatus,
  }) {
    return Booking(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      serviceId: serviceId ?? this.serviceId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      status: status ?? this.status,
      address: address ?? this.address,
      totalPrice: totalPrice ?? this.totalPrice,
      createdAt: createdAt ?? this.createdAt,
      cleanerId: cleanerId ?? this.cleanerId,
      notes: notes ?? this.notes,
      addOns: addOns ?? this.addOns,
      completedAt: completedAt ?? this.completedAt,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      paymentStatus: paymentStatus ?? this.paymentStatus,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        serviceId,
        scheduledDate,
        status,
        address,
        totalPrice,
        createdAt,
        cleanerId,
        notes,
        addOns,
        completedAt,
        rating,
        review,
        paymentStatus,
      ];
}

/// Booking status enumeration
enum BookingStatus {
  pending,
  confirmed,
  assigned,
  inProgress,
  completed,
  cancelled,
  rescheduled,
}

/// Payment status enumeration
enum PaymentStatus {
  pending,
  paid,
  failed,
  refunded,
}

/// Represents a cleaner/staff member
class Cleaner extends Equatable {
  const Cleaner({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.status,
    required this.joinedAt,
    this.profileImageUrl,
    this.address,
    this.specialties = const [],
    this.rating = 0.0,
    this.totalJobs = 0,
    this.isAvailable = true,
    this.hourlyRate,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final CleanerStatus status;
  final DateTime joinedAt;
  final String? profileImageUrl;
  final Address? address;
  final List<ServiceCategory> specialties;
  final double rating;
  final int totalJobs;
  final bool isAvailable;
  final double? hourlyRate;

  String get fullName => '$firstName $lastName';

  Cleaner copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    CleanerStatus? status,
    DateTime? joinedAt,
    String? profileImageUrl,
    Address? address,
    List<ServiceCategory>? specialties,
    double? rating,
    int? totalJobs,
    bool? isAvailable,
    double? hourlyRate,
  }) {
    return Cleaner(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      joinedAt: joinedAt ?? this.joinedAt,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      address: address ?? this.address,
      specialties: specialties ?? this.specialties,
      rating: rating ?? this.rating,
      totalJobs: totalJobs ?? this.totalJobs,
      isAvailable: isAvailable ?? this.isAvailable,
      hourlyRate: hourlyRate ?? this.hourlyRate,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        status,
        joinedAt,
        profileImageUrl,
        address,
        specialties,
        rating,
        totalJobs,
        isAvailable,
        hourlyRate,
      ];
}

/// Cleaner status enumeration
enum CleanerStatus {
  active,
  inactive,
  suspended,
  pending,
}

/// Represents a customer
class Customer extends Equatable {
  const Customer({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.createdAt,
    this.profileImageUrl,
    this.addresses = const [],
    this.totalBookings = 0,
    this.isActive = true,
    this.preferredCleanerId,
    this.notes,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final DateTime createdAt;
  final String? profileImageUrl;
  final List<Address> addresses;
  final int totalBookings;
  final bool isActive;
  final String? preferredCleanerId;
  final String? notes;

  String get fullName => '$firstName $lastName';

  Customer copyWith({
    String? id,
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    DateTime? createdAt,
    String? profileImageUrl,
    List<Address>? addresses,
    int? totalBookings,
    bool? isActive,
    String? preferredCleanerId,
    String? notes,
  }) {
    return Customer(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      addresses: addresses ?? this.addresses,
      totalBookings: totalBookings ?? this.totalBookings,
      isActive: isActive ?? this.isActive,
      preferredCleanerId: preferredCleanerId ?? this.preferredCleanerId,
      notes: notes ?? this.notes,
    );
  }

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        phone,
        createdAt,
        profileImageUrl,
        addresses,
        totalBookings,
        isActive,
        preferredCleanerId,
        notes,
      ];
}

/// Represents an address
class Address extends Equatable {
  const Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    this.country = 'US',
    this.apartment,
    this.instructions,
    this.isDefault = false,
  });

  final String street;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String? apartment;
  final String? instructions;
  final bool isDefault;

  String get fullAddress {
    final apt = apartment != null ? ', $apartment' : '';
    return '$street$apt, $city, $state $zipCode';
  }

  Address copyWith({
    String? street,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    String? apartment,
    String? instructions,
    bool? isDefault,
  }) {
    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      apartment: apartment ?? this.apartment,
      instructions: instructions ?? this.instructions,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  List<Object?> get props => [
        street,
        city,
        state,
        zipCode,
        country,
        apartment,
        instructions,
        isDefault,
      ];
}

/// Housekeeping-specific dashboard metrics
class HousekeepingMetrics extends Equatable {
  const HousekeepingMetrics({
    required this.totalBookings,
    required this.activeBookings,
    required this.completedBookings,
    required this.totalRevenue,
    required this.monthlyRevenue,
    required this.totalCustomers,
    required this.activeCleaners,
    required this.averageRating,
    required this.bookingGrowthRate,
    required this.revenueGrowthRate,
    this.recentActivities = const [],
    this.upcomingBookings = const [],
  });

  final int totalBookings;
  final int activeBookings;
  final int completedBookings;
  final double totalRevenue;
  final double monthlyRevenue;
  final int totalCustomers;
  final int activeCleaners;
  final double averageRating;
  final double bookingGrowthRate;
  final double revenueGrowthRate;
  final List<HousekeepingActivity> recentActivities;
  final List<Booking> upcomingBookings;

  HousekeepingMetrics copyWith({
    int? totalBookings,
    int? activeBookings,
    int? completedBookings,
    double? totalRevenue,
    double? monthlyRevenue,
    int? totalCustomers,
    int? activeCleaners,
    double? averageRating,
    double? bookingGrowthRate,
    double? revenueGrowthRate,
    List<HousekeepingActivity>? recentActivities,
    List<Booking>? upcomingBookings,
  }) {
    return HousekeepingMetrics(
      totalBookings: totalBookings ?? this.totalBookings,
      activeBookings: activeBookings ?? this.activeBookings,
      completedBookings: completedBookings ?? this.completedBookings,
      totalRevenue: totalRevenue ?? this.totalRevenue,
      monthlyRevenue: monthlyRevenue ?? this.monthlyRevenue,
      totalCustomers: totalCustomers ?? this.totalCustomers,
      activeCleaners: activeCleaners ?? this.activeCleaners,
      averageRating: averageRating ?? this.averageRating,
      bookingGrowthRate: bookingGrowthRate ?? this.bookingGrowthRate,
      revenueGrowthRate: revenueGrowthRate ?? this.revenueGrowthRate,
      recentActivities: recentActivities ?? this.recentActivities,
      upcomingBookings: upcomingBookings ?? this.upcomingBookings,
    );
  }

  @override
  List<Object?> get props => [
        totalBookings,
        activeBookings,
        completedBookings,
        totalRevenue,
        monthlyRevenue,
        totalCustomers,
        activeCleaners,
        averageRating,
        bookingGrowthRate,
        revenueGrowthRate,
        recentActivities,
        upcomingBookings,
      ];
}

/// Activity item specific to housekeeping operations
class HousekeepingActivity extends Equatable {
  const HousekeepingActivity({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    required this.type,
    this.bookingId,
    this.customerId,
    this.cleanerId,
  });

  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final HousekeepingActivityType type;
  final String? bookingId;
  final String? customerId;
  final String? cleanerId;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        timestamp,
        type,
        bookingId,
        customerId,
        cleanerId,
      ];
}

/// Activity types specific to housekeeping operations
enum HousekeepingActivityType {
  bookingCreated,
  bookingConfirmed,
  bookingCompleted,
  bookingCancelled,
  bookingRescheduled,
  cleanerAssigned,
  cleanerUnassigned,
  paymentReceived,
  reviewSubmitted,
  customerRegistered,
  cleanerRegistered,
}
