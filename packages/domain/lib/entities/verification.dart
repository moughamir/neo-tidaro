import '../enums/enums.dart';
import 'base_entity.dart';

/// KYC Document entity for verification
class KycDocument extends BaseEntity {
  final String userId;
  final VerificationDocType documentType;
  final String documentNumber;
  final String frontImageUrl;
  final String? backImageUrl;
  final VerificationStatus status;
  final String? rejectionReason;

  const KycDocument({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.userId,
    required this.documentType,
    required this.documentNumber,
    required this.frontImageUrl,
    this.backImageUrl,
    required this.status,
    this.rejectionReason,
  });
}

/// Professional certification entity
class Certification extends BaseEntity {
  final String professionalId;
  final String name;
  final String issuedBy;
  final DateTime issuedDate;
  final DateTime? expiryDate;
  final String? documentUrl;
  final bool isVerified;

  const Certification({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.professionalId,
    required this.name,
    required this.issuedBy,
    required this.issuedDate,
    this.expiryDate,
    this.documentUrl,
    this.isVerified = false,
  });
}

abstract class VerificationDocumentEntity extends BaseEntity {
  final String profileId;
  final DocumentType documentType;
  final String documentUrl;
  final VerificationStatus verificationStatus;
  final String? verifiedBy;
  final DateTime? verifiedAt;
  final String? rejectionReason;

  const VerificationDocumentEntity({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required this.profileId,
    required this.documentType,
    required this.documentUrl,
    required this.verificationStatus,
    this.verifiedBy,
    this.verifiedAt,
    this.rejectionReason,
  });
}
