import '../dto/create_address_dto.dart';
import '../dto/pagination_dto.dart';
import '../dto/submit_kyc_dto.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'base_repository.dart';

/// User repository with generic base and domain-specific operations
abstract class UserRepository extends BaseRepository<User> {
  // User-specific lookups
  Future<RepositoryResult<User>> getByEmail(String email);
  Future<RepositoryResult<User>> getByPhone(String phoneNumber);
  
  // Profile management
  Future<RepositoryResult<UserProfile>> getProfile(String userId);
  Future<RepositoryResult<UserProfile>> updateProfile(UserProfile profile);
  
  // Address management
  Future<RepositoryResult<List<Address>>> getUserAddresses(String userId);
  Future<RepositoryResult<Address>> addAddress(CreateAddressDto dto);
  Future<RepositoryResult<bool>> setDefaultAddress(String userId, String addressId);
  
  // KYC operations
  Future<RepositoryResult<KycDocument>> submitKyc(SubmitKycDto dto);
  Future<RepositoryResult<KycLevel>> getKycLevel(String userId);
  
  // Enhanced search with filters
  Future<RepositoryResult<List<User>>> searchUsers({
    String? query,
    UserRole? role,
    UserStatus? status,
    PaginationDto? pagination,
    Map<String, dynamic>? additionalFilters,
  });
}
