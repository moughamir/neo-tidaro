// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'intl_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class IntlLocalizationsAr extends IntlLocalizations {
  IntlLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'تيدارو';

  @override
  String get settings => 'إعدادات';

  @override
  String get themeSettings => 'إعدادات السمة';

  @override
  String get languageSettings => 'إعدادات اللغة';

  @override
  String get hello => 'مرحبًا';

  @override
  String helloUser(Object userName) {
    return 'Hello $userName';
  }

  @override
  String fromNow(Object time) {
    return 'من الآن';
  }

  @override
  String get justNow => 'الآن';

  @override
  String get aMinuteAgo => 'منذ دقيقة';

  @override
  String minutesAgo(Object minutes) {
    return 'منذ دقائق';
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
