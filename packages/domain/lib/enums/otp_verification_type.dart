/// The type of OTP verification.
enum OtpVerificationType { 
  /// Email verification.
  email, 
  /// Phone number verification.
  phone, 
  /// Account recovery.
  recovery, 
  /// Magic link authentication.
  magicLink,
  /// New user sign-up.
  signup,
  /// Password reset.
  passwordReset,
}