// ============= LOCATION DTOs =============

class SubmitKycDto {
  const SubmitKycDto({
    required this.userId,
    required this.documentType,
    required this.documentNumber,
    required this.frontImageBase64,
    this.backImageBase64,
  });
  final String userId;
  final String documentType;
  final String documentNumber;
  final String frontImageBase64;
  final String? backImageBase64;

  Map<String, dynamic> toJson() => {
    'user_id': userId,
    'document_type': documentType,
    'document_number': documentNumber,
    'front_image': frontImageBase64,
    'back_image': backImageBase64,
  };
}
