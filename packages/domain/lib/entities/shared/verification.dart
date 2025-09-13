import '../../enums/enums.dart';
import '../base_entity.dart';

/// KYC document entity for user verification
class KycDocument extends BaseEntity {
  const KycDocument({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.userId,
    required this.documentType,
    required this.documentNumber,
    this.documentUrl,
    this.status = VerificationStatus.pending,
    this.rejectionReason,
    this.verifiedAt,
    this.verifiedBy,
    this.expiresAt,
  });
  final String userId;
  final DocumentType documentType;
  final String documentNumber;
  final String? documentUrl;
  final VerificationStatus status;
  final String? rejectionReason;
  final DateTime? verifiedAt;
  final String? verifiedBy;
  final DateTime? expiresAt;
}

/// Authentication session entity
class AuthSession extends BaseEntity {
  const AuthSession({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.userId,
    required this.accessToken,
    this.refreshToken,
    required this.expiresAt,
    this.deviceId,
    this.ipAddress,
    this.userAgent,
    this.isActive = true,
  });
  final String userId;
  final String accessToken;
  final String? refreshToken;
  final DateTime expiresAt;
  final String? deviceId;
  final String? ipAddress;
  final String? userAgent;
  final bool isActive;

  /// Check if session is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);
}
