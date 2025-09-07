import 'package:equatable/equatable.dart';

/// Booking status enumeration
enum BookingStatus {
  pending,
  confirmed,
  assigned,
  inProgress,
  completed,
  cancelled,
  rescheduled,
  noShow,
}

/// Service category enumeration
enum ServiceCategory {
  standardCleaning,
  regularCleaning,
  deepCleaning,
  moveInOut,
  postConstruction,
  commercial,
  residential,
  specialized,
}

/// Booking model
class Booking extends Equatable {
  const Booking({
    required this.id,
    required this.customerId,
    required this.serviceCategory,
    required this.address,
    required this.scheduledDate,
    required this.status,
    required this.price,
    this.cleanerId,
    this.notes,
    this.estimatedDuration,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String customerId;
  final String? cleanerId;
  final ServiceCategory serviceCategory;
  final Address address;
  final DateTime scheduledDate;
  final BookingStatus status;
  final double price;
  final String? notes;
  final Duration? estimatedDuration;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Booking copyWith({
    String? id,
    String? customerId,
    String? cleanerId,
    ServiceCategory? serviceCategory,
    Address? address,
    DateTime? scheduledDate,
    BookingStatus? status,
    double? price,
    String? notes,
    Duration? estimatedDuration,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Booking(
      id: id ?? this.id,
      customerId: customerId ?? this.customerId,
      cleanerId: cleanerId ?? this.cleanerId,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      address: address ?? this.address,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      status: status ?? this.status,
      price: price ?? this.price,
      notes: notes ?? this.notes,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        customerId,
        cleanerId,
        serviceCategory,
        address,
        scheduledDate,
        status,
        price,
        notes,
        estimatedDuration,
        createdAt,
        updatedAt,
      ];
}

/// Address model
class Address extends Equatable {
  const Address({
    required this.street,
    required this.city,
    required this.state,
    required this.zipCode,
    this.country = 'US',
    this.apartment,
    this.instructions,
  });

  final String street;
  final String? apartment;
  final String city;
  final String state;
  final String zipCode;
  final String country;
  final String? instructions;

  String get fullAddress {
    final parts = <String>[
      if (apartment != null) '$street, $apartment' else street,
      city,
      '$state $zipCode',
    ];
    return parts.join(', ');
  }

  Address copyWith({
    String? street,
    String? apartment,
    String? city,
    String? state,
    String? zipCode,
    String? country,
    String? instructions,
  }) {
    return Address(
      street: street ?? this.street,
      apartment: apartment ?? this.apartment,
      city: city ?? this.city,
      state: state ?? this.state,
      zipCode: zipCode ?? this.zipCode,
      country: country ?? this.country,
      instructions: instructions ?? this.instructions,
    );
  }

  @override
  List<Object?> get props => [
        street,
        apartment,
        city,
        state,
        zipCode,
        country,
        instructions,
      ];
}

/// Booking filters model
class BookingFilters extends Equatable {
  const BookingFilters({
    this.status,
    this.serviceCategory,
    this.dateRange,
    this.customerId,
    this.cleanerId,
  });

  final BookingStatus? status;
  final ServiceCategory? serviceCategory;
  final DateTimeRange? dateRange;
  final String? customerId;
  final String? cleanerId;

  BookingFilters copyWith({
    BookingStatus? status,
    ServiceCategory? serviceCategory,
    DateTimeRange? dateRange,
    String? customerId,
    String? cleanerId,
  }) {
    return BookingFilters(
      status: status ?? this.status,
      serviceCategory: serviceCategory ?? this.serviceCategory,
      dateRange: dateRange ?? this.dateRange,
      customerId: customerId ?? this.customerId,
      cleanerId: cleanerId ?? this.cleanerId,
    );
  }

  @override
  List<Object?> get props => [
        status,
        serviceCategory,
        dateRange,
        customerId,
        cleanerId,
      ];
}

/// Date time range model
class DateTimeRange extends Equatable {
  const DateTimeRange({
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;

  @override
  List<Object?> get props => [start, end];
}
