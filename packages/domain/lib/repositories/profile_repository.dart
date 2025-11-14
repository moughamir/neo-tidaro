import '../entities/entities.dart';

/// Business-specific repository interfaces using domain entities

abstract class ProfileRepository {
  Future<Profile> findById(String id);
  Future<List<Profile>> findAll();
  Future<Profile> save(Profile profile);
  Future<void> delete(String id);
}
