import '../base_entity.dart';
import '../../enums/enums.dart';

/// Chat room entity for user communications
class Chat extends BaseEntity {
  final String name;
  final List<String> participantIds;
  final String? bookingId;
  final String? lastMessageId;
  final DateTime? lastMessageAt;
  final Map<String, int> unreadCounts;
  final bool isActive;

  const Chat({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.name,
    required this.participantIds,
    this.bookingId,
    this.lastMessageId,
    this.lastMessageAt,
    this.unreadCounts = const {},
    this.isActive = true,
  });
}

/// Message entity for chat communications
class Message extends BaseEntity {
  final String chatRoomId;
  final String senderId;
  final String content;
  final MessageType type;
  final MessageStatus status;
  final String? replyToMessageId;
  final List<String> attachments;
  final Map<String, dynamic>? metadata;

  const Message({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.chatRoomId,
    required this.senderId,
    required this.content,
    this.type = MessageType.text,
    this.status = MessageStatus.sent,
    this.replyToMessageId,
    this.attachments = const [],
    this.metadata,
  });
}

/// Notification entity for system communications
class Notification extends BaseEntity {
  final String userId;
  final String title;
  final String content;
  final NotificationType type;
  final bool isRead;
  final String? actionUrl;
  final Map<String, dynamic>? payload;

  const Notification({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.userId,
    required this.title,
    required this.content,
    required this.type,
    this.isRead = false,
    this.actionUrl,
    this.payload,
  });
}
