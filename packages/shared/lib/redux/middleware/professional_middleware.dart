library;

import 'package:domain/domain.dart' hide AppState;
import 'package:redux/redux.dart';

import '../actions/professional_actions.dart';
import '../core/core.dart';
import '../states/app_state.dart';

List<Middleware<AppState>> createProfessionalMiddleware() {
  return [
    TypedMiddleware<AppState, LoadProfessionalsAction>(_loadProfessionals).call,
  ];
}

void _loadProfessionals(
  Store<AppState> store,
  LoadProfessionalsAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    // Simulate API call - replace with actual Supabase calls
    await Future.delayed(const Duration(seconds: 1));

    final sampleProfessionals = [
      ProfessionalProfile(
        id: '1',
        fullName: 'Sarah Johnson',
        email: const EmailVO('sarah.johnson@example.com'),
        phone: const PhoneVO('+1234567890'),
        categories: [
          PreBookingServiceCategory.regularCleaning,
          PreBookingServiceCategory.deepCleaning,
        ],
        rating: 4.8,
        completedJobs: 156,
        createdAt: DateTime.now().subtract(const Duration(days: 365)),
        isVerified: true,
        hourlyRate: 25,
        defaultRateType: JobRateType.hourly,
        updatedAt: DateTime.now().subtract(const Duration(days: 365)),
      ),
      ProfessionalProfile(
        id: '2',
        fullName: 'Michael Chen',
        email: const EmailVO('michael.chen@example.com'),
        phone: const PhoneVO('+1234567891'),
        categories: [
          PreBookingServiceCategory.commercial,
          PreBookingServiceCategory.postConstruction,
        ],
        rating: 4.6,
        completedJobs: 89,
        createdAt: DateTime.now().subtract(const Duration(days: 180)),
        isVerified: true,
        hourlyRate: 30,
        defaultRateType: JobRateType.hourly,
        updatedAt: DateTime.now().subtract(const Duration(days: 180)),
      ),
    ];

    store.dispatch(
      ActionCreators.success(
        ProfessionalActionTypes.loadProfessionals,
        sampleProfessionals,
      ),
    );
  } catch (e) {
    store.dispatch(
      ActionCreators.failure(
        ProfessionalActionTypes.loadProfessionals,
        Exception('Failed to load professionals: $e'),
      ),
    );
  }
}
