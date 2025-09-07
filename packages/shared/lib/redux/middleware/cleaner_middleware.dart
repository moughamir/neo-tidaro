library shared.redux.middleware.cleaner_middleware;

import 'package:redux/redux.dart';
import '../core/core.dart';
import '../actions/cleaner_actions.dart';
import '../app_state.dart';
import '../../domain/models/models.dart';
import '../../domain/enums/enums.dart';

List<Middleware<AppState>> createCleanerMiddleware() {
  return [
    TypedMiddleware<AppState, LoadCleanersAction>(_loadCleaners),
    TypedMiddleware<AppState, UpdateCleanerStatusAction>(_updateCleanerStatus),
    TypedMiddleware<AppState, CreateCleanerAction>(_createCleaner),
  ];
}

void _loadCleaners(
  Store<AppState> store,
  LoadCleanersAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // Simulate API call - replace with actual Supabase calls
    await Future.delayed(const Duration(seconds: 1));

    final sampleCleaners = [
      Cleaner(
        id: '1',
        name: 'Sarah Johnson',
        email: 'sarah.johnson@example.com',
        phone: '+1234567890',
        status: CleanerStatus.available,
        serviceCategories: [
          ServiceCategory.regularCleaning,
          ServiceCategory.deepCleaning,
        ],
        rating: 4.8,
        totalBookings: 156,
        joinedDate: DateTime.now().subtract(const Duration(days: 365)),
        isVerified: true,
      ),
      Cleaner(
        id: '2',
        name: 'Michael Chen',
        email: 'michael.chen@example.com',
        phone: '+1234567891',
        status: CleanerStatus.onJob,
        serviceCategories: [
          ServiceCategory.commercial,
          ServiceCategory.postConstruction,
        ],
        rating: 4.6,
        totalBookings: 89,
        joinedDate: DateTime.now().subtract(const Duration(days: 180)),
        isVerified: true,
      ),
      Cleaner(
        id: '3',
        name: 'Emma Rodriguez',
        email: 'emma.rodriguez@example.com',
        phone: '+1234567892',
        status: CleanerStatus.offline,
        serviceCategories: [
          ServiceCategory.moveInOut,
          ServiceCategory.specialized,
        ],
        rating: 4.9,
        totalBookings: 203,
        joinedDate: DateTime.now().subtract(const Duration(days: 500)),
        isVerified: true,
      ),
      Cleaner(
        id: '4',
        name: 'James Wilson',
        email: 'james.wilson@example.com',
        phone: '+1234567893',
        status: CleanerStatus.onBreak,
        serviceCategories: [
          ServiceCategory.regularCleaning,
          ServiceCategory.residential,
        ],
        rating: 4.4,
        totalBookings: 67,
        joinedDate: DateTime.now().subtract(const Duration(days: 90)),
        isVerified: false,
      ),
    ];

    store.dispatch(
      ActionCreators.success(CleanerActionTypes.loadCleaners, sampleCleaners),
    );
  } catch (e) {
    store.dispatch(
      ActionCreators.failure(CleanerActionTypes.loadCleaners, Exception('Failed to load cleaners: $e')),
    );
  }
}

void _updateCleanerStatus(
  Store<AppState> store,
  UpdateCleanerStatusAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // Simulate API call - replace with actual Supabase calls
    await Future.delayed(const Duration(milliseconds: 500));

    store.dispatch(
      ActionCreators.success(CleanerActionTypes.updateCleanerStatus, {
        'cleanerId': action.cleanerId,
        'status': action.status,
      }),
    );
  } catch (e) {
    store.dispatch(
      ActionCreators.failure(CleanerActionTypes.updateCleanerStatus, Exception('Failed to update cleaner status: $e')),
    );
  }
}

void _createCleaner(
  Store<AppState> store,
  CreateCleanerAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // Simulate API call - replace with actual Supabase calls
    await Future.delayed(const Duration(seconds: 1));

    // Create cleaner with generated ID
    final newCleaner = action.cleaner.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      joinedDate: DateTime.now(),
    );

    store.dispatch(
      ActionCreators.success(CleanerActionTypes.createCleaner, newCleaner),
    );
  } catch (e) {
    store.dispatch(
      ActionCreators.failure(CleanerActionTypes.createCleaner, Exception('Failed to create cleaner: $e')),
    );
  }
}
