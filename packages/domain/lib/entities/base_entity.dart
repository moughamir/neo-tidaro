/// Base class for all domain entities
/// Pure Dart implementation without external dependencies
// ignore_for_file: overridden_fields

library;
// ignore_for_file: public_member_api_docs

abstract class BaseEntity {
  const BaseEntity({required this.id, this.createdAt, this.updatedAt});
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

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
  String toString() => '$runtimeType(id: $id)';
}
