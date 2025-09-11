import '../entities/entities.dart';

abstract class ServiceRepository {
  Future<Service> findById(String id);
  Future<List<Service>> findAllActive();
  Future<Service> save(Service service);
  Future<void> delete(String id);
}
