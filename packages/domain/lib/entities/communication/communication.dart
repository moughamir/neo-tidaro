import '../../enums/enums.dart';
import '../base_entity.dart';

/// Chat room entity for user communications
class Chat extends BaseEntity {

  /// Creates a new instance of [Chat].
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
  /// The name of the chat room.
  final String name;
  /// A list of participant IDs in the chat room.
  final List<String> participantIds;
  /// The ID of the booking associated with the chat room.
  final String? bookingId;
  /// The ID of the last message sent in the chat room.
  final String? lastMessageId;
  /// The timestamp of the last message sent in the chat room.
  final DateTime? lastMessageAt;
  /// A map of unread message counts for each participant.
  final Map<String, int> unreadCounts;
  /// Whether the chat room is active.
  final bool isActive;
}

/// Message entity for chat communications
class Message extends BaseEntity {

  /// Creates a new instance of [Message].
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
  /// The ID of the chat room this message belongs to.
  final String chatRoomId;
  /// The ID of the user who sent the message.
  final String senderId;
  /// The content of the message.
  final String content;
  /// The type of message.
  final MessageType type;
  /// The status of the message.
  final MessageStatus status;
  /// The ID of the message this message is a reply to.
  final String? replyToMessageId;
  /// A list of attachment URLs for the message.
  final List<String> attachments;
  /// Additional metadata for the message.
  final Map<String, dynamic>? metadata;
}

/// Notification entity for system communications
class Notification extends BaseEntity {

  /// Creates a new instance of [Notification].
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
  /// The ID of the user this notification is for.
  final String userId;
  /// The title of the notification.
  final String title;
  /// The content of the notification.
  final String content;
  /// The type of notification.
  final NotificationType type;
  /// Whether the notification has been read.
  final bool isRead;
  /// The URL to navigate to when the notification is tapped.
  final String? actionUrl;
  /// Additional data for the notification.
  final Map<String, dynamic>? payload;
}