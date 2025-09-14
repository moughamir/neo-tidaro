// ============= PAGINATION DTO =============

/// Data transfer object for pagination.
class PaginationDto {

  /// Creates a new instance of [PaginationDto].
  const PaginationDto({this.page = 1, this.limit = 20, this.cursor});
  /// The page number to fetch.
  final int page;
  /// The number of items to fetch per page.
  final int limit;
  /// The cursor for the next page.
  final String? cursor;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'cursor': cursor,
  };
}