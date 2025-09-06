import 'auth_actions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

//
class RegisterUserRequestAction {
  final String email;
  final String password;
  final String? fullName;
  RegisterUserRequestAction(this.email, this.password, this.fullName);
}

class RegisterUserStartAction extends AuthAction {}

class SignUpSuccessAction extends AuthAction {
  final User user;
  SignUpSuccessAction(this.user);
}

class SignUpFailureAction extends AuthAction {
  final String error;
  SignUpFailureAction(this.error);
}
