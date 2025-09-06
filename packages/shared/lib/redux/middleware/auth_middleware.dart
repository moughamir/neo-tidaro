import 'package:redux/redux.dart';
import 'package:core/core.dart';
import '../app_state.dart';
import '../auth/auth_actions.dart';

/// Auth middleware for handling async authentication operations
class AuthMiddleware extends MiddlewareClass<AppState> {
  final SupabaseService supabaseService;

  AuthMiddleware(this.supabaseService);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is SignInRequestAction) {
      _handleSignIn(store, action);
    } else if (action is SignUpRequestAction) {
      _handleSignUp(store, action);
    } else if (action is SignOutRequestAction) {
      _handleSignOut(store);
    } else if (action is ResetPasswordRequestAction) {
      _handleResetPassword(store, action);
    } else if (action is CheckAuthStatusAction) {
      _handleCheckAuthStatus(store);
    }

    next(action);
  }

  Future<void> _handleSignIn(
    Store<AppState> store,
    SignInRequestAction action,
  ) async {
    final result = await supabaseService.signInWithPassword(
      email: action.email,
      password: action.password,
    );

    result.fold(
      (failure) => store.dispatch(SignInFailureAction(failure.message)),
      (user) => store.dispatch(SignInSuccessAction(user)),
    );
  }

  Future<void> _handleSignUp(
    Store<AppState> store,
    SignUpRequestAction action,
  ) async {
    final metadata = action.fullName != null
        ? {'full_name': action.fullName}
        : null;

    final result = await supabaseService.signUpWithPassword(
      email: action.email,
      password: action.password,
      userData: metadata,
    );

    result.fold(
      (failure) => store.dispatch(SignUpFailureAction(failure.message)),
      (user) => store.dispatch(SignUpSuccessAction(user)),
    );
  }

  Future<void> _handleSignOut(Store<AppState> store) async {
    final result = await supabaseService.signOut();

    result.fold(
      (failure) => store.dispatch(SignOutFailureAction(failure.message)),
      (_) => store.dispatch(SignOutSuccessAction()),
    );
  }

  Future<void> _handleResetPassword(
    Store<AppState> store,
    ResetPasswordRequestAction action,
  ) async {
    final result = await supabaseService.resetPassword(action.email);

    result.fold(
      (failure) => store.dispatch(ResetPasswordFailureAction(failure.message)),
      (_) => store.dispatch(ResetPasswordSuccessAction()),
    );
  }

  void _handleCheckAuthStatus(Store<AppState> store) {
    if (supabaseService.isAuthenticated &&
        supabaseService.currentUser != null) {
      store.dispatch(UserChangedAction(supabaseService.currentUser));
    } else {
      store.dispatch(UserChangedAction(null));
    }
  }
}
