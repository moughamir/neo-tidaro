import '../entities/entities.dart';

abstract class AddressRepository {
  Future<Address> findById(String id);
  Future<List<Address>> findByProfileId(String profileId);
  Future<Address> save(Address address);
  Future<void> delete(String id);
}
