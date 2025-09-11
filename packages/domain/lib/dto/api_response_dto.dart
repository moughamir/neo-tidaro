// ============= API RESPONSE DTO =============

class ApiResponseDto<T> {
  final T? data;
  final bool success;
  final String? message;
  final Map<String, dynamic>? errors;

  const ApiResponseDto({
    this.data,
    required this.success,
    this.message,
    this.errors,
  });
}
