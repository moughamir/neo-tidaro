import '../enums/user_role.dart';

/// Enum mappers between Supabase (snake_case strings) and Domain (camelCase enums)

// -------------------- UserRole --------------------
// Note: Profile currently defines its own UserRole enum.
// Map SQL directly to UserRole to avoid type mismatches.
PlatformUserRole userRoleFromSql(String value) {
  switch (value) {
    case 'admin':
      return PlatformUserRole.admin;
    case 'moderator':
      return PlatformUserRole.moderator;
    case 'client_consumer':
      return PlatformUserRole.clientConsumer;
    case 'client_provider':
      return PlatformUserRole.clientProfessional;
    default:
      return PlatformUserRole.clientConsumer;
  }
}

String userRoleToSql(PlatformUserRole value) {
  switch (value) {
    case PlatformUserRole.admin:
      return 'admin';
    case PlatformUserRole.moderator:
      return 'moderator';
    case PlatformUserRole.clientConsumer:
      return 'client_consumer';
    case PlatformUserRole.clientProfessional:
      return 'client_provider';
    case PlatformUserRole.superAdmin:
      return 'super_admin';
  }
}
