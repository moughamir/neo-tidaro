/// Authentication state for domain events
enum AuthenticationStateType {
  /// The user is authenticated.
  authenticated,
  /// The user is not authenticated.
  unauthenticated,
  /// The authentication state is loading.
  loading,
  /// An error occurred during authentication.
  error
}

/// The authentication provider.
enum AuthProvider {
  /// Email and password authentication.
  email,
  /// Google authentication.
  google,
  /// Apple authentication.
  apple,
  /// Facebook authentication.
  facebook,
  /// Phone authentication.
  phone
}