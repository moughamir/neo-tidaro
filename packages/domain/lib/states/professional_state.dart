import '../entities/entities.dart';
import '../dto/professional_search_dto.dart';

/// Professional domain state
///
/// This is the domain model for professional state, which is used by the
/// ProfessionalState in Redux as the source of truth for business logic.
/// The Redux state wraps this domain state with UI-specific properties.
class ProfessionalState {
  /// The currently active professional (logged-in professional or selected one)
  final ProfessionalProfile? currentProfessional;
  
  /// Results of the latest professional search operation
  final List<ProfessionalProfile> searchResults;
  
  /// Nearby professionals based on geolocation
  final List<ProfessionalProfile> nearbyProfessionals;
  
  /// Cache of professionals by ID for quick lookup
  final Map<String, ProfessionalProfile> professionalCache;
  
  /// Whether a search operation is in progress
  final bool isSearching;
  
  /// Error message if something went wrong
  final String? error;
  
  /// Current search parameters/filters
  final ProfessionalSearchDto? searchParams;

  const ProfessionalState({
    this.currentProfessional,
    this.searchResults = const [],
    this.nearbyProfessionals = const [],
    this.professionalCache = const {},
    required this.isSearching,
    this.error,
    this.searchParams,
  });

  /// Creates an initial empty state
  factory ProfessionalState.initial() =>
      const ProfessionalState(isSearching: false);
      
  /// Creates a copy of this state with the specified fields replaced
  ProfessionalState copyWith({
    ProfessionalProfile? currentProfessional,
    List<ProfessionalProfile>? searchResults,
    List<ProfessionalProfile>? nearbyProfessionals,
    Map<String, ProfessionalProfile>? professionalCache,
    bool? isSearching,
    String? error,
    ProfessionalSearchDto? searchParams,
  }) {
    return ProfessionalState(
      currentProfessional: currentProfessional ?? this.currentProfessional,
      searchResults: searchResults ?? this.searchResults,
      nearbyProfessionals: nearbyProfessionals ?? this.nearbyProfessionals,
      professionalCache: professionalCache ?? this.professionalCache,
      isSearching: isSearching ?? this.isSearching,
      error: error ?? this.error,
      searchParams: searchParams ?? this.searchParams,
    );
  }
}
