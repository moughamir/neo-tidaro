import '../entities/entities.dart';

abstract class BlockedPeriodRepository {
  Future<List<Availability>> findByProfileId(String profileId);
  Future<Availability> create(Availability period);
  Future<void> remove(String id);
}
