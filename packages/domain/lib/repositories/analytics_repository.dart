abstract class AnalyticsRepository {
  Future<void> trackEvent(String event, Map<String, dynamic> properties);
  Future<void> trackScreen(String screenName);
  Future<void> setUserProperties(Map<String, dynamic> properties);
  Future<Map<String, dynamic>> getDashboardMetrics(String userId);
  Future<List<Map<String, dynamic>>> getBookingTrends({
    DateTime? startDate,
    DateTime? endDate,
  });
  Future<Map<String, dynamic>> getPlatformStatistics();
}
