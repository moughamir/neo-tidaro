import '../../enums/enums.dart';
import '../base_entity.dart';

/// Support ticket entity for customer service
class Ticket extends BaseEntity {
  /// Creates a new instance of [Ticket].
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
  /// The title of the ticket.
  final String title;
  /// A description of the ticket.
  final String description;
  /// The ID of the user who created the ticket.
  final String? userId;
  /// The ID of the agent assigned to the ticket.
  final String? agentId;
  /// The status of the ticket.
  final TicketStatus status;
  /// The priority of the ticket.
  final TicketPriority priority;
  /// The timestamp of when the ticket was completed.
  final DateTime? completedAt;
  /// The timestamp of when the ticket was deleted.
  final DateTime? deletedAt;
}

/// Comment entity for ticket discussions
class Comment extends BaseEntity {
  /// Creates a new instance of [Comment].
  const Comment({
    required super.id,
    required this.content,
    this.userId,
    this.ticketId,
    super.createdAt,
    super.updatedAt,
  });
  /// The content of the comment.
  final String content;
  /// The ID of the user who created the comment.
  final String? userId;
  /// The ID of the ticket this comment belongs to.
  final String? ticketId;
}

/// Ticket option entity for categorization
class TicketOption extends BaseEntity {
  /// Creates a new instance of [TicketOption].
  const TicketOption({
    required super.id,
    required this.type,
    required this.name,
    this.color,
  });
  /// The type of ticket option.
  final SupportTicketOptionType type;
  /// The name of the ticket option.
  final String name;
  /// The color of the ticket option.
  final String? color;
}

/// Ticket status enum
enum TicketStatus { open, inProgress, resolved, closed }

/// Ticket priority enum
enum TicketPriority { low, medium, high, urgent }