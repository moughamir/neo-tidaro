library shared.entities;

import 'package:equatable/equatable.dart';

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
