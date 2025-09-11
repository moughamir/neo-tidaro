import '../entities/entities.dart';

abstract class AuditLogRepository {
  Future<List<ActivityLog>> findAll();
  Future<ActivityLog> log(ActivityLog log);
}
