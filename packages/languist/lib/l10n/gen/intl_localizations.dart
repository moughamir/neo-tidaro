import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'intl_localizations_ar.dart';
import 'intl_localizations_en.dart';
import 'intl_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of IntlLocalizations
/// returned by `IntlLocalizations.of(context)`.
///
/// Applications need to include `IntlLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/intl_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: IntlLocalizations.localizationsDelegates,
///   supportedLocales: IntlLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the IntlLocalizations.supportedLocales
/// property.
abstract class IntlLocalizations {
  IntlLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static IntlLocalizations of(BuildContext context) {
    return Localizations.of<IntlLocalizations>(context, IntlLocalizations)!;
  }

  static const LocalizationsDelegate<IntlLocalizations> delegate = _IntlLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr')
  ];

  /// Application Title
  ///
  /// In en, this message translates to:
  /// **'TiDaro'**
  String get appTitle;

  /// Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @themeSettings.
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// A greeting to the user.
  ///
  /// In en, this message translates to:
  /// **'Hello {userName}'**
  String helloUser(Object userName);

  /// No description provided for @fromNow.
  ///
  /// In en, this message translates to:
  /// **'{time} ago'**
  String fromNow(Object time);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get justNow;

  /// No description provided for @aMinuteAgo.
  ///
  /// In en, this message translates to:
  /// **'a minute ago'**
  String get aMinuteAgo;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutesAgo(Object minutes);

  /// No description provided for @anHourAgo.
  ///
  /// In en, this message translates to:
  /// **'an hour ago'**
  String get anHourAgo;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String hoursAgo(Object hours);

  /// No description provided for @aDayAgo.
  ///
  /// In en, this message translates to:
  /// **'a day ago'**
  String get aDayAgo;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(Object days);
}

class _IntlLocalizationsDelegate extends LocalizationsDelegate<IntlLocalizations> {
  const _IntlLocalizationsDelegate();

  @override
  Future<IntlLocalizations> load(Locale locale) {
    return SynchronousFuture<IntlLocalizations>(lookupIntlLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_IntlLocalizationsDelegate old) => false;
}

IntlLocalizations lookupIntlLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return IntlLocalizationsAr();
    case 'en': return IntlLocalizationsEn();
    case 'fr': return IntlLocalizationsFr();
  }

  throw FlutterError(
    'IntlLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
