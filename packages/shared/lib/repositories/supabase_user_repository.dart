import 'dart:io';

import 'package:domain/domain.dart' hide User;
import 'package:fpdart/fpdart.dart';
import 'package:shared/utils/failures/failure.dart';
import 'package:shared/utils/logger.dart';
import 'package:shared/utils/type_defs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_repository.dart';

/// Supabase implementation of user repository
class SupabaseUserRepository
    extends SupabaseRepository<User, CreateUserDto, UpdateUserDto> {
  SupabaseUserRepository(SupabaseClient client) : super('profiles', client);

  @override
  User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as String,
      email: EmailVO.create(json['email'] as String),
      fullName: json['full_name'] as String?,
      phone: json['phone_number'] != null
          ? PhoneVO.create(json['phone_number'] as String)
          : null,
      role: PlatformUserRole.values.firstWhere(
        (role) => role.name == json['role'],
        orElse: () => PlatformUserRole.clientConsumer,
      ),
      status: PlatformUserStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => PlatformUserStatus.active,
      ),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'] as String)
          : null,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'] as String)
          : null,
      phoneVerifiedAt: json['phone_verified_at'] != null
          ? DateTime.parse(json['phone_verified_at'] as String)
          : null,
    );
  }

  @override
  Map<String, dynamic> toJson(User entity) {
    return {
      'id': entity.id,
      'email': entity.email.value,
      'full_name': entity.fullName,
      'phone_number': entity.phone?.value,
      'role': entity.role.name,
      'status': entity.status.name,
      'created_at': entity.createdAt.toIso8601String(),
      'updated_at': entity.updatedAt?.toIso8601String(),
      'last_login_at': entity.lastLoginAt?.toIso8601String(),
      'email_verified_at': entity.emailVerifiedAt?.toIso8601String(),
      'phone_verified_at': entity.phoneVerifiedAt?.toIso8601String(),
    };
  }

  /// Get user by email
  ResultFuture<User> getUserByEmail(String email) async {
    try {
      final response = await _client
          .from(tableName)
          .select()
          .eq('email', email)
          .single();

      return right(fromJson(response));
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to get user by email: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error getting user by email: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Update user profile with avatar upload
  ResultFuture<User> updateProfileWithAvatar(
    String userId,
    UpdateUserDto updateDto,
    File? avatarFile,
  ) async {
    try {
      String? avatarUrl;

      // Upload avatar if provided
      if (avatarFile != null) {
        final fileName =
            'avatar_${userId}_${DateTime.now().millisecondsSinceEpoch}';
        await _client.storage
            .from('avatars')
            .upload('$userId/$fileName', avatarFile);

        avatarUrl = _client.storage
            .from('avatars')
            .getPublicUrl('$userId/$fileName');
      }

      // Update profile with new avatar URL if uploaded
      final updateData = updateDto.toJson();
      if (avatarUrl != null) {
        updateData['avatar_url'] = avatarUrl;
      }

      final response = await _client
          .from(tableName)
          .update(updateData)
          .eq('id', userId)
          .select()
          .single();

      return right(fromJson(response));
    } on StorageException catch (e) {
      CoreLogger.error('Failed to upload avatar: ${e.message}');
      return left(Failure.storage(e.message));
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to update profile: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error updating profile: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }

  /// Search users by name or email
  ResultFuture<List<User>> searchUsers(String query) async {
    try {
      final response = await _client
          .from(tableName)
          .select()
          .or('full_name.ilike.%$query%,email.ilike.%$query%')
          .limit(20);

      return right(
        (response as List<dynamic>)
            .map((json) => fromJson(json as Map<String, dynamic>))
            .toList(),
      );
    } on PostgrestException catch (e) {
      CoreLogger.error('Failed to search users: ${e.message}');
      return left(Failure.database(e.message));
    } catch (e) {
      CoreLogger.error('Unexpected error searching users: $e');
      return left(Failure.unexpected(e.toString()));
    }
  }
}

/// DTOs for user operations
class CreateUserDto {
  const CreateUserDto({
    required this.email,
    this.fullName,
    this.phoneNumber,
    this.role = PlatformUserRole.clientConsumer,
    this.status = PlatformUserStatus.active,
  });

  final String email;
  final String? fullName;
  final String? phoneNumber;
  final PlatformUserRole role;
  final PlatformUserStatus status;

  Map<String, dynamic> toJson() => {
    'email': email,
    'full_name': fullName,
    'phone_number': phoneNumber,
    'role': role.name,
    'status': status.name,
  };
}

class UpdateUserDto {
  const UpdateUserDto({
    this.fullName,
    this.phoneNumber,
    this.role,
    this.status,
  });

  final String? fullName;
  final String? phoneNumber;
  final PlatformUserRole? role;
  final PlatformUserStatus? status;

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (fullName != null) json['full_name'] = fullName;
    if (phoneNumber != null) json['phone_number'] = phoneNumber;
    if (role != null) json['role'] = role!.name;
    if (status != null) json['status'] = status!.name;
    return json;
  }
}
