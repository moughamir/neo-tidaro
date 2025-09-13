import '../../enums/enums.dart';
import '../base_entity.dart';

/// Support ticket entity for customer service
class Ticket extends BaseEntity {
  const Ticket({
    required super.id,
    required this.title,
    required this.description,
    this.userId,
    this.agentId,
    this.status = TicketStatus.open,
    this.priority = TicketPriority.medium,
    this.completedAt,
    super.createdAt,
    super.updatedAt,
    this.deletedAt,
  });
  final String title;
  final String description;
  final String? userId;
  final String? agentId;
  final TicketStatus status;
  final TicketPriority priority;
  final DateTime? completedAt;
  final DateTime? deletedAt;
}

/// Comment entity for ticket discussions
class Comment extends BaseEntity {
  const Comment({
    required super.id,
    required this.content,
    this.userId,
    this.ticketId,
    super.createdAt,
    super.updatedAt,
  });
  final String content;
  final String? userId;
  final String? ticketId;
}

/// Ticket option entity for categorization
class TicketOption extends BaseEntity {
  const TicketOption({
    required super.id,
    required this.type,
    required this.name,
    this.color,
  });
  final SupportTicketOptionType type;
  final String name;
  final String? color;
}

/// Ticket status enum
enum TicketStatus { open, inProgress, resolved, closed }

/// Ticket priority enum
enum TicketPriority { low, medium, high, urgent }
