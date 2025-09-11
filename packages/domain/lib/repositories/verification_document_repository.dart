import '../entities/entities.dart';

abstract class VerificationDocumentRepository {
  Future<List<KycDocument>> findByProfileId(String profileId);
  Future<KycDocument> upload(KycDocument document);
  Future<void> approve(String id);
  Future<void> reject(String id, String reason);
}
