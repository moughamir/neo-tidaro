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
  String get ok => 'OK';

  @override
  String get hello => 'مرحبًا';

  @override
  String helloUser(Object userName) {
    return 'مرحبًا $userName';
  }

  @override
  String fromNow(Object time) {
    return 'منذ $time';
  }

  @override
  String get justNow => 'الآن';

  @override
  String get aMinuteAgo => 'منذ دقيقة';

  @override
  String minutesAgo(Object minutes) {
    return 'منذ $minutes دقائق';
  }

  @override
  String get anHourAgo => 'منذ ساعة';

  @override
  String hoursAgo(Object hours) {
    return 'منذ $hours ساعات';
  }

  @override
  String get aDayAgo => 'منذ يوم';

  @override
  String daysAgo(Object days) {
    return 'منذ $days أيام';
  }
}
