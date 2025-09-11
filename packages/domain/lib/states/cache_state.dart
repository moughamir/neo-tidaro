class CacheState {
  final Map<String, dynamic> cache;
  final Map<String, DateTime> cacheTimestamps;

  const CacheState({this.cache = const {}, this.cacheTimestamps = const {}});

  factory CacheState.initial() => const CacheState();

  bool isCacheValid(String key, Duration maxAge) {
    final timestamp = cacheTimestamps[key];
    if (timestamp == null) return false;
    return DateTime.now().difference(timestamp) < maxAge;
  }
}
