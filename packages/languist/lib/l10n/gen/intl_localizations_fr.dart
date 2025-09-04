// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'intl_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class IntlLocalizationsFr extends IntlLocalizations {
  IntlLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'TiDaro';

  @override
  String get settings => 'Paramètres';

  @override
  String get themeSettings => 'Paramètres du thème';

  @override
  String get languageSettings => 'Paramètres de langue';

  @override
  String get ok => 'OK';

  @override
  String get hello => 'Bonjour';

  @override
  String helloUser(Object userName) {
    return 'Bonjour $userName';
  }

  @override
  String fromNow(Object time) {
    return 'il y a $time';
  }

  @override
  String get justNow => 'à l\'instant';

  @override
  String get aMinuteAgo => 'il y a une minute';

  @override
  String minutesAgo(Object minutes) {
    return 'il y a $minutes minutes';
  }

  @override
  String get anHourAgo => 'il y a une heure';

  @override
  String hoursAgo(Object hours) {
    return 'il y a $hours heures';
  }

  @override
  String get aDayAgo => 'il y a un jour';

  @override
  String daysAgo(Object days) {
    return 'il y a $days jours';
  }
}
