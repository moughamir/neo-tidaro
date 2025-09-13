import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'gen_localizations_ar.dart';
import 'gen_localizations_en.dart';
import 'gen_localizations_es.dart';
import 'gen_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of GenLocalizations
/// returned by `GenLocalizations.of(context)`.
///
/// Applications need to include `GenLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/gen_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: GenLocalizations.localizationsDelegates,
///   supportedLocales: GenLocalizations.supportedLocales,
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
/// be consistent with the languages listed in the GenLocalizations.supportedLocales
/// property.
abstract class GenLocalizations {
  GenLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static GenLocalizations? of(BuildContext context) {
    return Localizations.of<GenLocalizations>(context, GenLocalizations);
  }

  static const LocalizationsDelegate<GenLocalizations> delegate =
      _GenLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
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
  String get greetHello;

  /// A greeting to the user.
  ///
  /// In en, this message translates to:
  /// **'Hello {userName}'**
  String greetHelloUser(String userName);

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get greetWelcome;

  /// Welcome back message
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get greetWelcomeBack;

  /// Good Morning
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get greetGoodMorning;

  /// Good Afternoon
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get greetGoodAfternoon;

  /// Good Evening
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get greetGoodEvening;

  /// Farewell message
  ///
  /// In en, this message translates to:
  /// **'Goodbye'**
  String get greetGoodbye;

  /// OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

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

  /// Build number system metadata
  ///
  /// In en, this message translates to:
  /// **'Build Number'**
  String get buildNumber;

  /// Copyright system metadata
  ///
  /// In en, this message translates to:
  /// **'Copyright'**
  String get copyright;

  /// Terms of service system metadata
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// Privacy policy system metadata
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// Licenses system metadata
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licenses;

  /// Apply action button
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get apply;

  /// Clear action button
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// Customer information section header
  ///
  /// In en, this message translates to:
  /// **'Customer Information'**
  String get customerInfo;

  /// Create booking action
  ///
  /// In en, this message translates to:
  /// **'Create Booking'**
  String get createBooking;

  /// Add staff member action
  ///
  /// In en, this message translates to:
  /// **'Add Staff'**
  String get addStaff;

  /// Staff navigation and page title
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get staff;

  /// Activity log page title
  ///
  /// In en, this message translates to:
  /// **'Activity Log'**
  String get activityLog;

  /// Search placeholder for activity log
  ///
  /// In en, this message translates to:
  /// **'Search activities...'**
  String get searchActivities;

  /// Empty state title for activity log
  ///
  /// In en, this message translates to:
  /// **'No Activities Found'**
  String get noActivitiesFound;

  /// Empty state description for activity log
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your search or filter criteria to find activities.'**
  String get noActivitiesFoundDescription;

  /// Filter dialog title for activities
  ///
  /// In en, this message translates to:
  /// **'Filter Activities'**
  String get filterActivities;

  /// Show all activities filter option
  ///
  /// In en, this message translates to:
  /// **'All Activities'**
  String get allActivities;

  /// Booking created activity type
  ///
  /// In en, this message translates to:
  /// **'Booking Created'**
  String get bookingCreated;

  /// Booking confirmed activity type
  ///
  /// In en, this message translates to:
  /// **'Booking Confirmed'**
  String get bookingConfirmed;

  /// Booking completed activity type
  ///
  /// In en, this message translates to:
  /// **'Booking Completed'**
  String get bookingCompleted;

  /// Booking cancelled activity type
  ///
  /// In en, this message translates to:
  /// **'Booking Cancelled'**
  String get bookingCancelled;

  /// Booking rescheduled activity type
  ///
  /// In en, this message translates to:
  /// **'Booking Rescheduled'**
  String get bookingRescheduled;

  /// Professional assigned activity type
  ///
  /// In en, this message translates to:
  /// **'Professional Assigned'**
  String get professionalAssigned;

  /// Professional unassigned activity type
  ///
  /// In en, this message translates to:
  /// **'Professional Unassigned'**
  String get professionalUnassigned;

  /// Payment received activity type
  ///
  /// In en, this message translates to:
  /// **'Payment Received'**
  String get paymentReceived;

  /// Review submitted activity type
  ///
  /// In en, this message translates to:
  /// **'Review Submitted'**
  String get reviewSubmitted;

  /// Customer registered activity type
  ///
  /// In en, this message translates to:
  /// **'Customer Registered'**
  String get customerRegistered;

  /// Professional registered activity type
  ///
  /// In en, this message translates to:
  /// **'Professional Registered'**
  String get professionalRegistered;

  /// Personal information section header
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// User full name field
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get userfullName;

  /// User email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get userEmail;

  /// User phone field
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get userPhone;

  /// User joined date field
  ///
  /// In en, this message translates to:
  /// **'Joined'**
  String get userJoined;

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

  /// Bookings navigation and page title
  ///
  /// In en, this message translates to:
  /// **'Bookings'**
  String get bookings;

  /// Empty state title for bookings list
  ///
  /// In en, this message translates to:
  /// **'No Bookings Found'**
  String get noBookings;

  /// Empty state description for bookings list
  ///
  /// In en, this message translates to:
  /// **'You haven\'t created any bookings yet. Create your first booking to get started.'**
  String get noBookingsDescription;

  /// Placeholder text for features not yet implemented
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// Button text to view item details
  ///
  /// In en, this message translates to:
  /// **'View Details'**
  String get viewDetails;

  /// Empty state title for staff list
  ///
  /// In en, this message translates to:
  /// **'No Staff Found'**
  String get noStaff;

  /// Empty state description for staff list
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any staff members yet. Add your first staff member to get started.'**
  String get noStaffDescription;

  /// Total bookings metric title
  ///
  /// In en, this message translates to:
  /// **'Total Bookings'**
  String get totalBookings;

  /// Active bookings metric title
  ///
  /// In en, this message translates to:
  /// **'Active Bookings'**
  String get activeBookings;

  /// Monthly revenue metric title
  ///
  /// In en, this message translates to:
  /// **'Monthly Revenue'**
  String get monthlyRevenue;

  /// Active professionals metric title
  ///
  /// In en, this message translates to:
  /// **'Active Professionals'**
  String get activeProfessionals;

  /// Total customers metric title
  ///
  /// In en, this message translates to:
  /// **'Total Customers'**
  String get totalCustomers;

  /// Total revenue metric title
  ///
  /// In en, this message translates to:
  /// **'Total Revenue'**
  String get totalRevenue;

  /// Make available button label
  ///
  /// In en, this message translates to:
  /// **'Make Available'**
  String get makeAvailableButtonLabel;

  /// Make unavailable button label
  ///
  /// In en, this message translates to:
  /// **'Make Unavailable'**
  String get makeUnavailableButtonLabel;

  /// Staff filters applied successfully message
  ///
  /// In en, this message translates to:
  /// **'Staff filters applied successfully'**
  String get staffFiltersAppliedSuccessfully;

  /// Filter by service specialties label
  ///
  /// In en, this message translates to:
  /// **'Filter by service specialties'**
  String get staffFilterByServiceSpecialties;

  /// Available status
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get professionalStatusAvailable;

  /// On job status
  ///
  /// In en, this message translates to:
  /// **'On Job'**
  String get professionalStatusOnJob;

  /// Offline status
  ///
  /// In en, this message translates to:
  /// **'Offline'**
  String get professionalStatusOffline;

  /// On break status
  ///
  /// In en, this message translates to:
  /// **'On Break'**
  String get professionalStatusOnBreak;

  /// Regular cleaning service category
  ///
  /// In en, this message translates to:
  /// **'Regular Cleaning'**
  String get serviceCategoryRegularCleaning;

  /// Deep cleaning service category
  ///
  /// In en, this message translates to:
  /// **'Deep Cleaning'**
  String get serviceCategoryDeepCleaning;

  /// Move in/out service category
  ///
  /// In en, this message translates to:
  /// **'Move In/Out'**
  String get serviceCategoryMoveInOut;

  /// Post construction service category
  ///
  /// In en, this message translates to:
  /// **'Post Construction'**
  String get serviceCategoryPostConstruction;

  /// Commercial service category
  ///
  /// In en, this message translates to:
  /// **'Commercial'**
  String get serviceCategoryCommercial;

  /// Standard cleaning service category
  ///
  /// In en, this message translates to:
  /// **'Standard Cleaning'**
  String get serviceCategoryStandardCleaning;

  /// Residential service category
  ///
  /// In en, this message translates to:
  /// **'Residential'**
  String get serviceCategoryResidential;

  /// Rating range filter label
  ///
  /// In en, this message translates to:
  /// **'Rating Range'**
  String get staffFilterRatingRange;

  /// Rating filter label
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get staffFilterRating;

  /// Star unit for rating filter
  ///
  /// In en, this message translates to:
  /// **'star'**
  String get staffFilterStar;

  /// Title for parallax example page
  ///
  /// In en, this message translates to:
  /// **'Parallax Example'**
  String get parallaxExampleTitle;

  /// Background text for parallax example
  ///
  /// In en, this message translates to:
  /// **'Background'**
  String get parallaxBackgroundText;

  /// Middle text for parallax example
  ///
  /// In en, this message translates to:
  /// **'Middle'**
  String get parallaxMiddleText;

  /// Foreground text for parallax example
  ///
  /// In en, this message translates to:
  /// **'Foreground'**
  String get parallaxForegroundText;

  /// Indicates parallax is controlled by mouse movement
  ///
  /// In en, this message translates to:
  /// **'Mouse Mode'**
  String get parallaxMouseMode;

  /// Indicates parallax is controlled by device gyroscope
  ///
  /// In en, this message translates to:
  /// **'Gyroscope Mode'**
  String get parallaxGyroscopeMode;

  /// Booking started activity type
  ///
  /// In en, this message translates to:
  /// **'Booking Started'**
  String get bookingStarted;

  /// Duration in days (singular)
  ///
  /// In en, this message translates to:
  /// **'{count} day'**
  String durationDays(int count);

  /// Duration in days (plural)
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String durationDaysPlural(int count);

  /// Duration in hours (singular)
  ///
  /// In en, this message translates to:
  /// **'{count} hour'**
  String durationHours(int count);

  /// Duration in hours (plural)
  ///
  /// In en, this message translates to:
  /// **'{count} hours'**
  String durationHoursPlural(int count);

  /// Duration in minutes (singular)
  ///
  /// In en, this message translates to:
  /// **'{count} minute'**
  String durationMinutes(int count);

  /// Duration in minutes (plural)
  ///
  /// In en, this message translates to:
  /// **'{count} minutes'**
  String durationMinutesPlural(int count);

  /// Duration in seconds (singular)
  ///
  /// In en, this message translates to:
  /// **'{count} second'**
  String durationSeconds(int count);

  /// Duration in seconds (plural)
  ///
  /// In en, this message translates to:
  /// **'{count} seconds'**
  String durationSecondsPlural(int count);

  /// General housekeeping term
  ///
  /// In en, this message translates to:
  /// **'Housekeeping'**
  String get housekeeping;

  /// General cleaning term
  ///
  /// In en, this message translates to:
  /// **'Cleaning'**
  String get cleaning;

  /// Person who provides housekeeping services
  ///
  /// In en, this message translates to:
  /// **'Housekeeper'**
  String get housekeeper;

  /// Person who provides cleaning services
  ///
  /// In en, this message translates to:
  /// **'Cleaner'**
  String get cleaner;

  /// General term for domestic service provider
  ///
  /// In en, this message translates to:
  /// **'Domestic Worker'**
  String get domesticWorker;

  /// Client role - person who books services
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get roleClient;

  /// Provider role - person who offers services
  ///
  /// In en, this message translates to:
  /// **'Service Provider'**
  String get roleProvider;

  /// Admin role - platform administrator
  ///
  /// In en, this message translates to:
  /// **'Administrator'**
  String get roleAdmin;

  /// Moderator role - content moderator
  ///
  /// In en, this message translates to:
  /// **'Moderator'**
  String get roleModerator;

  /// Role selection prompt
  ///
  /// In en, this message translates to:
  /// **'Select Your Role'**
  String get selectRole;

  /// Description for client role
  ///
  /// In en, this message translates to:
  /// **'I need housekeeping services'**
  String get clientDescription;

  /// Description for provider role
  ///
  /// In en, this message translates to:
  /// **'I provide housekeeping services'**
  String get providerDescription;

  /// Regular weekly/monthly cleaning service
  ///
  /// In en, this message translates to:
  /// **'Regular Cleaning'**
  String get regularCleaning;

  /// Thorough deep cleaning service
  ///
  /// In en, this message translates to:
  /// **'Deep Cleaning'**
  String get deepCleaning;

  /// Single cleaning session
  ///
  /// In en, this message translates to:
  /// **'One-time Cleaning'**
  String get oneTimeCleaning;

  /// Cleaning for moving in or out
  ///
  /// In en, this message translates to:
  /// **'Move In/Out Cleaning'**
  String get moveInOutCleaning;

  /// Cleaning after construction work
  ///
  /// In en, this message translates to:
  /// **'Post-Construction Cleaning'**
  String get postConstructionCleaning;

  /// Commercial office cleaning
  ///
  /// In en, this message translates to:
  /// **'Office Cleaning'**
  String get officeCleaning;

  /// Washing and ironing services
  ///
  /// In en, this message translates to:
  /// **'Laundry Services'**
  String get laundryServices;

  /// Kitchen cleaning and dish washing
  ///
  /// In en, this message translates to:
  /// **'Dish Washing'**
  String get dishWashing;

  /// Window and glass cleaning
  ///
  /// In en, this message translates to:
  /// **'Window Cleaning'**
  String get windowCleaning;

  /// Carpet and upholstery cleaning
  ///
  /// In en, this message translates to:
  /// **'Carpet Cleaning'**
  String get carpetCleaning;

  /// Action to create a new job posting
  ///
  /// In en, this message translates to:
  /// **'Post a Job'**
  String get postJob;

  /// A request for housekeeping services
  ///
  /// In en, this message translates to:
  /// **'Job Request'**
  String get jobRequest;

  /// Description of the work needed
  ///
  /// In en, this message translates to:
  /// **'Job Description'**
  String get jobDescription;

  /// Type of service required
  ///
  /// In en, this message translates to:
  /// **'Service Needed'**
  String get serviceNeeded;

  /// Client's preferred date for service
  ///
  /// In en, this message translates to:
  /// **'Preferred Date'**
  String get preferredDate;

  /// Client's preferred time for service
  ///
  /// In en, this message translates to:
  /// **'Preferred Time'**
  String get preferredTime;

  /// How long the job is expected to take
  ///
  /// In en, this message translates to:
  /// **'Estimated Duration'**
  String get estimatedDuration;

  /// Client's budget for the service
  ///
  /// In en, this message translates to:
  /// **'Budget'**
  String get budget;

  /// Range of acceptable prices
  ///
  /// In en, this message translates to:
  /// **'Budget Range'**
  String get budgetRange;

  /// Size of property to be cleaned
  ///
  /// In en, this message translates to:
  /// **'Property Size'**
  String get propertySize;

  /// How many rooms need cleaning
  ///
  /// In en, this message translates to:
  /// **'Number of Rooms'**
  String get numberOfRooms;

  /// How many bathrooms need cleaning
  ///
  /// In en, this message translates to:
  /// **'Number of Bathrooms'**
  String get numberOfBathrooms;

  /// Additional notes or requirements
  ///
  /// In en, this message translates to:
  /// **'Special Instructions'**
  String get specialInstructions;

  /// Action to submit a bid for a job
  ///
  /// In en, this message translates to:
  /// **'Place Bid'**
  String get placeBid;

  /// Provider's bid amount
  ///
  /// In en, this message translates to:
  /// **'Your Bid'**
  String get yourBid;

  /// Amount being offered for the job
  ///
  /// In en, this message translates to:
  /// **'Bid Amount'**
  String get bidAmount;

  /// Action to accept a provider's bid
  ///
  /// In en, this message translates to:
  /// **'Accept Bid'**
  String get acceptBid;

  /// Action to reject a provider's bid
  ///
  /// In en, this message translates to:
  /// **'Reject Bid'**
  String get rejectBid;

  /// Make a counter-offer to a bid
  ///
  /// In en, this message translates to:
  /// **'Counter Offer'**
  String get counterOffer;

  /// Number of bids received for a job
  ///
  /// In en, this message translates to:
  /// **'Bids Received'**
  String get bidsReceived;

  /// Average of all bids received
  ///
  /// In en, this message translates to:
  /// **'Average Bid'**
  String get averageBid;

  /// Lowest bid received
  ///
  /// In en, this message translates to:
  /// **'Lowest Bid'**
  String get lowestBid;

  /// Highest bid received
  ///
  /// In en, this message translates to:
  /// **'Highest Bid'**
  String get highestBid;

  /// Optional message with a bid
  ///
  /// In en, this message translates to:
  /// **'Bid Message'**
  String get bidMessage;

  /// Status when client and provider are negotiating
  ///
  /// In en, this message translates to:
  /// **'Negotiating'**
  String get negotiating;

  /// Service location
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Area where provider offers services
  ///
  /// In en, this message translates to:
  /// **'Service Area'**
  String get serviceArea;

  /// Bouskoura area in Morocco
  ///
  /// In en, this message translates to:
  /// **'Bouskoura'**
  String get bouskoura;

  /// Casablanca city in Morocco
  ///
  /// In en, this message translates to:
  /// **'Casablanca'**
  String get casablanca;

  /// Service providers in the area
  ///
  /// In en, this message translates to:
  /// **'Nearby Providers'**
  String get nearbyProviders;

  /// Distance in kilometers
  ///
  /// In en, this message translates to:
  /// **'{distance} km away'**
  String kmAway(double distance);

  /// Payment method - cash after service
  ///
  /// In en, this message translates to:
  /// **'Cash on Delivery'**
  String get cashOnDelivery;

  /// Cash payment option
  ///
  /// In en, this message translates to:
  /// **'Pay in Cash'**
  String get payInCash;

  /// How payment will be made
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethod;

  /// Hourly rate for service
  ///
  /// In en, this message translates to:
  /// **'Price per Hour'**
  String get pricePerHour;

  /// Total cost for the service
  ///
  /// In en, this message translates to:
  /// **'Total Price'**
  String get totalPrice;

  /// Morocco currency
  ///
  /// In en, this message translates to:
  /// **'Moroccan Dirham (MAD)'**
  String get moroccanDirham;

  /// Morocco currency abbreviation
  ///
  /// In en, this message translates to:
  /// **'MAD'**
  String get mad;

  /// Service provider's profile
  ///
  /// In en, this message translates to:
  /// **'Provider Profile'**
  String get providerProfile;

  /// How many years of experience
  ///
  /// In en, this message translates to:
  /// **'Years of Experience'**
  String get yearsOfExperience;

  /// Account or profile is verified
  ///
  /// In en, this message translates to:
  /// **'Verified'**
  String get verified;

  /// Account or profile is not verified
  ///
  /// In en, this message translates to:
  /// **'Unverified'**
  String get unverified;

  /// Verification is in progress
  ///
  /// In en, this message translates to:
  /// **'Verification Pending'**
  String get verificationPending;

  /// Identity document verification
  ///
  /// In en, this message translates to:
  /// **'ID Verification'**
  String get idVerification;

  /// Action to upload identification
  ///
  /// In en, this message translates to:
  /// **'Upload ID Document'**
  String get uploadId;

  /// Morocco national ID card
  ///
  /// In en, this message translates to:
  /// **'CNIE (National ID)'**
  String get cnie;

  /// Passport document
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get passport;

  /// Service rating
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get rating;

  /// Service reviews
  ///
  /// In en, this message translates to:
  /// **'Reviews'**
  String get reviews;

  /// Action to rate a completed service
  ///
  /// In en, this message translates to:
  /// **'Rate this Service'**
  String get rateService;

  /// Action to write a service review
  ///
  /// In en, this message translates to:
  /// **'Write a Review'**
  String get writeReview;

  /// Rating for the service quality
  ///
  /// In en, this message translates to:
  /// **'Service Rating'**
  String get serviceRating;

  /// Would recommend this provider
  ///
  /// In en, this message translates to:
  /// **'Would Recommend'**
  String get wouldRecommend;

  /// Excellent rating
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get excellent;

  /// Good rating
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get good;

  /// Average rating
  ///
  /// In en, this message translates to:
  /// **'Average'**
  String get average;

  /// Poor rating
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get poor;

  /// Header for role selection during registration
  ///
  /// In en, this message translates to:
  /// **'Select Your Role'**
  String get selectUserRole;

  /// Description for role selection
  ///
  /// In en, this message translates to:
  /// **'Choose how you plan to use Tidaro'**
  String get selectUserRoleDescription;

  /// Role for customers who book services
  ///
  /// In en, this message translates to:
  /// **'I Need Services'**
  String get roleClientConsumer;

  /// Description for client consumer role
  ///
  /// In en, this message translates to:
  /// **'Book housekeeping services for your home'**
  String get roleClientConsumerDescription;

  /// Role for service providers
  ///
  /// In en, this message translates to:
  /// **'I Provide Services'**
  String get roleClientProfessional;

  /// Description for client professional role
  ///
  /// In en, this message translates to:
  /// **'Offer housekeeping services to customers'**
  String get roleClientProfessionalDescription;
}

class _GenLocalizationsDelegate
    extends LocalizationsDelegate<GenLocalizations> {
  const _GenLocalizationsDelegate();

  @override
  Future<GenLocalizations> load(Locale locale) {
    return SynchronousFuture<GenLocalizations>(lookupGenLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'es', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_GenLocalizationsDelegate old) => false;
}

GenLocalizations lookupGenLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return GenLocalizationsAr();
    case 'en':
      return GenLocalizationsEn();
    case 'es':
      return GenLocalizationsEs();
    case 'fr':
      return GenLocalizationsFr();
  }

  throw FlutterError(
    'GenLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
