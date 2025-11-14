import 'dart:io';

import 'package:domain/domain.dart' as domain;
import 'package:fpdart/fpdart.dart';
import 'package:shared/utils/failures/failure.dart';
import 'package:shared/utils/logger.dart';
import 'package:shared/utils/type_defs.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_repository.dart';

/// Supabase implementation of user repository
class SupabaseUserRepository
    extends SupabaseRepository<domain.User, domain.CreateUserDto, domain.UpdateUserDto> {
  SupabaseUserRepository(SupabaseClient client) : super('profiles', client);

  @override
  domain.User fromJson(Map<String, dynamic> json) {
    return domain.User(
      id: json['id'] as String,
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
          : null,
      email: domain.EmailVO.create(json['email'] as String),
      fullName: json['full_name'] as String?,
      phone: json['phone_number'] != null
          ? domain.PhoneVO.create(json['phone_number'] as String)
          : null,
      avatarUrl: json['avatar_url'] as String?,
      role: domain.PlatformUserRole.values.firstWhere(
        (role) => role.name == json['role'],
        orElse: () => domain.PlatformUserRole.clientConsumer,
      ),
      status: domain.PlatformUserStatus.values.firstWhere(
        (status) => status.name == json['status'],
        orElse: () => domain.PlatformUserStatus.active,
      ),
      lastLoginAt: json['last_login_at'] != null
          ? DateTime.parse(json['last_login_at'] as String)
          : null,
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'] as String)
          : null,
      phoneVerifiedAt: json['phone_verified_at'] != null
          ? DateTime.parse(json['phone_verified_at'] as String)
          : null,
      supabaseUserId: json['supabase_user_id'] as String?,
      appMetadata: json['app_metadata'] != null 
          ? Map<String, dynamic>.from(json['app_metadata'] as Map)
          : <String, dynamic>{},
      userMetadata: json['user_metadata'] != null
          ? Map<String, dynamic>.from(json['user_metadata'] as Map)
          : <String, dynamic>{},
    );
  }

  @override
  Map<String, dynamic> toJson(domain.User entity) {
    return {
      'id': entity.id,
      'email': entity.email.value,
      'full_name': entity.fullName,
      'phone_number': entity.phone?.value,
      'role': entity.role.name,
      'status': entity.status.name,
      'created_at': entity.createdAt?.toIso8601String(),
      'updated_at': entity.updatedAt?.toIso8601String(),
    };
  }

  /// Get user by email
  ResultFuture<domain.User> getUserByEmail(String email) async {
    try {
      final response = await client
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
  ResultFuture<domain.User> updateProfileWithAvatar(
    String userId,
    domain.UpdateUserDto updateDto,
    File? avatarFile,
  ) async {
    try {
      String? avatarUrl;

      // Upload avatar if provided
      if (avatarFile != null) {
        final fileName =
            'avatar_${userId}_${DateTime.now().millisecondsSinceEpoch}';
        await client.storage
            .from('avatars')
            .upload('$userId/$fileName', avatarFile);

        avatarUrl = client.storage
            .from('avatars')
            .getPublicUrl('$userId/$fileName');
      }

      // Update profile with new avatar URL if uploaded
      final updateData = updateDto.toJson();
      if (avatarUrl != null) {
        updateData['avatar_url'] = avatarUrl;
      }

      final response = await client
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
  ResultFuture<List<domain.User>> searchUsers(String query) async {
    try {
      final response = await client
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

// DTOs are now defined in domain package to avoid duplicates
