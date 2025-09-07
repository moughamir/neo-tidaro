import 'auth_actions.dart';

class SignOutRequestAction {}

class SignOutSuccessAction {}

class SignOutFailureAction {
  final String error;
  SignOutFailureAction(this.error);
}

class LogoutAction extends AuthAction {}
