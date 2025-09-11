/// Base class for all domain entities
/// Pure Dart implementation without external dependencies
abstract class BaseEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BaseEntity({required this.id, this.createdAt, this.updatedAt});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other.runtimeType == runtimeType &&
        other is BaseEntity &&
        other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() => '${runtimeType}(id: $id)';
}

/// Enhanced entity with required timestamps for strict domain modeling
abstract class Entity extends BaseEntity {
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;

  const Entity({
    required super.id,
    required this.createdAt,
    required this.updatedAt,
  }) : super(createdAt: createdAt, updatedAt: updatedAt);
}
