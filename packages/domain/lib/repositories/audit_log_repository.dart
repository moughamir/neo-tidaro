import 'package:domain/domain.dart';

abstract class AuditLogRepository {
  Future<List<ActivityLog>> findAll();
  Future<ActivityLog> log(ActivityLog log);
}
