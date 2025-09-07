import 'package:shared/domain/domain.dart';

String userRoleToSql(UserRole value) {
  switch (value) {
    case UserRole.admin:
      return 'admin';
    case UserRole.moderator:
      return 'moderator';
    case UserRole.clientConsumer:
      return 'client_consumer';
    case UserRole.clientProvider:
      return 'client_provider';
  }
}
