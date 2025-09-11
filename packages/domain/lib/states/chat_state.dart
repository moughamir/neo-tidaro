import '../entities/entities.dart';

class ChatState {
  final List<Chat> chatRooms;
  final Chat? activeChatRoom;
  final Map<String, List<Message>> messages;
  final int totalUnreadCount;
  final bool isLoading;
  final String? error;

  const ChatState({
    this.chatRooms = const [],
    this.activeChatRoom,
    this.messages = const {},
    this.totalUnreadCount = 0,
    required this.isLoading,
    this.error,
  });

  factory ChatState.initial() => const ChatState(isLoading: false);
}
