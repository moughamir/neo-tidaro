import 'package:shared/redux/states/cache_state.dart';
import '../core/core.dart';

/// Cache reducer following Clean Architecture and functional programming principles
class CacheReducer extends BaseReducer<CacheState> {
  @override
  CacheState reduce(CacheState state, BaseAction action) {
    return switch (action.type) {
      String() => state,
    };
  }
}

/// Cache reducer instance
final cacheReducer = CacheReducer();
