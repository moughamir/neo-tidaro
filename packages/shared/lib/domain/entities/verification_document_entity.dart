import 'package:shared/domain/domain.dart';

abstract class VerificationDocumentEntity extends Entity {
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

  @override
  List<Object?> get props => [
    ...super.props,
    profileId,
    documentType,
    documentUrl,
    verificationStatus,
    verifiedBy,
    verifiedAt,
    rejectionReason,
  ];
}
