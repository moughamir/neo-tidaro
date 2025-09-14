// ============= PAGINATED RESPONSE DTO =============

/// A generic class for paginated API responses.
class PaginatedResponseDto<T> {

  /// Creates a new instance of [PaginatedResponseDto].
  const PaginatedResponseDto({
    required this.data,
    required this.total,
    required this.page,
    required this.totalPages,
    this.nextCursor,
  });
  /// The data for the current page.
  final List<T> data;
  /// The total number of items.
  final int total;
  /// The current page number.
  final int page;
  /// The total number of pages.
  final int totalPages;
  /// The cursor for the next page.
  final String? nextCursor;
}