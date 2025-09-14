/// The level of KYC verification.
enum KycLevel {
  /// No KYC verification.
  none,
  /// Basic KYC verification.
  basic,
  /// Standard KYC verification.
  standard,
  /// Enhanced KYC verification.
  enhanced
}

/// Document types for verification purposes
enum VerificationDocType {
  /// An ID card.
  id,
  /// A passport.
  passport
}

/// Document types for general document management
enum DocumentType {
  /// Moroccan National Identity Card.
  cin,
  /// Moroccan National Identity Card (Electronic).
  cine,
  /// A reference letter.
  referenceLetter,
  /// A background check document.
  backgroundCheck
}

/// The status of a verification.
enum VerificationStatus {
  /// The verification has not been started.
  unverified,
  /// The verification is pending review.
  pending,
  /// The verification has been approved.
  verified,
  /// The verification has been rejected.
  rejected,
  /// The verification has expired.
  expired
}