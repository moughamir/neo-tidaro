/// Domain entities for the Neo-Tidaro business logic
/// Organized by business domain for better maintainability
library entities;

// Core base classes
export 'base_entity.dart';

// User domain
export 'user/user.dart';
export 'user/user_profile.dart';

// Professional domain
export 'professional/professional_profile.dart';
export 'professional/service.dart';
export 'professional/availability.dart';

// Booking domain
export 'booking/booking.dart';
export 'booking/payment.dart';
export 'booking/review.dart';

// Communication domain
export 'communication/communication.dart';

// System domain
export 'system/system.dart';

// Support domain
export 'support/ticket.dart';

// Shared domain
export 'shared/location.dart';
export 'shared/verification.dart';
