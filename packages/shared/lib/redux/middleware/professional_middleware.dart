library shared.redux.middleware.cleaner_middleware;

import 'package:domain/domain.dart' hide AppState;
import 'package:redux/redux.dart';
import '../core/core.dart';
import '../actions/professional_actions.dart';
import '../app_state.dart';

List<Middleware<AppState>> createCleanerMiddleware() {
  return [TypedMiddleware<AppState, LoadProfessionalsAction>(_loadCleaners)];
}

void _loadCleaners(
  Store<AppState> store,
  LoadProfessionalsAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // Simulate API call - replace with actual Supabase calls
    await Future.delayed(const Duration(seconds: 1));

    final sampleCleaners = [
      ProfessionalProfile(
        id: '1',
        fullName: 'Sarah Johnson',
        email: EmailVO('sarah.johnson@example.com'),
        phone: PhoneVO('+1234567890'),
        categories: [
          ServiceCategory.regularCleaning,
          ServiceCategory.deepCleaning,
        ],
        rating: 4.8,
        completedJobs: 156,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        isVerified: true,
        hourlyRate: 25,
        defaultRateType: RateType.hourly,
        updatedAt: DateTime.now().subtract(const Duration(days: 365)),
      ),
      ProfessionalProfile(
        id: '2',
        fullName: 'Michael Chen',
        email: EmailVO('michael.chen@example.com'),
        phone: PhoneVO('+1234567891'),
        categories: [
          ServiceCategory.commercial,
          ServiceCategory.postConstruction,
        ],
        rating: 4.6,
        completedJobs: 89,
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
        isVerified: true,
        hourlyRate: 30,
        defaultRateType: RateType.hourly,
        updatedAt: DateTime.now().subtract(const Duration(days: 180)),
      ),
    ];

    store.dispatch(
      ActionCreators.success(
        ProfessionalrActionTypes.loadProfessionals,
        sampleCleaners,
      ),
    );
  } catch (e) {
    store.dispatch(
      ActionCreators.failure(
        ProfessionalrActionTypes.loadProfessionals,
        Exception('Failed to load cleaners: $e'),
      ),
    );
  }
}
