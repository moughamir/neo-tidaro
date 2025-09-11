import 'base_entity.dart';

/// Domain authentication session entity
class AuthSession extends BaseEntity {
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;
  final String userId;
  final Map<String, dynamic>? metadata;

  const AuthSession({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.accessToken,
    this.refreshToken,
    required this.expiresAt,
    required this.userId,
    this.metadata,
  });

  bool get isExpired => DateTime.now().isAfter(expiresAt);
}

/// Generic authentication result wrapper
class AuthResult<T> {
  final T? data;
  final String? error;
  final bool isSuccess;

  const AuthResult._({this.data, this.error, required this.isSuccess});

  factory AuthResult.success(T data) =>
      AuthResult._(data: data, isSuccess: true);

  factory AuthResult.failure(String error) =>
      AuthResult._(error: error, isSuccess: false);
}
