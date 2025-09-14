// ============= MESSAGE DTOs =============

import '../enums/messaging.dart';

/// Data transfer object for sending a message.
class SendMessageDto {

  /// Creates a new instance of [SendMessageDto].
  const SendMessageDto({
    required this.chatRoomId,
    required this.senderId,
    required this.type,
    required this.content,
    this.metadata,
  });
  /// The ID of the chat room.
  final String chatRoomId;
  /// The ID of the message sender.
  final String senderId;
  /// The type of message.
  final MessageType type;
  /// The content of the message.
  final String content;
  /// Additional metadata for the message.
  final Map<String, dynamic>? metadata;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'chat_room_id': chatRoomId,
    'sender_id': senderId,
    'type': type.name,
    'content': content,
    'metadata': metadata,
  };
}

/// Data transfer object for creating a chat room.
class CreateChatRoomDto {

  /// Creates a new instance of [CreateChatRoomDto].
  const CreateChatRoomDto({
    required this.participantIds,
    this.bookingId,
    this.isEncrypted = true,
  });
  /// A list of participant IDs for the chat room.
  final List<String> participantIds;
  /// The ID of the booking associated with the chat room.
  final String? bookingId;
  /// Whether the chat room is encrypted.
  final bool isEncrypted;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'participant_ids': participantIds,
    'booking_id': bookingId,
    'is_encrypted': isEncrypted,
  };
}