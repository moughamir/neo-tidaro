import 'package:equatable/equatable.dart';

class AdminUser extends Equatable {
  const AdminUser({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.role,
    required this.professionalStatus,
    required this.createdAt,
  });

  final String id;
  final String? fullName;
  final String? phoneNumber;
  final String role; // user_role_enum as string
  final String professionalStatus; // professional_status_enum as string
  final DateTime createdAt;

  AdminUser copyWith({
    String? role,
    String? professionalStatus,
  }) => AdminUser(
        id: id,
        fullName: fullName,
        phoneNumber: phoneNumber,
        role: role ?? this.role,
        professionalStatus: professionalStatus ?? this.professionalStatus,
        createdAt: createdAt,
      );

  @override
  List<Object?> get props => [id, fullName, phoneNumber, role, professionalStatus, createdAt];
}

// Load users
class LoadAdminUsersRequest extends Equatable {
  const LoadAdminUsersRequest({
    this.roleFilter,
    this.searchQuery,
    this.page = 1,
    this.pageSize = 20,
  });
  final String? roleFilter; // optional role
  final String? searchQuery; // optional search on full_name/phone_number
  final int page; // 1-based
  final int pageSize;
  @override
  List<Object?> get props => [roleFilter, searchQuery, page, pageSize];
}

class LoadAdminUsersSuccess extends Equatable {
  const LoadAdminUsersSuccess(this.items, this.totalCount);
  final List<AdminUser> items;
  final int totalCount;
  @override
  List<Object?> get props => [items, totalCount];
}

class LoadAdminUsersFailure extends Equatable {
  const LoadAdminUsersFailure(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}

// Updates
class UpdateAdminUserRoleRequest extends Equatable {
  const UpdateAdminUserRoleRequest(this.userId, this.role);
  final String userId;
  final String role;
  @override
  List<Object?> get props => [userId, role];
}

class UpdateAdminUserRoleSuccess extends Equatable {
  const UpdateAdminUserRoleSuccess(this.userId, this.role);
  final String userId;
  final String role;
  @override
  List<Object?> get props => [userId, role];
}

class UpdateAdminUserRoleFailure extends Equatable {
  const UpdateAdminUserRoleFailure(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}

class UpdateAdminUserStatusRequest extends Equatable {
  const UpdateAdminUserStatusRequest(this.userId, this.professionalStatus);
  final String userId;
  final String professionalStatus;
  @override
  List<Object?> get props => [userId, professionalStatus];
}

class UpdateAdminUserStatusSuccess extends Equatable {
  const UpdateAdminUserStatusSuccess(this.userId, this.professionalStatus);
  final String userId;
  final String professionalStatus;
  @override
  List<Object?> get props => [userId, professionalStatus];
}

class UpdateAdminUserStatusFailure extends Equatable {
  const UpdateAdminUserStatusFailure(this.error);
  final String error;
  @override
  List<Object?> get props => [error];
}
