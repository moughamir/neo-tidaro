import 'package:domain/domain.dart';
import 'package:shared/redux/core/base_state.dart';

class ChatState extends BaseState {
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

  @override
  List<Object?> get props => [
    chatRooms,
    activeChatRoom,
    messages,
    totalUnreadCount,
    isLoading,
    error,
  ];

  @override
  String get stateType => 'chatState';
}
