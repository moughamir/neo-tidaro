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
  String get greetHello => 'Hello';

  @override
  String greetHelloUser(String userName) {
    return 'Hello $userName';
  }

  @override
  String get greetWelcome => 'Welcome';

  @override
  String get greetWelcomeBack => 'Welcome back';

  @override
  String get greetGoodMorning => 'Good Morning';

  @override
  String get greetGoodAfternoon => 'Good Afternoon';

  @override
  String get greetGoodEvening => 'Good Evening';

  @override
  String get greetGoodbye => 'Goodbye';

  @override
  String get commonOk => 'OK';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get create => 'Create';

  @override
  String get update => 'Update';

  @override
  String get remove => 'Remove';

  @override
  String get close => 'Close';

  @override
  String get open => 'Open';

  @override
  String get submit => 'Submit';

  @override
  String get confirm => 'Confirm';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get retry => 'Retry';

  @override
  String get refresh => 'Refresh';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Previous';

  @override
  String get continueAction => 'Continue';

  @override
  String get skip => 'Skip';

  @override
  String get done => 'Done';

  @override
  String get finish => 'Finish';

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get about => 'About';

  @override
  String get help => 'Help';

  @override
  String get contact => 'Contact';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get notifications => 'Notifications';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get sort => 'Sort';

  @override
  String get themeSettings => 'Theme Settings';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get lightMode => 'Light Mode';

  @override
  String get systemMode => 'System Mode';

  @override
  String get privacy => 'Privacy';

  @override
  String get security => 'Security';

  @override
  String get account => 'Account';

  @override
  String get preferences => 'Preferences';

  @override
  String get login => 'Login';

  @override
  String get logout => 'Logout';

  @override
  String get register => 'Register';

  @override
  String get signUp => 'Sign Up';

  @override
  String get signIn => 'Sign In';

  @override
  String get forgotPassword => 'Forgot Password';

  @override
  String get resetPassword => 'Reset Password';

  @override
  String get changePassword => 'Change Password';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get username => 'Username';

  @override
  String get name => 'Name';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get phone => 'Phone';

  @override
  String get address => 'Address';

  @override
  String get city => 'City';

  @override
  String get country => 'Country';

  @override
  String get dateOfBirth => 'Date of Birth';

  @override
  String get loading => 'Loading...';

  @override
  String get saving => 'Saving...';

  @override
  String get processing => 'Processing...';

  @override
  String get uploading => 'Uploading...';

  @override
  String get downloading => 'Downloading...';

  @override
  String get connecting => 'Connecting...';

  @override
  String get syncing => 'Syncing...';

  @override
  String get success => 'Success';

  @override
  String get error => 'Error';

  @override
  String get warning => 'Warning';

  @override
  String get info => 'Information';

  @override
  String get noData => 'No data available';

  @override
  String get noResults => 'No results found';

  @override
  String get networkError => 'Network error';

  @override
  String get connectionError => 'Connection error';

  @override
  String get serverError => 'Server error';

  @override
  String get unknownError => 'Unknown error';

  @override
  String get tryAgain => 'Try again';

  @override
  String get required => 'Required';

  @override
  String get invalidPhoneNumber => 'Invalid phone number';

  @override
  String get fieldRequired => 'This field is required';

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

  @override
  String get aWeekAgo => 'a week ago';

  @override
  String weeksAgo(Object weeks) {
    return '$weeks weeks ago';
  }

  @override
  String get aMonthAgo => 'a month ago';

  @override
  String monthsAgo(Object months) {
    return '$months months ago';
  }

  @override
  String get aYearAgo => 'a year ago';

  @override
  String yearsAgo(Object years) {
    return '$years years ago';
  }

  @override
  String get today => 'Today';

  @override
  String get yesterday => 'Yesterday';

  @override
  String get tomorrow => 'Tomorrow';

  @override
  String get thisWeek => 'This week';

  @override
  String get lastWeek => 'Last week';

  @override
  String get nextWeek => 'Next week';

  @override
  String get thisMonth => 'This month';

  @override
  String get lastMonth => 'Last month';

  @override
  String get nextMonth => 'Next month';

  @override
  String get online => 'Online';

  @override
  String get offline => 'Offline';

  @override
  String get available => 'Available';

  @override
  String get busy => 'Busy';

  @override
  String get away => 'Away';

  @override
  String get version => 'Version';

  @override
  String get buildNumber => 'Build Number';

  @override
  String get copyright => 'Copyright';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get licenses => 'Licenses';

  @override
  String get apply => 'Apply';

  @override
  String get clear => 'Clear';

  @override
  String get customerInfo => 'Customer Information';

  @override
  String get createBooking => 'Create Booking';

  @override
  String get addStaff => 'Add Staff';

  @override
  String get staff => 'Staff';

  @override
  String get activityLog => 'Activity Log';

  @override
  String get searchActivities => 'Search activities...';

  @override
  String get noActivitiesFound => 'No Activities Found';

  @override
  String get noActivitiesFoundDescription =>
      'Try adjusting your search or filter criteria to find activities.';

  @override
  String get filterActivities => 'Filter Activities';

  @override
  String get allActivities => 'All Activities';

  @override
  String get bookingCreated => 'Booking Created';

  @override
  String get bookingConfirmed => 'Booking Confirmed';

  @override
  String get bookingCompleted => 'Booking Completed';

  @override
  String get bookingCancelled => 'Booking Cancelled';

  @override
  String get bookingRescheduled => 'Booking Rescheduled';

  @override
  String get professionalAssigned => 'Professional Assigned';

  @override
  String get professionalUnassigned => 'Professional Unassigned';

  @override
  String get paymentReceived => 'Payment Received';

  @override
  String get reviewSubmitted => 'Review Submitted';

  @override
  String get customerRegistered => 'Customer Registered';

  @override
  String get professionalRegistered => 'Professional Registered';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get userfullName => 'Full Name';

  @override
  String get userEmail => 'Email';

  @override
  String get userPhone => 'Phone';

  @override
  String get userJoined => 'Joined';

  @override
  String get share => 'Share';

  @override
  String get copy => 'Copy';

  @override
  String get paste => 'Paste';

  @override
  String get cut => 'Cut';

  @override
  String get selectAll => 'Select All';

  @override
  String get undo => 'Undo';

  @override
  String get redo => 'Redo';

  @override
  String get incrementAction => 'Increment';

  @override
  String get decrementAction => 'Decrement';

  @override
  String itemCount(Object count) {
    return '$count items';
  }

  @override
  String selectedCount(Object count) {
    return '$count selected';
  }

  @override
  String totalCount(Object count) {
    return 'Total: $count';
  }

  @override
  String get appBranding => 'TiDaro Admin';

  @override
  String get welcomeBackMessage => 'Welcome back! Please sign in to continue.';

  @override
  String get createAccount => 'Create an account';

  @override
  String get createAccountSubtitle =>
      'Enter your details below to create your account';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get passwordHint => 'Enter your password';

  @override
  String get nameHint => 'Enter your full name';

  @override
  String get createPasswordHint => 'Create a password';

  @override
  String get confirmPasswordHint => 'Confirm your password';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get forgotPasswordQuestion => 'Forgot password?';

  @override
  String get noAccountQuestion => 'Don\'t have an account?';

  @override
  String get haveAccountQuestion => 'Already have an account?';

  @override
  String get resetPasswordTitle => 'Reset Password';

  @override
  String get resetPasswordMessage =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get passwordResetEmailSent => 'Password reset email sent!';

  @override
  String get termsAgreement =>
      'By clicking continue, you agree to our Terms of Service and Privacy Policy.';

  @override
  String get passwordsDontMatch => 'Passwords don\'t match';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get passwordTooShort => 'Password must be at least 8 characters';

  @override
  String get bookings => 'Bookings';

  @override
  String get noBookings => 'No Bookings Found';

  @override
  String get noBookingsDescription =>
      'You haven\'t created any bookings yet. Create your first booking to get started.';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get viewDetails => 'View Details';

  @override
  String get noStaff => 'No Staff Found';

  @override
  String get noStaffDescription =>
      'You haven\'t added any staff members yet. Add your first staff member to get started.';

  @override
  String get totalBookings => 'Total Bookings';

  @override
  String get activeBookings => 'Active Bookings';

  @override
  String get monthlyRevenue => 'Monthly Revenue';

  @override
  String get activeProfessionals => 'Active Professionals';

  @override
  String get totalCustomers => 'Total Customers';

  @override
  String get totalRevenue => 'Total Revenue';

  @override
  String get makeAvailableButtonLabel => 'Make Available';

  @override
  String get makeUnavailableButtonLabel => 'Make Unavailable';

  @override
  String get staffFiltersAppliedSuccessfully =>
      'Staff filters applied successfully';

  @override
  String get staffFilterByServiceSpecialties => 'Filter by service specialties';

  @override
  String get professionalStatusAvailable => 'Available';

  @override
  String get professionalStatusOnJob => 'On Job';

  @override
  String get professionalStatusOffline => 'Offline';

  @override
  String get professionalStatusOnBreak => 'On Break';

  @override
  String get serviceCategoryRegularCleaning => 'Regular Cleaning';

  @override
  String get serviceCategoryDeepCleaning => 'Deep Cleaning';

  @override
  String get serviceCategoryMoveInOut => 'Move In/Out';

  @override
  String get serviceCategoryPostConstruction => 'Post Construction';

  @override
  String get serviceCategoryCommercial => 'Commercial';

  @override
  String get serviceCategoryStandardCleaning => 'Standard Cleaning';

  @override
  String get serviceCategoryResidential => 'Residential';

  @override
  String get staffFilterRatingRange => 'Rating Range';

  @override
  String get staffFilterRating => 'Rating';

  @override
  String get staffFilterStar => 'star';

  @override
  String get parallaxExampleTitle => 'Parallax Example';

  @override
  String get parallaxBackgroundText => 'Background';

  @override
  String get parallaxMiddleText => 'Middle';

  @override
  String get parallaxForegroundText => 'Foreground';

  @override
  String get parallaxMouseMode => 'Mouse Mode';

  @override
  String get parallaxGyroscopeMode => 'Gyroscope Mode';

  @override
  String get bookingStarted => 'Booking Started';

  @override
  String durationDays(int count) {
    return '$count day';
  }

  @override
  String durationDaysPlural(int count) {
    return '$count days';
  }

  @override
  String durationHours(int count) {
    return '$count hour';
  }

  @override
  String durationHoursPlural(int count) {
    return '$count hours';
  }

  @override
  String durationMinutes(int count) {
    return '$count minute';
  }

  @override
  String durationMinutesPlural(int count) {
    return '$count minutes';
  }

  @override
  String durationSeconds(int count) {
    return '$count second';
  }

  @override
  String durationSecondsPlural(int count) {
    return '$count seconds';
  }

  @override
  String get housekeeping => 'Housekeeping';

  @override
  String get cleaning => 'Cleaning';

  @override
  String get housekeeper => 'Housekeeper';

  @override
  String get cleaner => 'Cleaner';

  @override
  String get domesticWorker => 'Domestic Worker';

  @override
  String get roleClient => 'Client';

  @override
  String get roleProvider => 'Service Provider';

  @override
  String get roleAdmin => 'Administrator';

  @override
  String get roleModerator => 'Moderator';

  @override
  String get selectRole => 'Select Your Role';

  @override
  String get clientDescription => 'I need housekeeping services';

  @override
  String get providerDescription => 'I provide housekeeping services';

  @override
  String get regularCleaning => 'Regular Cleaning';

  @override
  String get deepCleaning => 'Deep Cleaning';

  @override
  String get oneTimeCleaning => 'One-time Cleaning';

  @override
  String get moveInOutCleaning => 'Move In/Out Cleaning';

  @override
  String get postConstructionCleaning => 'Post-Construction Cleaning';

  @override
  String get officeCleaning => 'Office Cleaning';

  @override
  String get laundryServices => 'Laundry Services';

  @override
  String get dishWashing => 'Dish Washing';

  @override
  String get windowCleaning => 'Window Cleaning';

  @override
  String get carpetCleaning => 'Carpet Cleaning';

  @override
  String get postJob => 'Post a Job';

  @override
  String get jobRequest => 'Job Request';

  @override
  String get jobDescription => 'Job Description';

  @override
  String get serviceNeeded => 'Service Needed';

  @override
  String get preferredDate => 'Preferred Date';

  @override
  String get preferredTime => 'Preferred Time';

  @override
  String get estimatedDuration => 'Estimated Duration';

  @override
  String get budget => 'Budget';

  @override
  String get budgetRange => 'Budget Range';

  @override
  String get propertySize => 'Property Size';

  @override
  String get numberOfRooms => 'Number of Rooms';

  @override
  String get numberOfBathrooms => 'Number of Bathrooms';

  @override
  String get specialInstructions => 'Special Instructions';

  @override
  String get placeBid => 'Place Bid';

  @override
  String get yourBid => 'Your Bid';

  @override
  String get bidAmount => 'Bid Amount';

  @override
  String get acceptBid => 'Accept Bid';

  @override
  String get rejectBid => 'Reject Bid';

  @override
  String get counterOffer => 'Counter Offer';

  @override
  String get bidsReceived => 'Bids Received';

  @override
  String get averageBid => 'Average Bid';

  @override
  String get lowestBid => 'Lowest Bid';

  @override
  String get highestBid => 'Highest Bid';

  @override
  String get bidMessage => 'Bid Message';

  @override
  String get negotiating => 'Negotiating';

  @override
  String get location => 'Location';

  @override
  String get serviceArea => 'Service Area';

  @override
  String get bouskoura => 'Bouskoura';

  @override
  String get casablanca => 'Casablanca';

  @override
  String get nearbyProviders => 'Nearby Providers';

  @override
  String kmAway(double distance) {
    return '$distance km away';
  }

  @override
  String get cashOnDelivery => 'Cash on Delivery';

  @override
  String get payInCash => 'Pay in Cash';

  @override
  String get paymentMethod => 'Payment Method';

  @override
  String get pricePerHour => 'Price per Hour';

  @override
  String get totalPrice => 'Total Price';

  @override
  String get moroccanDirham => 'Moroccan Dirham (MAD)';

  @override
  String get mad => 'MAD';

  @override
  String get providerProfile => 'Provider Profile';

  @override
  String get yearsOfExperience => 'Years of Experience';

  @override
  String get verified => 'Verified';

  @override
  String get unverified => 'Unverified';

  @override
  String get verificationPending => 'Verification Pending';

  @override
  String get idVerification => 'ID Verification';

  @override
  String get uploadId => 'Upload ID Document';

  @override
  String get cnie => 'CNIE (National ID)';

  @override
  String get passport => 'Passport';

  @override
  String get rating => 'Rating';

  @override
  String get reviews => 'Reviews';

  @override
  String get rateService => 'Rate this Service';

  @override
  String get writeReview => 'Write a Review';

  @override
  String get serviceRating => 'Service Rating';

  @override
  String get wouldRecommend => 'Would Recommend';

  @override
  String get excellent => 'Excellent';

  @override
  String get good => 'Good';

  @override
  String get average => 'Average';

  @override
  String get poor => 'Poor';

  @override
  String get selectUserRole => 'Select Your Role';

  @override
  String get selectUserRoleDescription => 'Choose how you plan to use Tidaro';

  @override
  String get roleClientConsumer => 'I Need Services';

  @override
  String get roleClientConsumerDescription =>
      'Book housekeeping services for your home';

  @override
  String get roleClientProfessional => 'I Provide Services';

  @override
  String get roleClientProfessionalDescription =>
      'Offer housekeeping services to customers';

  @override
  String get dashboardNavigationKyc => 'KYC';

  @override
  String get dashboardNavigationBookings => 'Bookings';

  @override
  String get dashboardNavigationUsers => 'Users';
}
