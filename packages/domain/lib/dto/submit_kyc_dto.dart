// ============= LOCATION DTOs =============

/// Data transfer object for submitting KYC documents.
class SubmitKycDto {
  /// Creates a new instance of [SubmitKycDto].
  const SubmitKycDto({
    required this.userId,
    required this.documentType,
    required this.documentNumber,
    required this.frontImageBase64,
    this.backImageBase64,
  });
  /// The ID of the user submitting the documents.
  final String userId;
  /// The type of document being submitted.
  final String documentType;
  /// The number of the document being submitted.
  final String documentNumber;
  /// The front image of the document, encoded in base64.
  final String frontImageBase64;
  /// The back image of the document, encoded in base64.
  final String? backImageBase64;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'document_type': documentType,
    'document_number': documentNumber,
    'front_image': frontImageBase64,
    'back_image': backImageBase64,
  };
}