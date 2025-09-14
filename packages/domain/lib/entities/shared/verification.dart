import '../../enums/enums.dart';
import '../base_entity.dart';

/// KYC document entity for user verification
class KycDocument extends BaseEntity {
  /// Creates a new instance of [KycDocument].
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
  /// The ID of the user this document belongs to.
  final String userId;
  /// The type of document.
  final DocumentType documentType;
  /// The number of the document.
  final String documentNumber;
  /// The URL of the document.
  final String? documentUrl;
  /// The status of the document verification.
  final VerificationStatus status;
  /// The reason for rejecting the document.
  final String? rejectionReason;
  /// The timestamp of when the document was verified.
  final DateTime? verifiedAt;
  /// The ID of the user who verified the document.
  final String? verifiedBy;
  /// The expiry date of the document.
  final DateTime? expiresAt;
}

/// Authentication session entity
class AuthSession extends BaseEntity {
  /// Creates a new instance of [AuthSession].
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
  /// The ID of the user this session belongs to.
  final String userId;
  /// The access token for the session.
  final String accessToken;
  /// The refresh token for the session.
  final String? refreshToken;
  /// The expiry date of the session.
  final DateTime expiresAt;
  /// The ID of the device used for the session.
  final String? deviceId;
  /// The IP address of the device used for the session.
  final String? ipAddress;
  /// The user agent of the device used for the session.
  final String? userAgent;
  /// Whether the session is active.
  final bool isActive;

  /// Check if session is expired
  bool get isExpired => DateTime.now().isAfter(expiresAt);
}