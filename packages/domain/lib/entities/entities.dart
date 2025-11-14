/// Domain entities for the Neo-Tidaro business logic
/// Organized by business domain for better maintainability
library;

// Core base classes
export 'base_entity.dart';
// Booking domain
export 'booking/booking.dart';
export 'booking/payment.dart';
export 'booking/review.dart';
// Communication domain
export 'communication/communication.dart';
export 'professional/availability.dart';
// Professional domain
export 'user/professional_profile.dart';
export 'professional/service.dart';
// Shared domain
export 'shared/location.dart';
export 'shared/verification.dart';
// Support domain
export 'support/ticket.dart';
// System domain
export 'system/system.dart';
// User domain
export 'user/profile.dart';
export 'user/client_profile.dart';

