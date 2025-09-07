import 'package:shared/domain/domain.dart';

class VerificationDocumentModel extends VerificationDocumentEntity {
  const VerificationDocumentModel({
    required super.id,
    required super.createdAt,
    required super.updatedAt,
    required super.profileId,
    required super.documentType,
    required super.documentUrl,
    required super.verificationStatus,
    super.verifiedBy,
    super.verifiedAt,
    super.rejectionReason,
  });
}
