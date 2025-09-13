import 'package:shared/redux/core/core.dart';

class CacheState extends BaseState {
  final Map<String, dynamic> cache;
  final Map<String, DateTime> cacheTimestamps;

  const CacheState({this.cache = const {}, this.cacheTimestamps = const {}});

  factory CacheState.initial() => const CacheState();

  bool isCacheValid(String key, Duration maxAge) {
    final timestamp = cacheTimestamps[key];
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) < maxAge;
  }

  @override
  List<Object?> get props => [cache, cacheTimestamps];

  @override
  String get stateType => 'cacheState';
}
