import 'package:shared/domain/domain.dart';

abstract class ProfileEntity extends Entity {
  final String email;
  final String firstName;
  final String lastName;
  final String? phoneNumber;
  final DateTime? dateOfBirth;
  final String? avatarUrl;
  final UserRole role;
  final bool isAvailable;

  const ProfileEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.phoneNumber,
    this.dateOfBirth,
    this.avatarUrl,
    this.role = UserRole.clientConsumer,
    this.isAvailable = true,
  });

  @override
  List<Object?> get props => [
    ...super.props,
    email,
    firstName,
    lastName,
    phoneNumber,
    dateOfBirth,
    avatarUrl,
    role,
    isAvailable,
  ];
}
