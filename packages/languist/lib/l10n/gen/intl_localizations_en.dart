// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'intl_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class IntlLocalizationsEn extends IntlLocalizations {
  IntlLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'TiDaro';

  @override
  String get settings => 'Settings';

  @override
  String get themeSettings => 'Theme Settings';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get hello => 'Hello';

  @override
  String helloUser(Object userName) {
    return 'Hello $userName';
  }

  @override
  String fromNow(Object time) {
    return '$time ago';
  }

  @override
  String get justNow => 'just now';

  @override
  String get aMinuteAgo => 'a minute ago';

  @override
  String minutesAgo(Object minutes) {
    return '$minutes minutes ago';
  }

  @override
  String get anHourAgo => 'an hour ago';

  @override
  String hoursAgo(Object hours) {
    return '$hours hours ago';
  }

  @override
  String get aDayAgo => 'a day ago';

  @override
  String daysAgo(Object days) {
    return '$days days ago';
  }
}
