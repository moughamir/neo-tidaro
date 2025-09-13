// ============= LOCATION DTOs =============

enum PreBookingSortBy {
  distance('distance'),
  rating('rating'),
  price('price'),
  experience('experience'),
  eloScore('elo_score');

  final String value;
  // ignore: sort_constructors_first
  const PreBookingSortBy(this.value);
}
