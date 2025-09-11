// ============= PAGINATED RESPONSE DTO =============

class PaginatedResponseDto<T> {
  final List<T> data;
  final int total;
  final int page;
  final int totalPages;
  final String? nextCursor;

  const PaginatedResponseDto({
    required this.data,
    required this.total,
    required this.page,
    required this.totalPages,
    this.nextCursor,
  });
}
