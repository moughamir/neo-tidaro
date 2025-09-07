import 'package:shared/domain/domain.dart';

class MessageModel extends MessageEntity {
  const MessageModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.senderId,
    required super.receiverId,
    required super.content,
    required super.messageType,
    super.bookingId,
    super.mediaUrl,
    super.isRead,
    super.isModerated,
    super.moderatedBy,
    super.moderatedAt,
  });
}
