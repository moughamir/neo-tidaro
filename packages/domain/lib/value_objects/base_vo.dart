/// Base Value Object for type-safe domain modeling
/// Pure domain implementation without external dependencies
abstract class BaseVO {
  
  const BaseVO(this.value);
  final String value;
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BaseVO &&
      runtimeType == other.runtimeType &&
      value == other.value;
  
  @override
  int get hashCode => value.hashCode;
  
  @override
  String toString() => value;
}
