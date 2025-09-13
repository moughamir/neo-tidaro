import '../enums/activity_type.dart';

/// Maps between ProfessionalStatus and ProfessionalActivityStatus
///
/// This helps resolve the confusion between:
/// - ProfessionalStatus: Backend/database representation (pending, active, etc.)
/// - ProfessionalActivityStatus: UI-focused representation (available, onJob, etc.)
class ProfessionalStatusMapper {
  /// Maps a ProfessionalActivityStatus to the corresponding ProfessionalStatus
  static ProfessionalKycStatus fromActivityStatus(
    ProfessionalActivityStatus status,
  ) {
    switch (status) {
      case ProfessionalActivityStatus.available:
        return ProfessionalKycStatus.active;
      case ProfessionalActivityStatus.onJob:
        return ProfessionalKycStatus.active; // Still active, but busy
      case ProfessionalActivityStatus.offline:
        return ProfessionalKycStatus.inactive;
      case ProfessionalActivityStatus.onBreak:
        return ProfessionalKycStatus.active; // Still active, just on break
      // All cases are covered above
    }
  }

  /// Maps a ProfessionalStatus to the most appropriate ProfessionalActivityStatus
  static ProfessionalActivityStatus toActivityStatus(
    ProfessionalKycStatus status,
  ) {
    switch (status) {
      case ProfessionalKycStatus.active:
        return ProfessionalActivityStatus.available;
      case ProfessionalKycStatus.inactive:
        return ProfessionalActivityStatus.offline;
      case ProfessionalKycStatus.suspended:
      case ProfessionalKycStatus.rejected:
        return ProfessionalActivityStatus.offline;
      case ProfessionalKycStatus.pending:
      case ProfessionalKycStatus.underReview:
        return ProfessionalActivityStatus.offline;
    }
  }
}
