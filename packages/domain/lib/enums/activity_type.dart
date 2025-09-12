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
  cleanerAssigned,
  cleanerUnassigned,
  //
  paymentReceived,
  reviewSubmitted,
  //
  customerRegistered,
  cleanerRegistered,
}

/// Cleaner status enumeration (shared-specific)
enum ProfessionalActivityStatus { available, onJob, offline, onBreak }
