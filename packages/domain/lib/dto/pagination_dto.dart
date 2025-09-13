// ============= PAGINATION DTO =============

class PaginationDto {

  const PaginationDto({this.page = 1, this.limit = 20, this.cursor});
  final int page;
  final int limit;
  final String? cursor;

  Map<String, dynamic> toJson() => {
    'page': page,
    'limit': limit,
    'cursor': cursor,
  };
}
