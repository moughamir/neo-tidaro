import 'package:shared/domain/domain.dart';

abstract class MessageEntity extends Entity {
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

  @override
  List<Object?> get props => [
    ...super.props,
    senderId,
    receiverId,
    bookingId,
    content,
    messageType,
    mediaUrl,
    isRead,
    isModerated,
    moderatedBy,
    moderatedAt,
  ];
}
