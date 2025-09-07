import 'package:equatable/equatable.dart';
import 'package:shared/domain/domain.dart';

/// General user profile mapped to Supabase public.profiles
class Profile extends Equatable {
  const Profile({
    required this.id,
    required this.fullName,
    this.avatarUrl,
    this.phoneNumber,
    required this.role,
    this.cleanerStatus, // meaningful for clientProvider
    this.createdAt,
    this.updatedAt,
  });

  final String id; // UUID
  final String fullName;
  final String? avatarUrl;
  final String? phoneNumber;
  final UserRole role;
  final CleanerStatus? cleanerStatus; // available, onJob, offline, onBreak
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Profile copyWith({
    String? id,
    String? fullName,
    String? avatarUrl,
    String? phoneNumber,
    UserRole? role,
    CleanerStatus? cleanerStatus,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Profile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      cleanerStatus: cleanerStatus ?? this.cleanerStatus,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    fullName,
    avatarUrl,
    phoneNumber,
    role,
    cleanerStatus,
    createdAt,
    updatedAt,
  ];
}

class ProfileModel extends ProfileEntity {
  final List<String> skills;
  final List<ServiceModel> offeredServices;
  final List<AvailabilitySlotModel> availabilitySlots;

  const ProfileModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.email,
    required super.firstName,
    required super.lastName,
    super.phoneNumber,
    super.dateOfBirth,
    super.avatarUrl,
    super.role,
    super.isAvailable,
    this.skills = const [],
    this.offeredServices = const [],
    this.availabilitySlots = const [],
  });

  @override
  List<Object?> get props => [
    ...super.props,
    skills,
    offeredServices,
    availabilitySlots,
  ];
}
