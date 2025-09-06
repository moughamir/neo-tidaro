import 'package:equatable/equatable.dart';
import 'booking_models.dart';

/// Customer model
class Customer extends Equatable {
  const Customer({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.addresses = const [],
    this.profileImageUrl,
    this.totalBookings,
    this.joinedDate,
    this.isActive = true,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final List<Address> addresses;
  final String? profileImageUrl;
  final int? totalBookings;
  final DateTime? joinedDate;
  final bool isActive;

  Customer copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    List<Address>? addresses,
    String? profileImageUrl,
    int? totalBookings,
    DateTime? joinedDate,
    bool? isActive,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      addresses: addresses ?? this.addresses,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      totalBookings: totalBookings ?? this.totalBookings,
      joinedDate: joinedDate ?? this.joinedDate,
      isActive: isActive ?? this.isActive,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        addresses,
        profileImageUrl,
        totalBookings,
        joinedDate,
        isActive,
      ];
}

/// Customer filters model
class CustomerFilters extends Equatable {
  const CustomerFilters({
    this.isActive,
    this.minBookings,
    this.joinedAfter,
  });

  final bool? isActive;
  final int? minBookings;
  final DateTime? joinedAfter;

  CustomerFilters copyWith({
    bool? isActive,
    int? minBookings,
    DateTime? joinedAfter,
  }) {
    return CustomerFilters(
      isActive: isActive ?? this.isActive,
      minBookings: minBookings ?? this.minBookings,
      joinedAfter: joinedAfter ?? this.joinedAfter,
    );
  }

  @override
  List<Object?> get props => [
        isActive,
        minBookings,
        joinedAfter,
      ];
}
