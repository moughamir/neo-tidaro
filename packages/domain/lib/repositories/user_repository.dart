import 'package:core/core.dart';

import '../dto/create_address_dto.dart';
import '../dto/pagination_dto.dart';
import '../dto/submit_kyc_dto.dart';
import '../dto/user_dto.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'base_repository.dart';

/// User repository with Supabase integration and domain-specific operations
abstract class UserRepository extends BaseRepository<User> {
  // User-specific lookups
  Future<RepositoryResult<User>> getByEmail(String email);
  Future<RepositoryResult<User>> getByPhone(String phoneNumber);
  Future<RepositoryResult<User>> getBySupabaseUserId(String supabaseUserId);

  // User management operations
  Future<RepositoryResult<User>> createUser(CreateUserDto dto);
  Future<RepositoryResult<User>> updateUser(
    String id,
    Map<String, dynamic> updates,
  );
  Future<RepositoryResult<User>> updateRole(String id, PlatformUserRole role);
  Future<RepositoryResult<bool>> syncWithSupabaseAuth(
    String userId,
    Map<String, dynamic> authData,
  );

  // Profile management
  Future<RepositoryResult<Profile>> getProfile(String userId);
  Future<RepositoryResult<Profile>> createProfile(CreateUserProfileDto dto);
  Future<RepositoryResult<Profile>> updateProfile(
    String profileId,
    UpdateUserProfileDto dto,
  );
  Future<RepositoryResult<bool>> deleteProfile(String profileId);

  // Client profile operations
  Future<RepositoryResult<ClientProfile>> getClientProfile(String userId);
  Future<RepositoryResult<ClientProfile>> createClientProfile(
    String userId,
    Map<String, dynamic> data,
  );
  Future<RepositoryResult<ClientProfile>> updateClientProfile(
    String profileId,
    Map<String, dynamic> data,
  );

  // Professional profile operations
  Future<RepositoryResult<ProfessionalProfile>> getProfessionalProfile(
    String userId,
  );
  Future<RepositoryResult<ProfessionalProfile>> createProfessionalProfile(
    String userId,
    Map<String, dynamic> data,
  );
  Future<RepositoryResult<ProfessionalProfile>> updateProfessionalProfile(
    String profileId,
    Map<String, dynamic> data,
  );

  // Address management
  Future<RepositoryResult<List<Address>>> getUserAddresses(String userId);
  Future<RepositoryResult<Address>> addAddress(CreateAddressDto dto);
  Future<RepositoryResult<bool>> setDefaultAddress(
    String userId,
    String addressId,
  );

  // KYC operations
  Future<RepositoryResult<KycDocument>> submitKyc(SubmitKycDto dto);
  Future<RepositoryResult<KycLevel>> getKycLevel(String userId);

  // Enhanced search with filters
  Future<RepositoryResult<List<User>>> searchUsers({
    String? query,
    PlatformUserRole? role,
    PlatformUserStatus? status,
    PaginationDto? pagination,
    Map<String, dynamic>? additionalFilters,
  });

  // User verification operations
  Future<RepositoryResult<bool>> verifyEmail(String userId);
  Future<RepositoryResult<bool>> verifyPhone(String userId);
  Future<RepositoryResult<bool>> updateLastLogin(String userId);
}
