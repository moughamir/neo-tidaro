import 'package:domain/domain.dart';
import 'package:flutter/widgets.dart';

/// Localization helpers for domain enums using AppLocalizations (Languist wrapper)
/// Falls back to humanized names when a specific key is not present.

extension _StringHumanizeX on String {
  String humanize() {
    final buffer = StringBuffer();
    for (int i = 0; i < length; i++) {
      final ch = this[i];
      if (i > 0 && ch.toUpperCase() == ch && ch.toLowerCase() != ch) {
        buffer.write(' ');
      }
      buffer.write(ch);
    }
    final s = buffer.toString().replaceAll('_', ' ');
    return s[0].toUpperCase() + s.substring(1);
  }
}

extension BookingStatusL10n on BookingActivityStatus {
  String label(BuildContext context) {
    switch (this) {
      case BookingActivityStatus.pending:
        return 'pending'.humanize();
      case BookingActivityStatus.confirmed:
        return 'confirmed'.humanize();
      case BookingActivityStatus.assigned:
        return 'assigned'.humanize();
      case BookingActivityStatus.inProgress:
        return 'in_progress'.humanize();
      case BookingActivityStatus.completed:
        return 'completed'.humanize();
      case BookingActivityStatus.cancelled:
        return 'cancelled'.humanize();
      case BookingActivityStatus.rescheduled:
        return 'rescheduled'.humanize();
      case BookingActivityStatus.noShow:
        return 'no_show'.humanize();
    }
  }
}

extension ProfessionalStatusL10n on ProfessionalActivityStatus {
  String label(BuildContext context) {
    switch (this) {
      case ProfessionalActivityStatus.available:
        return 'available'.humanize();
      case ProfessionalActivityStatus.onJob:
        return 'on_job'.humanize();
      case ProfessionalActivityStatus.offline:
        return 'offline'.humanize();
      case ProfessionalActivityStatus.onBreak:
        return 'on_break'.humanize();
    }
  }
}

extension ServiceCategoryL10n on PreBookingServiceCategory {
  String label(BuildContext context) {
    switch (this) {
      case PreBookingServiceCategory.standardCleaning:
        return 'standard_cleaning'.humanize();
      case PreBookingServiceCategory.regularCleaning:
        return 'regular_cleaning'.humanize();
      case PreBookingServiceCategory.deepCleaning:
        return 'deep_cleaning'.humanize();
      case PreBookingServiceCategory.moveInOut:
        return 'move_in_out'.humanize();
      case PreBookingServiceCategory.postConstruction:
        return 'post_construction'.humanize();
      case PreBookingServiceCategory.commercial:
        return 'commercial'.humanize();
      case PreBookingServiceCategory.residential:
        return 'residential'.humanize();
      case PreBookingServiceCategory.specialized:
        return 'specialized'.humanize();
      case PreBookingServiceCategory.cleaning:
        return 'cleaning'.humanize();
      case PreBookingServiceCategory.laundry:
        return 'laundry'.humanize();
      case PreBookingServiceCategory.cooking:
        return 'cooking'.humanize();
      case PreBookingServiceCategory.babysitting:
        return 'babysitting'.humanize();
      case PreBookingServiceCategory.petCare:
        return 'pet_care'.humanize();
      case PreBookingServiceCategory.gardening:
        return 'gardening'.humanize();
      case PreBookingServiceCategory.maintenance:
        return 'maintenance'.humanize();
      case PreBookingServiceCategory.organization:
        return 'organization'.humanize();
      case PreBookingServiceCategory.other:
        return 'other'.humanize();
    }
  }
}
