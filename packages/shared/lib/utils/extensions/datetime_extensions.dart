// lib/shared/utils/extensions/datetime_extensions.dart

import 'package:intl/intl.dart';
import 'package:languist/l10n/gen/intl_localizations.dart';

/// This extension provides DateTime formatting utilities for consistent date handling
/// across the application.

/// Extension methods for [DateTime] to provide formatting and relative time logic,
/// similar to the popular moment.js library.
extension DateTimeExtensions on DateTime {
  /// Formats the date using the specified [pattern].
  ///
  /// Example: `DateTime.now().format('dd/MM/yyyy HH:mm')` -> "03/09/2025 14:30"
  String format(String pattern) {
    try {
      return DateFormat(pattern).format(this);
    } catch (e) {
      return toString();
    }
  }

  /// Returns a human-readable relative time string (e.g., "a moment ago", "in 5 minutes").
  ///
  /// Requires [IntlLocalizations] to provide localized strings.
  String fromNow(IntlLocalizations l10n) {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inSeconds < 5) {
      return l10n.justNow;
    } else if (difference.inMinutes < 1) {
      return l10n.fromNow(l10n.justNow);
    } else if (difference.inMinutes < 2) {
      return l10n.aMinuteAgo;
    } else if (difference.inHours < 1) {
      return l10n.minutesAgo(difference.inMinutes.toString());
    } else if (difference.inHours < 2) {
      return l10n.anHourAgo;
    } else if (difference.inDays < 1) {
      return l10n.hoursAgo(difference.inHours.toString());
    } else if (difference.inDays < 2) {
      return l10n.aDayAgo;
    } else {
      return l10n.daysAgo(difference.inDays.toString());
    }
  }

  /// Checks if the date is today.
  bool get isToday {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  /// Checks if the date was yesterday.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  /// Checks if the date is tomorrow.
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.day == day &&
        tomorrow.month == month &&
        tomorrow.year == year;
  }

  /// Returns a new [DateTime] instance with the time set to the start of the day (00:00:00).
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns a new [DateTime] instance with the time set to the end of the day (23:59:59.999).
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999);
}
