import 'package:flutter/widgets.dart';
import 'package:shared/shared.dart';

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

extension BookingStatusL10n on BookingStatus {
  String label(BuildContext context) {
    switch (this) {
      case BookingStatus.pending:
        return 'pending'.humanize();
      case BookingStatus.confirmed:
        return 'confirmed'.humanize();
      case BookingStatus.assigned:
        return 'assigned'.humanize();
      case BookingStatus.inProgress:
        return 'in_progress'.humanize();
      case BookingStatus.completed:
        return 'completed'.humanize();
      case BookingStatus.cancelled:
        return 'cancelled'.humanize();
      case BookingStatus.rescheduled:
        return 'rescheduled'.humanize();
      case BookingStatus.noShow:
        return 'no_show'.humanize();
    }
  }
}

extension CleanerStatusL10n on CleanerStatus {
  String label(BuildContext context) {
    switch (this) {
      case CleanerStatus.available:
        return 'available'.humanize();
      case CleanerStatus.onJob:
        return 'on_job'.humanize();
      case CleanerStatus.offline:
        return 'offline'.humanize();
      case CleanerStatus.onBreak:
        return 'on_break'.humanize();
    }
  }
}

extension ServiceCategoryL10n on ServiceCategory {
  String label(BuildContext context) {
    switch (this) {
      case ServiceCategory.standardCleaning:
        return 'standard_cleaning'.humanize();
      case ServiceCategory.regularCleaning:
        return 'regular_cleaning'.humanize();
      case ServiceCategory.deepCleaning:
        return 'deep_cleaning'.humanize();
      case ServiceCategory.moveInOut:
        return 'move_in_out'.humanize();
      case ServiceCategory.postConstruction:
        return 'post_construction'.humanize();
      case ServiceCategory.commercial:
        return 'commercial'.humanize();
      case ServiceCategory.residential:
        return 'residential'.humanize();
      case ServiceCategory.specialized:
        return 'specialized'.humanize();
    }
  }
}
