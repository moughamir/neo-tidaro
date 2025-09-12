import '../enums/activity_type.dart';
import '../enums/professional_status.dart';

/// Maps between ProfessionalStatus and ProfessionalActivityStatus
///
/// This helps resolve the confusion between:
/// - ProfessionalStatus: Backend/database representation (pending, active, etc.)
/// - ProfessionalActivityStatus: UI-focused representation (available, onJob, etc.)
class ProfessionalStatusMapper {
  /// Maps a ProfessionalActivityStatus to the corresponding ProfessionalStatus
  static ProfessionalStatus fromActivityStatus(ProfessionalActivityStatus status) {
    switch (status) {
      case ProfessionalActivityStatus.available:
        return ProfessionalStatus.active;
      case ProfessionalActivityStatus.onJob:
        return ProfessionalStatus.active; // Still active, but busy
      case ProfessionalActivityStatus.offline:
        return ProfessionalStatus.inactive;
      case ProfessionalActivityStatus.onBreak:
        return ProfessionalStatus.active; // Still active, just on break
      // All cases are covered above
    }
  }

  /// Maps a ProfessionalStatus to the most appropriate ProfessionalActivityStatus
  static ProfessionalActivityStatus toActivityStatus(ProfessionalStatus status) {
    switch (status) {
      case ProfessionalStatus.active:
        return ProfessionalActivityStatus.available;
      case ProfessionalStatus.inactive:
        return ProfessionalActivityStatus.offline;
      case ProfessionalStatus.suspended:
      case ProfessionalStatus.rejected:
        return ProfessionalActivityStatus.offline;
      case ProfessionalStatus.pending:
      case ProfessionalStatus.underReview:
        return ProfessionalActivityStatus.offline;
    }
  }
}
