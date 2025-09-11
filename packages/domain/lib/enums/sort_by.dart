// ============= LOCATION DTOs =============

enum SortBy {
  distance('distance'),
  rating('rating'),
  price('price'),
  experience('experience'),
  eloScore('elo_score');

  final String value;
  const SortBy(this.value);
}
