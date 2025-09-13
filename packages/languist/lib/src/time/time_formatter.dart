import '../../l10n/gen/intl_localizations.dart';
import 'moment_bridge.dart';

/// Advanced time formatting utilities using Languist and moment_dart
class TimeFormatter {
  /// Formats a timestamp for display in a short, relative format (e.g., "5m ago", "2h ago")
  static String formatTimestampShort(
    DateTime timestamp,
    IntlLocalizations l10n,
  ) {
    final moment = timestamp.toLocalizedMoment(l10n);
    return moment.fromNow(dropPrefixOrSuffix: false);
  }

  /// Formats a timestamp for display in a verbose, relative format (e.g., "5 minutes ago")
  static String formatLastUpdated(DateTime dateTime, IntlLocalizations l10n) {
    final moment = dateTime.toLocalizedMoment(l10n);
    return moment.fromNow(dropPrefixOrSuffix: false);
  }

  /// Returns a greeting based on the time of day with localization
  static String getGreeting(IntlLocalizations l10n) {
    final hour = DateTime.now().hour;

    // Use localized greeting from Languist
    if (hour < 12) {
      return l10n.greetGoodMorning;
    } else if (hour < 17) {
      return l10n.greetGoodAfternoon;
    } else {
      return l10n.greetGoodEvening;
    }
  }

  /// Formats the time part of a DateTime object with localization
  static String formatTime(DateTime timestamp, IntlLocalizations l10n) {
    return timestamp.formatWithPattern('HH:mm', l10n);
  }

  /// Formats a timestamp for a full date and time display with localization
  static String formatFullTimestamp(
    DateTime timestamp,
    IntlLocalizations l10n,
  ) {
    return timestamp.toCalendarString(l10n);
  }

  /// Convert a Duration to a human-readable string with localization
  static String formatDuration(Duration duration, IntlLocalizations l10n) {
    MomentBridge.setMomentLocalizationFromLanguist(l10n);
    
    if (duration.inDays > 0) {
      return duration.inDays == 1 
          ? l10n.durationDays(duration.inDays)
          : l10n.durationDaysPlural(duration.inDays);
    } else if (duration.inHours > 0) {
      return duration.inHours == 1 
          ? l10n.durationHours(duration.inHours)
          : l10n.durationHoursPlural(duration.inHours);
    } else if (duration.inMinutes > 0) {
      return duration.inMinutes == 1 
          ? l10n.durationMinutes(duration.inMinutes)
          : l10n.durationMinutesPlural(duration.inMinutes);
    } else {
      return duration.inSeconds == 1 
          ? l10n.durationSeconds(duration.inSeconds)
          : l10n.durationSecondsPlural(duration.inSeconds);
    }
  }

  /// Format a date in a specific pattern with localization
  static String formatDate(
    DateTime date,
    String pattern,
    IntlLocalizations l10n,
  ) {
    return date.formatWithPattern(pattern, l10n);
  }

  /// Get a date for a specific weekday (e.g., next Monday)
  static DateTime getNextWeekday(int weekday, [DateTime? fromDate]) {
    final date = fromDate ?? DateTime.now();
    // Simple implementation to get next weekday
    int daysUntilTarget = (weekday - date.weekday) % 7;
    if (daysUntilTarget == 0) {
      daysUntilTarget = 7; // If today is the target day, get next week
    }
    return date.add(Duration(days: daysUntilTarget));
  }

  /// Get start of a specific time unit (day, week, month, year)
  static DateTime startOf(DateTime date, String unit) {
    switch (unit.toLowerCase()) {
      case 'day':
        return DateTime(date.year, date.month, date.day);
      case 'week':
        // Start of week (Monday)
        final int daysFromMonday = date.weekday - 1;
        return DateTime(
          date.year,
          date.month,
          date.day,
        ).subtract(Duration(days: daysFromMonday));
      case 'month':
        return DateTime(date.year, date.month, 1);
      case 'year':
        return DateTime(date.year, 1, 1);
      default:
        return date;
    }
  }

  /// Check if a date is between two other dates
  static bool isBetween(DateTime date, DateTime start, DateTime end) {
    return date.isAfter(start) && date.isBefore(end);
  }
}
