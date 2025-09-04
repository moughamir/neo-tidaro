// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'intl_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Standard Moroccan Tamazight (`zgh`).
class IntlLocalizationsZgh extends IntlLocalizations {
  IntlLocalizationsZgh([String locale = 'zgh']) : super(locale);

  @override
  String get appTitle => 'ⵜⵉⴷⴰⵔⵓ';

  @override
  String get settings => 'ⵜⵉⵙⵖⴰⵍ';

  @override
  String get themeSettings => 'ⵜⵉⵙⵖⴰⵍ ⵏ ⵓⴷⵎⴰⵡⴰⵍ';

  @override
  String get languageSettings => 'ⵜⵉⵙⵖⴰⵍ ⵏ ⵜⵓⵜⵍⴰⵢⵜ';

  @override
  String get ok => 'OK';

  @override
  String get hello => 'ⴰⵣⵓⵍ';

  @override
  String helloUser(Object userName) {
    return 'ⴰⵣⵓⵍ $userName';
  }

  @override
  String fromNow(Object time) {
    return 'ⵣⴳ $time';
  }

  @override
  String get justNow => 'ⵖⵉⵍⴰⴷ';

  @override
  String get aMinuteAgo => 'ⵣⴳ ⵢⴰⵏ ⵓⵙⴷⵉⴷ';

  @override
  String minutesAgo(Object minutes) {
    return 'ⵣⴳ $minutes ⵜⵓⵙⴷⵉⴷⵉⵏ';
  }

  @override
  String get anHourAgo => 'ⵣⴳ ⵢⴰⵏ ⵓⵙⵔⴰⴳ';

  @override
  String hoursAgo(Object hours) {
    return 'ⵣⴳ $hours ⵜⵙⵔⴰⴳⵉⵏ';
  }

  @override
  String get aDayAgo => 'ⵣⴳ ⵢⴰⵏ ⵡⴰⵙⵙ';

  @override
  String daysAgo(Object days) {
    return 'ⵣⴳ $days ⵡⵓⵙⵙⴰⵏ';
  }
}
