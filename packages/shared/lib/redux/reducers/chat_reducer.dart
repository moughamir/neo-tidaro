import 'package:shared/redux/states/chat_state.dart';
import '../core/core.dart';

/// Chat reducer following Clean Architecture and functional programming principles
class ChatReducer extends BaseReducer<ChatState> {
  @override
  ChatState reduce(ChatState state, BaseAction action) {
    return switch (action.type) {
      String() => state,
    };
  }
}

/// Chat reducer instance
final chatReducer = ChatReducer();
