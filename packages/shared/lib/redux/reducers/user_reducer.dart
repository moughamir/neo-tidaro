import 'package:shared/redux/states/user_state.dart';
import '../core/core.dart';

/// Chat reducer following Clean Architecture and functional programming principles
class UserReducer extends BaseReducer<UserState> {
  @override
  UserState reduce(UserState state, BaseAction action) {
    return switch (action.type) {
      String() => state,
    };
  }
}

/// Chat reducer instance
final userReducer = UserReducer();
