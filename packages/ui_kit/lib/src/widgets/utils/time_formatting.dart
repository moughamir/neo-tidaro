import 'package:flutter/material.dart';
import 'package:languist/languist.dart';

/// Time formatting utilities with full internationalization support
/// These utilities use the Languist package for localization and moment_dart integration

/// Extension methods for easy DateTime formatting with Languist
extension DateTimeFormatting on DateTime {
  /// Converts this DateTime to a localized relative time string (e.g., "5 minutes ago")
  String toRelativeTime(BuildContext context) {
    final l10n = Languist.of(context);
    return TimeFormatter.formatLastUpdated(this, l10n);
  }

  /// Converts this DateTime to a localized short format relative time (e.g., "5m ago")
  String toShortRelativeTime(BuildContext context) {
    final l10n = Languist.of(context);
    return TimeFormatter.formatTimestampShort(this, l10n);
  }

  /// Gets a calendar representation (e.g., "Today at 2:30 PM")
  String toCalendarString(BuildContext context) {
    final l10n = Languist.of(context);
    return TimeFormatter.formatFullTimestamp(this, l10n);
  }

  /// Gets a formatted time string using moment_dart through Languist
  String toFormattedString(String pattern, BuildContext context) {
    final l10n = Languist.of(context);
    return TimeFormatter.formatDate(this, pattern, l10n);
  }
}

/// Formats a timestamp for display in a short, relative format (e.g., "5m ago", "2h ago").
String formatTimestampShort(DateTime timestamp, [dynamic l10n]) {
  if (l10n != null) {
    return TimeFormatter.formatTimestampShort(timestamp, l10n);
  } else {
    // Fallback to built-in functionality
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}

/// Formats a timestamp for display in a verbose, relative format (e.g., "5 minutes ago").
String formatLastUpdated(DateTime dateTime, [dynamic l10n]) {
  if (l10n != null) {
    return TimeFormatter.formatLastUpdated(dateTime, l10n);
  } else {
    // Fallback to built-in functionality
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      final minutes = difference.inMinutes;
      return '$minutes minute${minutes == 1 ? '' : 's'} ago';
    } else if (difference.inHours < 24) {
      final hours = difference.inHours;
      return '$hours hour${hours == 1 ? '' : 's'} ago';
    } else {
      final days = difference.inDays;
      return '$days day${days == 1 ? '' : 's'} ago';
    }
  }
}

/// Returns a greeting based on the time of day (e.g., "Good Morning").
String getGreeting([dynamic l10n]) {
  final hour = DateTime.now().hour;

  // Time-based greeting formatting
  String timeBasedGreeting;
  if (hour < 12) {
    timeBasedGreeting = 'Good Morning';
  } else if (hour < 17) {
    timeBasedGreeting = 'Good Afternoon';
  } else {
    timeBasedGreeting = 'Good Evening';
  }

  // Use Languist localization if provided
  if (l10n != null) {
    // Since Languist doesn't have specific time-of-day greetings,
    // we use hello with the appropriate time greeting
    return l10n.hello;
  }

  return timeBasedGreeting;
}

/// Formats the time part of a DateTime object (e.g., "14:30").
String formatTime(DateTime timestamp, [dynamic l10n]) {
  if (l10n != null) {
    return TimeFormatter.formatDate(timestamp, 'HH:mm', l10n);
  }
  return DateFormat('HH:mm').format(timestamp);
}

/// Formats a timestamp for a full date and time display (e.g., "Today at 14:30").
String formatFullTimestamp(DateTime timestamp, [dynamic l10n]) {
  if (l10n != null) {
    return TimeFormatter.formatFullTimestamp(timestamp, l10n);
  } else {
    // Fallback to built-in functionality
    final now = DateTime.now();
    final timeStr = formatTime(timestamp);

    if (DateUtils.isSameDay(timestamp, now)) {
      return 'Today at $timeStr';
    } else if (DateUtils.isSameDay(
      timestamp,
      now.subtract(const Duration(days: 1)),
    )) {
      return 'Yesterday at $timeStr';
    } else if (now.difference(timestamp).inDays < 7 && now.isAfter(timestamp)) {
      return '${DateFormat('EEEE').format(timestamp)} at $timeStr';
    } else {
      return '${DateFormat('yyyy-MM-dd').format(timestamp)} at $timeStr';
    }
  }
}

/// Advanced time formatting utilities using Languist TimeFormatter
class TimeUtils {
  /// Convert a DateTime to a human-readable duration string
  static String toDurationString(Duration duration, [dynamic l10n]) {
    if (l10n != null) {
      return TimeFormatter.formatDuration(duration, l10n);
    }
    // Fallback to basic duration formatting
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    if (days > 0) {
      return '${days}d ${hours}h ${minutes}m';
    } else if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }

  /// Format a date in a specific pattern with localization
  static String formatDate(DateTime date, String pattern, [dynamic l10n]) {
    if (l10n != null) {
      return TimeFormatter.formatDate(date, pattern, l10n);
    }
    return DateFormat(pattern).format(date);
  }

  /// Get a date for a specific weekday (e.g., next Monday)
  static DateTime getNextWeekday(int weekday, [DateTime? fromDate]) {
    final date = fromDate ?? DateTime.now();
    final daysUntilWeekday = (weekday - date.weekday) % 7;
    final daysToAdd = daysUntilWeekday == 0 ? 7 : daysUntilWeekday;
    return date.add(Duration(days: daysToAdd));
  }

  /// Get start of a specific time unit (day, week, month, year)
  static DateTime startOf(DateTime date, String unit) {
    switch (unit.toLowerCase()) {
      case 'day':
        return DateTime(date.year, date.month, date.day);
      case 'week':
        final daysFromMonday = date.weekday - 1;
        return DateTime(date.year, date.month, date.day - daysFromMonday);
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
