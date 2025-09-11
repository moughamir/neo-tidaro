import 'base_entity.dart';

class Comment extends BaseEntity {
  final String content;
  final String? userId;
  final String? ticketId;

  Comment({
    required super.id,
    required this.content,
    this.userId,
    this.ticketId,
    super.createdAt,
    super.updatedAt,
  });
}
