import '../enums/enums.dart';
import 'base_entity.dart';

/// Chat room entity for messaging
class Chat extends BaseEntity {
  final String? bookingId;
  final String createdBy;
  final List<ChatMember> members;
  final Message? lastMessage;
  final int unreadCount;
  final bool isEncrypted;
  final DateTime? lastActivityAt;

  const Chat({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    this.bookingId,
    required this.createdBy,
    this.members = const [],
    this.lastMessage,
    this.unreadCount = 0,
    this.isEncrypted = true,
    this.lastActivityAt,
  });
}

/// Chat member entity
class ChatMember {
  final String chatId;
  final String userId;
  final ChatRole role;
  final DateTime? addedAt;

  const ChatMember({
    required this.chatId,
    required this.userId,
    required this.role,
    this.addedAt,
  });
}

/// Message entity for chat communication
class Message extends BaseEntity {
  final String chatId;
  final String senderId;
  final MessageType messageType;
  final String? content;
  final String? attachmentUrl;
  final MessageStatus? status;
  final DateTime? deletedAt;
  final Map<String, dynamic>? metadata;

  const Message({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.chatId,
    required this.senderId,
    required this.messageType,
    this.content,
    this.attachmentUrl,
    this.status,
    this.deletedAt,
    this.metadata,
  });
}

abstract class MessageEntity extends BaseEntity {
  final String senderId;
  final String receiverId;
  final String? bookingId;
  final String content;
  final MessageType messageType;
  final String? mediaUrl;
  final bool isRead;
  final bool isModerated;
  final String? moderatedBy;
  final DateTime? moderatedAt;

  const MessageEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.senderId,
    required this.receiverId,
    required this.content,
    required this.messageType,
    this.bookingId,
    this.mediaUrl,
    this.isRead = false,
    this.isModerated = false,
    this.moderatedBy,
    this.moderatedAt,
  });
}
