import '../enums/user_role.dart';

/// Enum mappers between Supabase (snake_case strings) and Domain (camelCase enums)

// -------------------- UserRole --------------------
// Note: Profile currently defines its own UserRole enum.
// Map SQL directly to UserRole to avoid type mismatches.
UserRole userRoleFromSql(String value) {
  switch (value) {
    case 'admin':
      return UserRole.admin;
    case 'moderator':
      return UserRole.moderator;
    case 'client_consumer':
      return UserRole.clientConsumer;
    case 'client_provider':
      return UserRole.clientProfessional;
    default:
      return UserRole.clientConsumer;
  }
}

String userRoleToSql(UserRole value) {
  switch (value) {
    case UserRole.admin:
      return 'admin';
    case UserRole.moderator:
      return 'moderator';
    case UserRole.clientConsumer:
      return 'client_consumer';
    case UserRole.clientProfessional:
      return 'client_provider';
    case UserRole.superAdmin:
      return 'super_admin';
  }
}
