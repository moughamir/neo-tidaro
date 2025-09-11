import 'package:domain/domain.dart';

/// Business-specific repository interfaces using domain entities

abstract class ProfileRepository {
  Future<UserProfile> findById(String id);
  Future<List<UserProfile>> findAll();
  Future<UserProfile> save(UserProfile profile);
  Future<void> delete(String id);
}
