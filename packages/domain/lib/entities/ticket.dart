import 'base_entity.dart';

class Ticket extends BaseEntity {
  final String subject;
  final String content;
  final String? statusId;
  final String? priorityId;
  final String? categoryId;
  final String? userId;
  final String? agentId;
  final DateTime? completedAt;
  final DateTime? deletedAt;

  Ticket({
    required super.id,
    required this.subject,
    required this.content,
    this.statusId,
    this.priorityId,
    this.categoryId,
    this.userId,
    this.agentId,
    this.completedAt,
    super.createdAt,
    super.updatedAt,
    this.deletedAt,
  });
}
