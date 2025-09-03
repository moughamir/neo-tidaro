/// An abstract base class for domain entities.
///
/// Enforces the presence of a unique identifier, which is a common
/// requirement for most entities in a system.
abstract class Entity {
  final String id;

  const Entity({required this.id});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Entity && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
