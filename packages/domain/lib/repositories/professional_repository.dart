import '../dto/dto.dart';
import '../entities/entities.dart';
import '../enums/enums.dart';
import 'base_repository.dart';

/// Professional-specific repository extending generic base
abstract class ProfessionalRepository
    extends BaseRepository<ProfessionalProfile> {
  // Professional-specific operations
  Future<RepositoryResult<ProfessionalProfile>> getByUserId(String userId);
  Future<RepositoryResult<ProfessionalProfile>> register(
    ProfessionalRegistrationDto dto,
  );

  // Override search with professional-specific DTO support
  Future<RepositoryResult<List<ProfessionalProfile>>> searchProfessionals(
    ProfessionalSearchDto dto,
  );

  Future<RepositoryResult<List<ProfessionalProfile>>> getNearby({
    required GeoLocation location,
    required double radius,
    PreBookingServiceCategory? category,
  });

  Future<RepositoryResult<List<ProfessionalProfile>>> getTopRated({
    PreBookingServiceCategory? category,
    int limit = 10,
  });

  // Availability management
  Future<RepositoryResult<bool>> updateAvailability(SetAvailabilityDto dto);
  Future<RepositoryResult<List<Availability>>> getAvailability(
    String professionalId,
  );

  // Service management
  Future<RepositoryResult<List<Service>>> getServices(String professionalId);
  Future<RepositoryResult<Service>> addService(CreateServiceDto dto);
  Future<RepositoryResult<bool>> updateService(Service service);
  Future<RepositoryResult<bool>> toggleServiceStatus(
    String serviceId,
    bool isActive,
  );

  // Reviews and statistics
  Future<RepositoryResult<List<Review>>> getReviews(String professionalId);
  Future<RepositoryResult<ProfessionalStatistics>> getStatistics(
    String professionalId,
  );

  // Reactive streams
  Stream<ProfessionalProfile> watchProfessional(String professionalId);
}

/// Professional statistics domain object
class ProfessionalStatistics {
  const ProfessionalStatistics({
    required this.averageRating,
    required this.totalReviews,
    required this.completedJobs,
    required this.responseRate,
    required this.averageResponseTime,
    required this.totalEarnings,
    required this.jobsByCategory,
  });
  final double averageRating;
  final int totalReviews;
  final int completedJobs;
  final double responseRate;
  final Duration averageResponseTime;
  final int totalEarnings;
  final Map<PreBookingServiceCategory, int> jobsByCategory;
}
