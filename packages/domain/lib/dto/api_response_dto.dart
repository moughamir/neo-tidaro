// ============= API RESPONSE DTO =============

/// A generic class for platform API responses.
class PlatformApiResponseDto<T> {
  /// Creates a new instance of [PlatformApiResponseDto].
  const PlatformApiResponseDto({
    this.data,
    required this.success,
    this.message,
    this.errors,
  });
  /// The data returned by the API.
  final T? data;
  /// Whether the API call was successful.
  final bool success;
  /// A message from the API.
  final String? message;
  /// A map of errors from the API.
  final Map<String, dynamic>? errors;
}
