import 'package:redux/redux.dart';
import 'package:core/core.dart';
import '../app_state.dart';
import '../actions/auth/auth.dart';

/// Auth middleware for handling async authentication operations
class AuthMiddleware extends MiddlewareClass<AppState> {
  final SupabaseService supabaseService;

  AuthMiddleware(this.supabaseService);

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is LogInRequestAction) {
      _handleSignIn(store, action);
    } else if (action is RegisterUserRequestAction) {
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
    LogInRequestAction action,
  ) async {
    try {
      final result = await supabaseService.signInWithPassword(
        email: action.email,
        password: action.password,
      );

      result.fold(
        (failure) => store.dispatch(LoginFailureAction(failure.message)),
        (user) => store.dispatch(LogInSuccessAction(user)),
      );
    } catch (e) {
      store.dispatch(LoginFailureAction(e.toString()));
    }
  }

  Future<void> _handleSignUp(
    Store<AppState> store,
    RegisterUserRequestAction action,
  ) async {
    final Map<String, dynamic>? metadata =
        action.fullName != null ? {'full_name': action.fullName} : null;

    try {
      final result = await supabaseService.signUpWithPassword(
        email: action.email,
        password: action.password,
        userData: metadata,
      );

      result.fold(
        (failure) => store.dispatch(SignUpFailureAction(failure.message)),
        (user) => store.dispatch(SignUpSuccessAction(user)),
      );
    } catch (e) {
      store.dispatch(SignUpFailureAction(e.toString()));
    }
  }

  Future<void> _handleSignOut(Store<AppState> store) async {
    try {
      final result = await supabaseService.signOut();

      result.fold(
        (failure) => store.dispatch(SignOutFailureAction(failure.message)),
        (_) => store.dispatch(SignOutSuccessAction()),
      );
    } catch (e) {
      store.dispatch(SignOutFailureAction(e.toString()));
    }
  }

  Future<void> _handleResetPassword(
    Store<AppState> store,
    ResetPasswordRequestAction action,
  ) async {
    try {
      final result = await supabaseService.resetPassword(action.email);

      result.fold(
        (failure) =>
            store.dispatch(ResetPasswordFailureAction(failure.message)),
        (_) => store.dispatch(ResetPasswordSuccessAction()),
      );
    } catch (e) {
      store.dispatch(ResetPasswordFailureAction(e.toString()));
    }
  }

  void _handleCheckAuthStatus(Store<AppState> store) {
    try {
      final isAuthed = supabaseService.isAuthenticated;
      final user = supabaseService.currentUser;

      if (isAuthed && user != null) {
        store.dispatch(UserChangedAction(user));
      } else {
        store.dispatch(UserChangedAction(null));
      }
    } catch (e) {
      // On any unexpected error, default to logged-out state
      store.dispatch(UserChangedAction(null));
    }
  }
}
