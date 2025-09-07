import 'package:fpdart/fpdart.dart';
import '../core/core.dart';
import '../../domain/models/models.dart';

/// Dashboard state following functional programming patterns
class DashboardState extends BaseAsyncState<DashboardMetrics> {
  const DashboardState({
    required super.isLoading,
    required super.data,
    required super.error,
    required this.metricsLoading,
    required this.activitiesLoading,
    required this.lastRefresh,
  });

  final bool metricsLoading;
  final bool activitiesLoading;
  final Option<DateTime> lastRefresh;

  /// Initial state factory
  factory DashboardState.initial() {
    return const DashboardState(
      isLoading: false,
      data: None(),
      error: None(),
      metricsLoading: false,
      activitiesLoading: false,
      lastRefresh: None(),
    );
  }

  /// Loading state factory
  factory DashboardState.loading() {
    return const DashboardState(
      isLoading: true,
      data: None(),
      error: None(),
      metricsLoading: false,
      activitiesLoading: false,
      lastRefresh: None(),
    );
  }

  /// Success state factory
  factory DashboardState.success(DashboardMetrics data) {
    return DashboardState(
      isLoading: false,
      data: Some(data),
      error: const None(),
      metricsLoading: false,
      activitiesLoading: false,
      lastRefresh: Some(DateTime.now()),
    );
  }

  /// Error state factory
  factory DashboardState.error(Exception error) {
    return DashboardState(
      isLoading: false,
      data: const None(),
      error: Some(error),
      metricsLoading: false,
      activitiesLoading: false,
      lastRefresh: const None(),
    );
  }

  /// Copy with method for immutable updates
  DashboardState copyWith({
    bool? isLoading,
    Option<DashboardMetrics>? data,
    Option<Exception>? error,
    bool? metricsLoading,
    bool? activitiesLoading,
    Option<DateTime>? lastRefresh,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      data: data ?? this.data,
      error: error ?? this.error,
      metricsLoading: metricsLoading ?? this.metricsLoading,
      activitiesLoading: activitiesLoading ?? this.activitiesLoading,
      lastRefresh: lastRefresh ?? this.lastRefresh,
    );
  }

  @override
  String get stateType => 'DashboardState';

  @override
  List<Object?> get props => [
    isLoading,
    data,
    error,
    metricsLoading,
    activitiesLoading,
    lastRefresh,
  ];

  @override
  String toString() => 'DashboardState('
      'isLoading: $isLoading, '
      'metricsLoading: $metricsLoading, '
      'activitiesLoading: $activitiesLoading, '
      'hasData: ${data.isSome()}, '
      'hasError: ${error.isSome()}'
      ')';
}
