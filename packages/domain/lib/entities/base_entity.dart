import 'package:equatable/equatable.dart';

abstract class BaseEntity {
  final String id;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const BaseEntity({required this.id, this.createdAt, this.updatedAt});
}

/// Base class for all domain entities
///
/// Provides unique ID handling and equality comparison through Equatable
abstract class Entity extends Equatable {
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Entity({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [id];
}
