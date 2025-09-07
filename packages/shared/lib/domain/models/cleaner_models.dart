import 'package:equatable/equatable.dart';
import 'booking_models.dart';

/// Cleaner status enumeration
enum CleanerStatus {
  available,
  onJob,
  offline,
  onBreak,
}

/// Cleaner model
class Cleaner extends Equatable {
  const Cleaner({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.status,
    required this.serviceCategories,
    this.profileImageUrl,
    this.rating,
    this.totalBookings,
    this.joinedDate,
    this.isVerified = false,
  });

  final String id;
  final String name;
  final String email;
  final String phone;
  final CleanerStatus status;
  final List<ServiceCategory> serviceCategories;
  final String? profileImageUrl;
  final double? rating;
  final int? totalBookings;
  final DateTime? joinedDate;
  final bool isVerified;

  Cleaner copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    CleanerStatus? status,
    List<ServiceCategory>? serviceCategories,
    String? profileImageUrl,
    double? rating,
    int? totalBookings,
    DateTime? joinedDate,
    bool? isVerified,
  }) {
    return Cleaner(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      status: status ?? this.status,
      serviceCategories: serviceCategories ?? this.serviceCategories,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      rating: rating ?? this.rating,
      totalBookings: totalBookings ?? this.totalBookings,
      joinedDate: joinedDate ?? this.joinedDate,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phone,
        status,
        serviceCategories,
        profileImageUrl,
        rating,
        totalBookings,
        joinedDate,
        isVerified,
      ];
}

/// Cleaner filters model
class CleanerFilters extends Equatable {
  const CleanerFilters({
    this.status,
    this.serviceCategories,
    this.minRating,
    this.isVerified,
  });

  final CleanerStatus? status;
  final List<ServiceCategory>? serviceCategories;
  final double? minRating;
  final bool? isVerified;

  CleanerFilters copyWith({
    CleanerStatus? status,
    List<ServiceCategory>? serviceCategories,
    double? minRating,
    bool? isVerified,
  }) {
    return CleanerFilters(
      status: status ?? this.status,
      serviceCategories: serviceCategories ?? this.serviceCategories,
      minRating: minRating ?? this.minRating,
      isVerified: isVerified ?? this.isVerified,
    );
  }

  @override
  List<Object?> get props => [
        status,
        serviceCategories,
        minRating,
        isVerified,
      ];
}
