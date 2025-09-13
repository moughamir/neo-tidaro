
class ApiResponseDto<T> {

  const ApiResponseDto({
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

class PaginatedResponseDto<T> {

  const PaginatedResponseDto({
    required this.data,
    required this.total,
    required this.page,
    required this.totalPages,
    this.nextCursor,
  });
  final List<T> data;
  final int total;
  final int page;
  final int totalPages;
  final String? nextCursor;
}
