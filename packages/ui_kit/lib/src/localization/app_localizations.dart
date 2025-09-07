import 'package:flutter/widgets.dart';
import 'package:languist/languist.dart';

/// A utility class that provides easy access to localized strings
/// throughout the application.
///
/// This wrapper around the Languist package makes it easier to use
/// localization in UI components.
class AppLocalizations {
  /// The BuildContext used to access Languist
  final BuildContext context;

  /// Create an instance with the current BuildContext
  AppLocalizations(this.context);

  /// Returns the IntlLocalizations instance for the current context
  IntlLocalizations get _localizations => Languist.of(context);
  
  /// Get the application title
  String get appTitle => _localizations.appTitle;
  
  /// Get the settings text
  String get settings => _localizations.settings;
  
  /// Get the theme settings text
  String get themeSettings => _localizations.themeSettings;
  
  /// Get the language settings text
  String get languageSettings => _localizations.languageSettings;
  
  /// Get the hello text
  String get hello => _localizations.hello;
  
  /// Get a personalized hello with the user's name
  String helloUser(String userName) => _localizations.helloUser(userName);
  
  /// Get a formatted time in the past
  String fromNow(String time) => _localizations.fromNow(time);
  
  /// Get the "just now" text
  String get justNow => _localizations.justNow;
  
  /// Get the "a minute ago" text
  String get aMinuteAgo => _localizations.aMinuteAgo;
  
  /// Get the "X minutes ago" text
  String minutesAgo(int minutes) => _localizations.minutesAgo(minutes);
  
  /// Get the "an hour ago" text
  String get anHourAgo => _localizations.anHourAgo;
  
  /// Get the "X hours ago" text
  String hoursAgo(int hours) => _localizations.hoursAgo(hours);
  
  /// Get the "a day ago" text
  String get aDayAgo => _localizations.aDayAgo;
  
  /// Get the "X days ago" text
  String daysAgo(int days) => _localizations.daysAgo(days);

  // --- Status/availability strings used by housekeeping UI ---
  String get available => _localizations.available;
  String get busy => _localizations.busy;
  String get offline => _localizations.offline;
  // We map onBreak to "away" in Languist to keep wording short in chips
  String get away => _localizations.away;

  /// Simplified way to access AppLocalizations from a BuildContext
  static AppLocalizations of(BuildContext context) {
    return AppLocalizations(context);
  }
  
  /// The localization delegates to be added to MaterialApp
  static const localizationsDelegates = Languist.localizationsDelegates;
  
  /// The supported locales to be added to MaterialApp
  static const supportedLocales = Languist.supportedLocales;
}
