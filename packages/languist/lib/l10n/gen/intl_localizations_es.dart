// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'intl_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class IntlLocalizationsEs extends IntlLocalizations {
  IntlLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'TiDaro';

  @override
  String get settings => 'Ajustes';

  @override
  String get themeSettings => 'Ajustes de tema';

  @override
  String get languageSettings => 'Ajustes de idioma';

  @override
  String get ok => 'OK';

  @override
  String get hello => 'Hola';

  @override
  String helloUser(Object userName) {
    return 'Hola $userName';
  }

  @override
  String fromNow(Object time) {
    return 'hace $time';
  }

  @override
  String get justNow => 'ahora mismo';

  @override
  String get aMinuteAgo => 'hace un minuto';

  @override
  String minutesAgo(Object minutes) {
    return 'hace $minutes minutos';
  }

  @override
  String get anHourAgo => 'hace una hora';

  @override
  String hoursAgo(Object hours) {
    return 'hace $hours horas';
  }

  @override
  String get aDayAgo => 'hace un día';

  @override
  String daysAgo(Object days) {
    return 'hace $days días';
  }
}
