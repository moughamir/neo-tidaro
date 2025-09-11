// ============= MESSAGE DTOs =============

import '../enums/messaging.dart';

class SendMessageDto {
  final String chatRoomId;
  final String senderId;
  final MessageType type;
  final String content;
  final Map<String, dynamic>? metadata;

  const SendMessageDto({
    required this.chatRoomId,
    required this.senderId,
    required this.type,
    required this.content,
    this.metadata,
  });

  Map<String, dynamic> toJson() => {
    'chat_room_id': chatRoomId,
    'sender_id': senderId,
    'type': type.name,
    'content': content,
    'metadata': metadata,
  };
}

class CreateChatRoomDto {
  final List<String> participantIds;
  final String? bookingId;
  final bool isEncrypted;

  const CreateChatRoomDto({
    required this.participantIds,
    this.bookingId,
    this.isEncrypted = true,
  });

  Map<String, dynamic> toJson() => {
    'participant_ids': participantIds,
    'booking_id': bookingId,
    'is_encrypted': isEncrypted,
  };
}
