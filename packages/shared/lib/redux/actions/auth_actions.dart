import 'package:fpdart/fpdart.dart';
import 'package:shared/redux/redux.dart';

/// Authentication action types
class AuthActionTypes {
  static const String signIn = 'AUTH_SIGN_IN';
  static const String signUp = 'AUTH_SIGN_UP';
  static const String signOut = 'AUTH_SIGN_OUT';
  static const String resetPassword = 'AUTH_RESET_PASSWORD';
  static const String checkAuthStatus = 'AUTH_CHECK_STATUS';
  static const String clearError = 'AUTH_CLEAR_ERROR';
  static const String socialSignIn = 'AUTH_SOCIAL_SIGN_IN';
  static const String phoneSignIn = 'AUTH_PHONE_SIGN_IN';
}

/// Sign in action
class SignInAction extends BaseAsyncAction<AuthUser> {
  const SignInAction({required this.email, required this.password});

  final String email;
  final String password;

  @override
  String get type => AuthActionTypes.signIn;

  @override
  Map<String, String> get payload => {'email': email, 'password': password};

  @override
  Future<Either<Exception, AuthUser>> execute() async {
    // Implementation will be handled by middleware
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [email, password];
}

/// Sign up action
class SignUpAction extends BaseAsyncAction<AuthUser> {
  const SignUpAction({
    required this.email,
    required this.password,
    required this.confirmPassword,
    this.userMetadata,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final Map<String, dynamic>? userMetadata;

  @override
  String get type => AuthActionTypes.signUp;

  @override
  Map<String, dynamic> get payload => {
    'email': email,
    'password': password,
    'confirmPassword': confirmPassword,
    if (userMetadata != null) 'metadata': userMetadata!,
  };

  @override
  Future<Either<Exception, AuthUser>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [email, password, confirmPassword, userMetadata];
}

/// Sign out action
class SignOutAction extends BaseAsyncAction<void> {
  const SignOutAction();

  @override
  String get type => AuthActionTypes.signOut;

  @override
  Future<Either<Exception, void>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [];
}

/// Reset password action
class ResetPasswordAction extends BaseAsyncAction<void> {
  const ResetPasswordAction({required this.email});

  final String email;

  @override
  String get type => AuthActionTypes.resetPassword;

  @override
  String get payload => email;

  @override
  Future<Either<Exception, void>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [email];
}

/// Check auth status action
class CheckAuthStatusAction extends BaseAction {
  const CheckAuthStatusAction();

  @override
  String get type => AuthActionTypes.checkAuthStatus;

  @override
  List<Object?> get props => [];
}

/// Clear error action
class ClearErrorAction extends BaseAction {
  const ClearErrorAction();

  @override
  String get type => AuthActionTypes.clearError;

  @override
  List<Object?> get props => [];
}

/// Social sign in action
class SocialSignInAction extends BaseAsyncAction<AuthUser> {
  const SocialSignInAction({required this.provider, this.redirectUrl});

  final SocialProvider provider;
  final String? redirectUrl;

  @override
  String get type => AuthActionTypes.socialSignIn;

  @override
  Map<String, dynamic> get payload => {
    'provider': provider.name,
    if (redirectUrl != null) 'redirectUrl': redirectUrl!,
  };

  @override
  Future<Either<Exception, AuthUser>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [provider, redirectUrl];
}

/// Phone sign in action
class PhoneSignInAction extends BaseAsyncAction<void> {
  const PhoneSignInAction({required this.phoneNumber});

  final String phoneNumber;

  @override
  String get type => AuthActionTypes.phoneSignIn;

  @override
  String get payload => phoneNumber;

  @override
  Future<Either<Exception, void>> execute() async {
    throw UnimplementedError('Execute should be handled by middleware');
  }

  @override
  List<Object?> get props => [phoneNumber];
}

/// Domain models
class AuthUser {
  const AuthUser({
    required this.id,
    required this.email,
    this.name,
    this.avatarUrl,
    this.phoneNumber,
    this.emailVerified = false,
    this.phoneVerified = false,
  });

  final String id;
  final String email;
  final String? name;
  final String? avatarUrl;
  final String? phoneNumber;
  final bool emailVerified;
  final bool phoneVerified;
}

enum SocialProvider { google, facebook, apple, github }
