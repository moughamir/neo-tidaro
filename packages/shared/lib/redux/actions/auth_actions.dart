/// Authentication Actions
abstract class AuthAction {}

class LoginStartAction extends AuthAction {}

class LoginSuccessAction extends AuthAction {
  final dynamic user;
  LoginSuccessAction(this.user);
}

class LoginFailureAction extends AuthAction {
  final String error;
  LoginFailureAction(this.error);
}

class LogoutAction extends AuthAction {}

class SignUpStartAction extends AuthAction {}

class SignUpSuccessAction extends AuthAction {
  final dynamic user;
  SignUpSuccessAction(this.user);
}

class SignUpFailureAction extends AuthAction {
  final String error;
  SignUpFailureAction(this.error);
}

class ResetPasswordStartAction extends AuthAction {}

class ResetPasswordSuccessAction extends AuthAction {}

class ResetPasswordFailureAction extends AuthAction {
  final String error;
  ResetPasswordFailureAction(this.error);
}
