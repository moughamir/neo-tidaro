import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'intl_localizations_ar.dart';
import 'intl_localizations_en.dart';
import 'intl_localizations_es.dart';
import 'intl_localizations_fr.dart';
import 'intl_localizations_zgh.dart';

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
    Locale('es'),
    Locale('fr'),
    Locale('zgh')
  ];

  /// Application Title
  ///
  /// In en, this message translates to:
  /// **'TiDaro'**
  String get appTitle;

  /// A simple greeting
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// A greeting to the user.
  ///
  /// In en, this message translates to:
  /// **'Hello {userName}'**
  String helloUser(Object userName);

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// Welcome back message
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get welcomeBack;

  /// Farewell message
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get goodbye;

  /// OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Delete button
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Add button
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// Create button
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// Update button
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// Remove button
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// Close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Open button
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// Submit button
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// Confirm button
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Yes button
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No button
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Refresh button
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Back button
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Next button
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Previous button
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// Continue button
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueAction;

  /// Skip button
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// Done button
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Finish button
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// Home navigation
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Profile navigation
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Settings navigation
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// About navigation
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// Help navigation
  ///
  /// In en, this message translates to:
  /// **'Help'**
  String get help;

  /// Contact navigation
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contact;

  /// Dashboard navigation
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// Notifications navigation
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// Search functionality
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// Filter functionality
  ///
  /// In en, this message translates to:
  /// **'Filter'**
  String get filter;

  /// Sort functionality
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// Theme Settings
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// Language Settings
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// Dark mode setting
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Light mode setting
  ///
  /// In en, this message translates to:
  /// **'Light Mode'**
  String get lightMode;

  /// System mode setting
  ///
  /// In en, this message translates to:
  /// **'System Mode'**
  String get systemMode;

  /// Privacy settings
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// Security settings
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// Account settings
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// User preferences
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get preferences;

  /// Login action
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Logout action
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Register action
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// Sign up action
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Sign in action
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// Forgot password action
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPassword;

  /// Reset password action
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPassword;

  /// Change password action
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// Email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// Password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// Username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get username;

  /// Name field
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// First name field
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// Last name field
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// Phone field
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// Address field
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// City field
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get city;

  /// Country field
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// Date of birth field
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirth;

  /// Loading state
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Saving state
  ///
  /// In en, this message translates to:
  /// **'Saving...'**
  String get saving;

  /// Processing state
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// Uploading state
  ///
  /// In en, this message translates to:
  /// **'Uploading...'**
  String get uploading;

  /// Downloading state
  ///
  /// In en, this message translates to:
  /// **'Downloading...'**
  String get downloading;

  /// Connecting state
  ///
  /// In en, this message translates to:
  /// **'Connecting...'**
  String get connecting;

  /// Syncing state
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get syncing;

  /// Success message
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// Error message
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Warning message
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get warning;

  /// Information message
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get info;

  /// No data message
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No results message
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Network error'**
  String get networkError;

  /// Connection error message
  ///
  /// In en, this message translates to:
  /// **'Connection error'**
  String get connectionError;

  /// Server error message
  ///
  /// In en, this message translates to:
  /// **'Server error'**
  String get serverError;

  /// Unknown error message
  ///
  /// In en, this message translates to:
  /// **'Unknown error'**
  String get unknownError;

  /// Try again message
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get tryAgain;

  /// Required field indicator
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// Invalid phone number validation
  ///
  /// In en, this message translates to:
  /// **'Invalid phone number'**
  String get invalidPhoneNumber;

  /// Field required validation
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// No description provided for @fromNow.
  ///
  /// In en, this message translates to:
  /// **'{time} ago'**
  String fromNow(Object time);

  /// Used for something that just happened
  ///
  /// In en, this message translates to:
  /// **'just now'**
  String get justNow;

  /// One minute in the past
  ///
  /// In en, this message translates to:
  /// **'a minute ago'**
  String get aMinuteAgo;

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutesAgo(Object minutes);

  /// One hour in the past
  ///
  /// In en, this message translates to:
  /// **'an hour ago'**
  String get anHourAgo;

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String hoursAgo(Object hours);

  /// One day in the past
  ///
  /// In en, this message translates to:
  /// **'a day ago'**
  String get aDayAgo;

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(Object days);

  /// One week in the past
  ///
  /// In en, this message translates to:
  /// **'a week ago'**
  String get aWeekAgo;

  /// No description provided for @weeksAgo.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks ago'**
  String weeksAgo(Object weeks);

  /// One month in the past
  ///
  /// In en, this message translates to:
  /// **'a month ago'**
  String get aMonthAgo;

  /// No description provided for @monthsAgo.
  ///
  /// In en, this message translates to:
  /// **'{months} months ago'**
  String monthsAgo(Object months);

  /// One year in the past
  ///
  /// In en, this message translates to:
  /// **'a year ago'**
  String get aYearAgo;

  /// No description provided for @yearsAgo.
  ///
  /// In en, this message translates to:
  /// **'{years} years ago'**
  String yearsAgo(Object years);

  /// Today
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// Yesterday
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get yesterday;

  /// Tomorrow
  ///
  /// In en, this message translates to:
  /// **'Tomorrow'**
  String get tomorrow;

  /// This week
  ///
  /// In en, this message translates to:
  /// **'This week'**
  String get thisWeek;

  /// Last week
  ///
  /// In en, this message translates to:
  /// **'Last week'**
  String get lastWeek;

  /// Next week
  ///
  /// In en, this message translates to:
  /// **'Next week'**
  String get nextWeek;

  /// This month
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get thisMonth;

  /// Last month
  ///
  /// In en, this message translates to:
  /// **'Last month'**
  String get lastMonth;

  /// Next month
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get nextMonth;

  /// Online status
  ///
  /// In en, this message translates to:
  /// **'Online'**
  String get online;

  /// Offline status
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get offline;

  /// Available status
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// Busy status
  ///
  /// In en, this message translates to:
  /// **'Busy'**
  String get busy;

  /// Away status
  ///
  /// In en, this message translates to:
  /// **'Away'**
  String get away;

  /// Version label
  ///
  /// In en, this message translates to:
  /// **'Version'**
  String get version;

  /// Build number label
  ///
  /// In en, this message translates to:
  /// **'Build Number'**
  String get buildNumber;

  /// Copyright label
  ///
  /// In en, this message translates to:
  /// **'Copyright'**
  String get copyright;

  /// Terms of service
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Privacy policy
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Licenses
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// Share action
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// Copy action
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// Paste action
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// Cut action
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get cut;

  /// Select all action
  ///
  /// In en, this message translates to:
  /// **'Select All'**
  String get selectAll;

  /// Undo action
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get undo;

  /// Redo action
  ///
  /// In en, this message translates to:
  /// **'Redo'**
  String get redo;

  /// Increment action
  ///
  /// In en, this message translates to:
  /// **'Increment'**
  String get incrementAction;

  /// Decrement action
  ///
  /// In en, this message translates to:
  /// **'Decrement'**
  String get decrementAction;

  /// Item count
  ///
  /// In en, this message translates to:
  /// **'{count} items'**
  String itemCount(Object count);

  /// Selected count
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String selectedCount(Object count);

  /// Total count
  ///
  /// In en, this message translates to:
  /// **'Total: {count}'**
  String totalCount(Object count);

  /// Application branding name
  ///
  /// In en, this message translates to:
  /// **'TiDaro Admin'**
  String get appBranding;

  /// Welcome back message for login
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Please sign in to continue.'**
  String get welcomeBackMessage;

  /// Create account heading
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccount;

  /// Create account subtitle
  ///
  /// In en, this message translates to:
  /// **'Enter your details below to create your account'**
  String get createAccountSubtitle;

  /// Email input hint
  ///
  /// In en, this message translates to:
  /// **'name@example.com'**
  String get emailHint;

  /// Password input hint
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get passwordHint;

  /// Name input hint
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get nameHint;

  /// Create password input hint
  ///
  /// In en, this message translates to:
  /// **'Create a password'**
  String get createPasswordHint;

  /// Confirm password input hint
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmPasswordHint;

  /// Confirm password field label
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// Forgot password link text
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordQuestion;

  /// No account question text
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccountQuestion;

  /// Have account question text
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get haveAccountQuestion;

  /// Reset password dialog title
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordTitle;

  /// Reset password dialog message
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get resetPasswordMessage;

  /// Send reset link button
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// Password reset email sent message
  ///
  /// In en, this message translates to:
  /// **'Password reset email sent!'**
  String get passwordResetEmailSent;

  /// Terms agreement text
  ///
  /// In en, this message translates to:
  /// **'By clicking continue, you agree to our Terms of Service and Privacy Policy.'**
  String get termsAgreement;

  /// Passwords don't match validation message
  ///
  /// In en, this message translates to:
  /// **'Passwords don\'t match'**
  String get passwordsDontMatch;

  /// Invalid email validation message
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// Password too short validation message
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordTooShort;
}

class _IntlLocalizationsDelegate extends LocalizationsDelegate<IntlLocalizations> {
  const _IntlLocalizationsDelegate();

  @override
  Future<IntlLocalizations> load(Locale locale) {
    return SynchronousFuture<IntlLocalizations>(lookupIntlLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'es', 'fr', 'zgh'].contains(locale.languageCode);

  @override
  bool shouldReload(_IntlLocalizationsDelegate old) => false;
}

IntlLocalizations lookupIntlLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return IntlLocalizationsAr();
    case 'en': return IntlLocalizationsEn();
    case 'es': return IntlLocalizationsEs();
    case 'fr': return IntlLocalizationsFr();
    case 'zgh': return IntlLocalizationsZgh();
  }

  throw FlutterError(
    'IntlLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
