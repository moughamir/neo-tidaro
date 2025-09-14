/// Activity type enumeration for dashboard activities (shared-specific)
enum ActivityType {
  /// User-related activity.
  user,
  /// Order-related activity.
  order,
  /// System-related activity.
  system,
  /// Revenue-related activity.
  revenue
}

/// Housekeeping activity type enumeration.
enum HousekeepingActivityType {
  /// A booking was created.
  bookingCreated,
  /// A booking was confirmed.
  bookingConfirmed,
  /// A booking was started.
  bookingStarted,
  /// A booking was completed.
  bookingCompleted,
  /// A booking was cancelled.
  bookingCancelled,
  /// A booking was rescheduled.
  bookingRescheduled,
  //
  /// A professional was assigned to a booking.
  professionalAssigned,
  /// A professional was unassigned from a booking.
  professionalUnassigned,
  //
  /// A payment was received.
  paymentReceived,
  /// A review was submitted.
  reviewSubmitted,
  //
  /// A customer registered.
  customerRegistered,
  /// A professional registered.
  professionalRegistered,
}

/// Booking activity status enumeration.
enum BookingActivityStatus {
  /// The booking is pending confirmation.
  pending,
  /// The booking has been confirmed.
  confirmed,
  /// A professional has been assigned to the booking.
  assigned,
  /// The booking is in progress.
  inProgress,
  /// The booking has been completed.
  completed,
  /// The booking has been cancelled.
  cancelled,
  /// The booking has been rescheduled.
  rescheduled,
  /// The client did not show up for the booking.
  noShow,
}

/// Professional status enumeration (shared-specific)
enum ProfessionalActivityStatus {
  /// The professional is available for new bookings.
  available,
  /// The professional is currently on a job.
  onJob,
  /// The professional is offline.
  offline,
  /// The professional is on a break.
  onBreak
}

/// Professional status in the Neo-Tidaro system
enum ProfessionalKycStatus {
  /// The professional's KYC is pending review.
  pending,
  /// The professional's KYC is active.
  active,
  /// The professional's KYC is inactive.
  inactive,
  /// The professional's KYC is suspended.
  suspended,
  /// The professional's KYC was rejected.
  rejected,
  /// The professional's KYC is under review.
  underReview,
}

/// Job status enumeration.
enum JobStatus {
  /// The job is available.
  available,
  /// The job is reserved.
  reserved,
  /// The job has failed.
  failed
}