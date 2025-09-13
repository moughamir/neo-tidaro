import '../dto/dto.dart';
import '../entities/entities.dart';
import 'base_repository.dart';

/// Repository interface for chat room and message operations.
///
/// This is a domain-only contract. Implementations belong to infrastructure
/// (e.g., Shared/Infra) and must not introduce framework dependencies here.
abstract class ChatRepository extends BaseRepository {
  /// Creates a chat room.
  ///
  /// The DTO [dto] must contain the participant IDs and an optional booking ID.
  /// Returns the created chat room.
  Future<Chat> createChatRoom(CreateChatRoomDto dto);

  /// Retrieves a chat room by its ID.
  ///
  /// Returns the chat room with the specified [id], or `null` if it does not exist.
  Future<Chat?> getChatRoom(String id);

  /// Retrieves the chat room associated with a booking.
  ///
  /// Returns the chat room associated with the booking with the specified [bookingId],
  /// or `null` if it does not exist.
  Future<Chat?> getBookingChatRoom(String bookingId);

  /// Retrieves the chat rooms of a user.
  ///
  /// Returns the chat rooms of the user with the specified [userId].
  Future<List<Chat>> getUserChatRooms(String userId);

  /// Sends a message.
  ///
  /// The DTO [dto] must contain the chat room ID, sender ID, type, content, and metadata.
  /// Returns the sent message.
  Future<Message> sendMessage(SendMessageDto dto);

  /// Retrieves the messages of a chat room.
  ///
  /// Returns the messages of the chat room with the specified [chatRoomId].
  /// The [pagination] parameter can be used to limit the number of returned messages.
  Future<List<Message>> getChatMessages(
    String chatRoomId, {
    PaginationDto? pagination,
  });

  /// Marks the chat room as read by a user.
  ///
  /// Marks the chat room with the specified [chatRoomId] as read by the user with the specified [userId].
  /// Returns `true` if the operation is successful.
  Future<bool> markAsRead(String chatRoomId, String userId);

  /// Deletes a message.
  ///
  /// Deletes the message with the specified [messageId].
  /// Returns `true` if the operation is successful.
  Future<bool> deleteMessage(String messageId);

  /// Watches the chat rooms of a user.
  ///
  /// Returns a stream of the chat rooms of the user with the specified [userId].
  /// The stream is hot and reflects live updates when the storage layer supports it.
  Stream<List<Chat>> watchUserChatRooms(String userId);

  /// Watches the messages of a chat room.
  ///
  /// Returns a stream of the messages of the chat room with the specified [chatRoomId].
  /// The stream is hot and reflects live updates when the storage layer supports it.
  Stream<List<Message>> watchChatMessages(String chatRoomId);

  /// Watches the unread count of a user.
  ///
  /// Returns a stream of the unread count of the user with the specified [userId].
  /// The stream is hot and reflects live updates when the storage layer supports it.
  Stream<int> watchUnreadCount(String userId);
}
