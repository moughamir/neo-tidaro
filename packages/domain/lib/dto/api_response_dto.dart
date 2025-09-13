// ============= API RESPONSE DTO =============

class PlatformApiResponseDto<T> {
  const PlatformApiResponseDto({
    this.data,
    required this.success,
    this.message,
    this.errors,
  });
  final T? data;
  final bool success;
  final String? message;
  final Map<String, dynamic>? errors;
}
