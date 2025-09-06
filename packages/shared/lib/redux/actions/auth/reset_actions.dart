import 'auth_actions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ResetPasswordStartAction extends AuthAction {}

class ResetPasswordSuccessAction extends AuthAction {}

class ResetPasswordFailureAction extends AuthAction {
  final String error;
  ResetPasswordFailureAction(this.error);
}

class ResetPasswordRequestAction {
  final String email;
  ResetPasswordRequestAction(this.email);
}

class UserChangedAction {
  final User? user;
  UserChangedAction(this.user);
}
