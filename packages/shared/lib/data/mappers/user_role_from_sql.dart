import 'package:shared/domain/domain.dart';

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
      return UserRole.clientProvider;
    default:
      return UserRole.clientConsumer;
  }
}
