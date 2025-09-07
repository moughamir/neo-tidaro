library shared.enums;

// Keep enums that are only defined at the enum layer
enum PaymentStatus { pending, processing, completed, failed, refunded }

enum VerificationStatus { pending, verified, rejected, expired }

enum MessageType { text, image, file, system }

enum DocumentType { cin, cine, referenceLetter, backgroundCheck }

/// Supabase user roles (user_role_enum)
enum UserRole { admin, moderator, clientConsumer, clientProvider }

/// Housekeeping activity type enumeration
enum HousekeepingActivityType {
  bookingCreated,
  bookingConfirmed,
  bookingStarted,
  bookingCompleted,
  bookingCancelled,
  bookingRescheduled,
  cleanerAssigned,
  cleanerUnassigned,
  paymentReceived,
  reviewSubmitted,
}

/// Booking status enumeration
enum BookingStatus {
  pending,
  confirmed,
  assigned,
  inProgress,
  completed,
  cancelled,
  rescheduled,
  noShow,
}

/// Service category enumeration
enum ServiceCategory {
  standardCleaning,
  regularCleaning,
  deepCleaning,
  moveInOut,
  postConstruction,
  commercial,
  residential,
  specialized,
}

/// Cleaner status enumeration
enum CleanerStatus { available, onJob, offline, onBreak }
