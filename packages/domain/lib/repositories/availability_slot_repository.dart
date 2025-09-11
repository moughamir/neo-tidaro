import '../entities/entities.dart';

abstract class AvailabilitySlotRepository {
  Future<List<Availability>> findByProviderId(String providerId);
  Future<Availability> create(Availability slot);
  Future<void> toggleAvailability(String id);
}
