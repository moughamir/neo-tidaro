import 'package:domain/domain.dart' as domain;
import 'package:supabase_flutter/supabase_flutter.dart' as supabase;

/// Adapter to convert between Supabase User and domain User entities
class UserAdapter {
  /// Convert Supabase User to domain User
  static domain.User fromSupabaseUser(
    supabase.User supabaseUser, {
    String? fullName,
    domain.PhoneVO? phone,
    String? avatarUrl,
    domain.PlatformUserRole role = domain.PlatformUserRole.clientConsumer,
    domain.PlatformUserStatus status = domain.PlatformUserStatus.active,
    DateTime? lastLoginAt,
  }) {
    return domain.User(
      id: supabaseUser.id,
      createdAt: _parseDateTime(supabaseUser.createdAt),
      updatedAt: _parseDateTime(supabaseUser.updatedAt),
      email: domain.EmailVO.create(supabaseUser.email ?? ''),
      fullName: fullName ?? supabaseUser.userMetadata?['full_name'] as String?,
      phone: phone,
      avatarUrl: avatarUrl ?? supabaseUser.userMetadata?['avatar_url'] as String?,
      role: role,
      status: status,
      lastLoginAt: lastLoginAt ?? _parseDateTime(supabaseUser.lastSignInAt),
      emailVerifiedAt: _parseDateTime(supabaseUser.emailConfirmedAt),
      phoneVerifiedAt: _parseDateTime(supabaseUser.phoneConfirmedAt),
      supabaseUserId: supabaseUser.id,
      appMetadata: supabaseUser.appMetadata,
      userMetadata: supabaseUser.userMetadata,
    );
  }

  /// Helper method to parse DateTime from various formats
  static DateTime? _parseDateTime(dynamic value) {
    if (value == null) return null;
    if (value is DateTime) return value;
    if (value is String) {
      try {
        return DateTime.parse(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  /// Extract user metadata for Supabase operations
  static Map<String, dynamic> toSupabaseUserMetadata(domain.User user) {
    return {
      'full_name': user.fullName,
      'avatar_url': user.avatarUrl,
      'role': user.role.name,
      'status': user.status.name,
      if (user.phone != null) 'phone': user.phone!.value,
    };
  }

  /// Create user attributes for Supabase auth operations
  static supabase.UserAttributes toSupabaseUserAttributes(domain.User user) {
    return supabase.UserAttributes(
      email: user.email.value,
      data: toSupabaseUserMetadata(user),
    );
  }
}
