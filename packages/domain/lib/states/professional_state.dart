import '../entities/entities.dart';

class ProfessionalState {
  final ProfessionalProfile? currentProfessional;
  final List<ProfessionalProfile> searchResults;
  final List<ProfessionalProfile> nearbyProfessionals;
  final Map<String, ProfessionalProfile> professionalCache;
  final bool isSearching;
  final String? error;

  const ProfessionalState({
    this.currentProfessional,
    this.searchResults = const [],
    this.nearbyProfessionals = const [],
    this.professionalCache = const {},
    required this.isSearching,
    this.error,
  });

  factory ProfessionalState.initial() =>
      const ProfessionalState(isSearching: false);
}
