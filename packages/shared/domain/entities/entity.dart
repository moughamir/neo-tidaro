import 'package:equatable/equatable.dart';

/// An abstract base class for domain entities.
///
/// Enforces the presence of a unique identifier, which is a common
/// requirement for most entities in a system. Uses Equatable for
/// simplified equality comparisons.
abstract class Entity extends Equatable {
  final String id;

  const Entity({required this.id});
  
  @override
  List<Object?> get props => [id];
}
