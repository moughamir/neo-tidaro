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
  String get hello => 'مرحبًا';

  @override
  String helloUser(Object userName) {
    return 'مرحبًا $userName';
  }

  @override
  String get welcome => 'أهلاً وسهلاً';

  @override
  String get welcomeBack => 'مرحبًا بعودتك';

  @override
  String get goodbye => 'وداعًا';

  @override
  String get ok => 'موافق';

  @override
  String get cancel => 'إلغاء';

  @override
  String get save => 'حفظ';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get add => 'إضافة';

  @override
  String get create => 'إنشاء';

  @override
  String get update => 'تحديث';

  @override
  String get remove => 'إزالة';

  @override
  String get close => 'إغلاق';

  @override
  String get open => 'فتح';

  @override
  String get submit => 'إرسال';

  @override
  String get confirm => 'تأكيد';

  @override
  String get yes => 'نعم';

  @override
  String get no => 'لا';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get refresh => 'تحديث';

  @override
  String get back => 'رجوع';

  @override
  String get next => 'التالي';

  @override
  String get previous => 'السابق';

  @override
  String get continueAction => 'متابعة';

  @override
  String get skip => 'تخطي';

  @override
  String get done => 'تم';

  @override
  String get finish => 'إنهاء';

  @override
  String get home => 'الرئيسية';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'إعدادات';

  @override
  String get about => 'حول';

  @override
  String get help => 'مساعدة';

  @override
  String get contact => 'اتصال';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get search => 'بحث';

  @override
  String get filter => 'تصفية';

  @override
  String get sort => 'ترتيب';

  @override
  String get themeSettings => 'إعدادات السمة';

  @override
  String get languageSettings => 'إعدادات اللغة';

  @override
  String get darkMode => 'الوضع المظلم';

  @override
  String get lightMode => 'الوضع المضيء';

  @override
  String get systemMode => 'وضع النظام';

  @override
  String get privacy => 'الخصوصية';

  @override
  String get security => 'الأمان';

  @override
  String get account => 'الحساب';

  @override
  String get preferences => 'التفضيلات';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get register => 'تسجيل';

  @override
  String get signUp => 'إنشاء حساب';

  @override
  String get signIn => 'تسجيل الدخول';

  @override
  String get forgotPassword => 'نسيت كلمة المرور';

  @override
  String get resetPassword => 'إعادة تعيين كلمة المرور';

  @override
  String get changePassword => 'تغيير كلمة المرور';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get password => 'كلمة المرور';

  @override
  String get username => 'اسم المستخدم';

  @override
  String get name => 'الاسم';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اسم العائلة';

  @override
  String get phone => 'الهاتف';

  @override
  String get address => 'العنوان';

  @override
  String get city => 'المدينة';

  @override
  String get country => 'البلد';

  @override
  String get dateOfBirth => 'تاريخ الميلاد';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get saving => 'جاري الحفظ...';

  @override
  String get processing => 'جاري المعالجة...';

  @override
  String get uploading => 'جاري الرفع...';

  @override
  String get downloading => 'جاري التحميل...';

  @override
  String get connecting => 'جاري الاتصال...';

  @override
  String get syncing => 'جاري المزامنة...';

  @override
  String get success => 'نجح';

  @override
  String get error => 'خطأ';

  @override
  String get warning => 'تحذير';

  @override
  String get info => 'معلومات';

  @override
  String get noData => 'لا توجد بيانات متاحة';

  @override
  String get noResults => 'لم يتم العثور على نتائج';

  @override
  String get networkError => 'خطأ في الشبكة';

  @override
  String get connectionError => 'خطأ في الاتصال';

  @override
  String get serverError => 'خطأ في الخادم';

  @override
  String get unknownError => 'خطأ غير معروف';

  @override
  String get tryAgain => 'حاول مرة أخرى';

  @override
  String get required => 'مطلوب';

  @override
  String get invalidPhoneNumber => 'رقم هاتف غير صحيح';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

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

  @override
  String get aWeekAgo => 'منذ أسبوع';

  @override
  String weeksAgo(Object weeks) {
    return 'منذ $weeks أسابيع';
  }

  @override
  String get aMonthAgo => 'منذ شهر';

  @override
  String monthsAgo(Object months) {
    return 'منذ $months أشهر';
  }

  @override
  String get aYearAgo => 'منذ سنة';

  @override
  String yearsAgo(Object years) {
    return 'منذ $years سنوات';
  }

  @override
  String get today => 'اليوم';

  @override
  String get yesterday => 'أمس';

  @override
  String get tomorrow => 'غداً';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get lastWeek => 'الأسبوع الماضي';

  @override
  String get nextWeek => 'الأسبوع القادم';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get lastMonth => 'الشهر الماضي';

  @override
  String get nextMonth => 'الشهر القادم';

  @override
  String get online => 'متصل';

  @override
  String get offline => 'غير متصل';

  @override
  String get available => 'متاح';

  @override
  String get busy => 'مشغول';

  @override
  String get away => 'غائب';

  @override
  String get version => 'الإصدار';

  @override
  String get buildNumber => 'رقم البناء';

  @override
  String get copyright => 'حقوق الطبع والنشر';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get licenses => 'التراخيص';

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
  String get noActivitiesFoundDescription => 'Try adjusting your search or filter criteria to find activities.';

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
  String get cleanerAssigned => 'Cleaner Assigned';

  @override
  String get cleanerUnassigned => 'Cleaner Unassigned';

  @override
  String get paymentReceived => 'Payment Received';

  @override
  String get reviewSubmitted => 'Review Submitted';

  @override
  String get customerRegistered => 'Customer Registered';

  @override
  String get cleanerRegistered => 'Cleaner Registered';

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
  String get share => 'مشاركة';

  @override
  String get copy => 'نسخ';

  @override
  String get paste => 'لصق';

  @override
  String get cut => 'قص';

  @override
  String get selectAll => 'تحديد الكل';

  @override
  String get undo => 'تراجع';

  @override
  String get redo => 'إعادة';

  @override
  String get incrementAction => 'Increment';

  @override
  String get decrementAction => 'Decrement';

  @override
  String itemCount(Object count) {
    return '$count عناصر';
  }

  @override
  String selectedCount(Object count) {
    return '$count محدد';
  }

  @override
  String totalCount(Object count) {
    return 'الإجمالي: $count';
  }

  @override
  String get appBranding => 'إدارة تيدارو';

  @override
  String get welcomeBackMessage => 'مرحباً بعودتك! يرجى تسجيل الدخول للمتابعة.';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get createAccountSubtitle => 'أدخل تفاصيلك أدناه لإنشاء حسابك';

  @override
  String get emailHint => 'name@example.com';

  @override
  String get passwordHint => 'أدخل كلمة المرور';

  @override
  String get nameHint => 'أدخل اسمك الكامل';

  @override
  String get createPasswordHint => 'إنشاء كلمة مرور';

  @override
  String get confirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get confirmPasswordLabel => 'تأكيد كلمة المرور';

  @override
  String get forgotPasswordQuestion => 'نسيت كلمة المرور؟';

  @override
  String get noAccountQuestion => 'ليس لديك حساب؟';

  @override
  String get haveAccountQuestion => 'لديك حساب بالفعل؟';

  @override
  String get resetPasswordTitle => 'إعادة تعيين كلمة المرور';

  @override
  String get resetPasswordMessage => 'أدخل عنوان بريدك الإلكتروني وسنرسل لك رابطاً لإعادة تعيين كلمة المرور.';

  @override
  String get sendResetLink => 'إرسال رابط الإعادة';

  @override
  String get passwordResetEmailSent => 'تم إرسال بريد إعادة تعيين كلمة المرور!';

  @override
  String get termsAgreement => 'بالنقر على متابعة، فإنك توافق على شروط الخدمة وسياسة الخصوصية الخاصة بنا.';

  @override
  String get passwordsDontMatch => 'كلمات المرور غير متطابقة';

  @override
  String get invalidEmail => 'يرجى إدخال عنوان بريد إلكتروني صحيح';

  @override
  String get passwordTooShort => 'يجب أن تكون كلمة المرور 8 أحرف على الأقل';

  @override
  String get bookings => 'Bookings';

  @override
  String get noBookings => 'No Bookings Found';

  @override
  String get noBookingsDescription => 'You haven\'t created any bookings yet. Create your first booking to get started.';

  @override
  String get comingSoon => 'Coming Soon';

  @override
  String get viewDetails => 'View Details';

  @override
  String get noStaff => 'No Staff Found';

  @override
  String get noStaffDescription => 'You haven\'t added any staff members yet. Add your first staff member to get started.';

  @override
  String get totalBookings => 'Total Bookings';

  @override
  String get activeBookings => 'Active Bookings';

  @override
  String get monthlyRevenue => 'Monthly Revenue';

  @override
  String get activeCleaners => 'Active Cleaners';

  @override
  String get totalCustomers => 'Total Customers';

  @override
  String get totalRevenue => 'Total Revenue';
}
