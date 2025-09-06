import 'auth_actions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogInRequestAction extends AuthAction {
  final String email;
  final String password;
  LogInRequestAction(this.email, this.password);
}

class LogInSuccessAction extends AuthAction {
  final User user;
  LogInSuccessAction(this.user);
}

class LoginFailureAction extends AuthAction {
  final String error;
  LoginFailureAction(this.error);
}

class LognInStartAction extends AuthAction {}
