import 'package:equatable/equatable.dart';

/// Base class for all domain entities
///
/// Provides unique ID handling and equality comparison through Equatable
abstract class Entity extends Equatable {
  final String id;
  
  const Entity({required this.id});
  
  @override
  List<Object?> get props => [id];
}
