// ============= PAGINATED RESPONSE DTO =============

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
