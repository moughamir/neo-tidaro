import 'package:domain/entities/entities.dart';

class DashboardState implements DashboardMetrics {
  final List<ActivityItem>? recentActivities;
  final bool isLoading;
  const DashboardState({
    required this.isLoading,
    this.recentActivities = const [],
  });

  factory DashboardState.initial() => const DashboardState(isLoading: false);
  @override
  DateTime? get createdAt => throw UnimplementedError();

  @override
  String get id => throw UnimplementedError();

  @override
  DateTime? get updatedAt => throw UnimplementedError();

  get data => null;
}
