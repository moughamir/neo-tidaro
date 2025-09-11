import '../dto/dto.dart';
import '../entities/entities.dart';

abstract class ChatRepository {
  Future<Chat> createChatRoom(CreateChatRoomDto dto);
  Future<Chat?> getChatRoom(String id);
  Future<Chat?> getBookingChatRoom(String bookingId);
  Future<List<Chat>> getUserChatRooms(String userId);
  Future<Message> sendMessage(SendMessageDto dto);
  Future<List<Message>> getChatMessages(
    String chatRoomId, {
    PaginationDto? pagination,
  });
  Future<bool> markAsRead(String chatRoomId, String userId);
  Future<bool> deleteMessage(String messageId);
  Stream<List<Chat>> watchUserChatRooms(String userId);
  Stream<List<Message>> watchChatMessages(String chatRoomId);
  Stream<int> watchUnreadCount(String userId);
}

abstract class MessageRepository {
  Future<List<Message>> findByBookingId(String bookingId);
  Future<Message> sendMessage(Message message);
  Future<void> markAsRead(String id);
}
