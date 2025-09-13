/// Activity type enumeration for dashboard activities (shared-specific)
enum ActivityType { user, order, system, revenue }

enum HousekeepingActivityType {
  bookingCreated,
  bookingConfirmed,
  bookingStarted,
  bookingCompleted,
  bookingCancelled,
  bookingRescheduled,
  //
  professionalAssigned,
  professionalUnassigned,
  //
  paymentReceived,
  reviewSubmitted,
  //
  customerRegistered,
  professionalRegistered,
}

enum BookingActivityStatus {
  pending,
  confirmed,
  assigned,
  inProgress,
  completed,
  cancelled,
  rescheduled,
  noShow,
}

/// Professional status enumeration (shared-specific)
enum ProfessionalActivityStatus { available, onJob, offline, onBreak }

/// Professional status in the Neo-Tidaro system
enum ProfessionalKycStatus {
  pending,
  active,
  inactive,
  suspended,
  rejected,
  underReview,
}

enum JobStatus { available, reserved, failed }
