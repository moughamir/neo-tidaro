import 'package:moment_dart/moment_dart.dart';
import '../../l10n/gen/intl_localizations.dart';

/// Bridge between Languist localization and moment_dart
/// This class provides seamless integration between the two systems
class MomentBridge {
  /// Set the global moment_dart localization based on Languist locale
  static void setMomentLocalizationFromLanguist(IntlLocalizations l10n) {
    final localeCode = l10n.localeName.split('_')[0];

    // Set moment_dart global localization based on the locale
    switch (localeCode) {
      case 'ar':
        Moment.setGlobalLocalization(MomentLocalizations.arPs());
        break;
      case 'fr':
        Moment.setGlobalLocalization(MomentLocalizations.fr());
        break;
      case 'es':
        Moment.setGlobalLocalization(MomentLocalizations.es());
        break;

      default:
        Moment.setGlobalLocalization(MomentLocalizations.enUS());
    }
  }

  /// Create a localized Moment instance from a DateTime
  static Moment createLocalizedMoment(
    DateTime dateTime,
    IntlLocalizations l10n,
  ) {
    setMomentLocalizationFromLanguist(l10n);
    return Moment(dateTime);
  }

  /// Create a localized Moment instance with specific localization
  static Moment createMomentWithLocalization(
    DateTime dateTime,
    MomentLocalization localization,
  ) {
    return Moment(dateTime, localization: localization);
  }
}

/// Extension methods for DateTime to work with moment_dart through Languist
extension DateTimeMomentExtension on DateTime {
  /// Convert this DateTime to a localized Moment
  Moment toLocalizedMoment(IntlLocalizations l10n) {
    return MomentBridge.createLocalizedMoment(this, l10n);
  }

  /// Get a localized relative time string (e.g., "5 minutes ago")
  String toRelativeTime(IntlLocalizations l10n) {
    return toLocalizedMoment(l10n).fromNow();
  }

  /// Get a localized calendar string (e.g., "Today at 2:30 PM")
  String toCalendarString(IntlLocalizations l10n) {
    return toLocalizedMoment(l10n).calendar();
  }

  /// Format this DateTime with a pattern using moment_dart
  String formatWithPattern(String pattern, IntlLocalizations l10n) {
    return toLocalizedMoment(l10n).format(pattern);
  }
}
