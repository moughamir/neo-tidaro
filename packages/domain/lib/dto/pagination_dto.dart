// ============= PAGINATION DTO =============

class PaginationDto {
  final int page;
  final int limit;
  final String? cursor;

  const PaginationDto({this.page = 1, this.limit = 20, this.cursor});

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'cursor': cursor,
  };
}
