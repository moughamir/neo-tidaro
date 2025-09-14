import 'package:core/core.dart';
import 'package:redux/redux.dart';

import '../actions/auth_actions.dart';
import '../core/core.dart';
import '../states/app_state.dart';

/// Auth middleware for handling async authentication operations
class AuthMiddleware extends MiddlewareClass<AppState> {
  AuthMiddleware(this.supabaseService);
  final SupabaseServiceInterface supabaseService;

  @override
  void call(Store<AppState> store, dynamic action, NextDispatcher next) {
    if (action is SignInAction) {
      _handleSignIn(store, action);
    } else if (action is SignUpAction) {
      _handleSignUp(store, action);
    } else if (action is SignOutAction) {
      _handleSignOut(store);
    } else if (action is ResetPasswordAction) {
      _handleResetPassword(store, action);
    } else if (action is CheckAuthStatusAction) {
      _handleCheckAuthStatus(store);
    }

    next(action);
  }

  Future<void> _handleSignIn(Store<AppState> store, SignInAction action) async {
    try {
      final result = await supabaseService.signInWithPassword(
        email: action.email,
        password: action.password,
      );

      result.fold(
        (failure) => store.dispatch(
          ActionCreators.failure(
            AuthActionTypes.signIn,
            Exception(failure.toString()),
          ),
        ),
        (user) => store.dispatch(
          ActionCreators.success(AuthActionTypes.signIn, user),
        ),
      );
    } catch (e) {
      store.dispatch(
        ActionCreators.failure(AuthActionTypes.signIn, Exception(e.toString())),
      );
    }
  }

  Future<void> _handleSignUp(Store<AppState> store, SignUpAction action) async {
    final Map<String, dynamic>? metadata = action.userMetadata;

    try {
      final result = await supabaseService.signUpWithPassword(
        email: action.email,
        password: action.password,
        userData: metadata,
      );

      result.fold(
        (failure) => store.dispatch(
          ActionCreators.failure(
            AuthActionTypes.signUp,
            Exception(failure.toString()),
          ),
        ),
        (user) => store.dispatch(
          ActionCreators.success(AuthActionTypes.signUp, user),
        ),
      );
    } catch (e) {
      store.dispatch(
        ActionCreators.failure(AuthActionTypes.signUp, Exception(e.toString())),
      );
    }
  }

  Future<void> _handleSignOut(Store<AppState> store) async {
    try {
      final result = await supabaseService.signOut();

      result.fold(
        (failure) => store.dispatch(
          ActionCreators.failure(
            AuthActionTypes.signOut,
            Exception(failure.toString()),
          ),
        ),
        (_) => store.dispatch(
          ActionCreators.success(AuthActionTypes.signOut, null),
        ),
      );
    } catch (e) {
      store.dispatch(
        ActionCreators.failure(
          AuthActionTypes.signOut,
          Exception(e.toString()),
        ),
      );
    }
  }

  Future<void> _handleResetPassword(
    Store<AppState> store,
    ResetPasswordAction action,
  ) async {
    try {
      final result = await supabaseService.resetPassword(action.email);

      result.fold(
        (failure) => store.dispatch(
          ActionCreators.failure(
            AuthActionTypes.resetPassword,
            Exception(failure.toString()),
          ),
        ),
        (_) => store.dispatch(
          ActionCreators.success(AuthActionTypes.resetPassword, null),
        ),
      );
    } catch (e) {
      store.dispatch(
        ActionCreators.failure(
          AuthActionTypes.resetPassword,
          Exception(e.toString()),
        ),
      );
    }
  }

  void _handleCheckAuthStatus(Store<AppState> store) {
    try {
      final isAuthed = supabaseService.isAuthenticated;
      final user = supabaseService.currentUser;

      if (isAuthed && user != null) {
        store.dispatch(
          ActionCreators.success(AuthActionTypes.userChanged, user),
        );
      } else {
        store.dispatch(
          ActionCreators.success(AuthActionTypes.userChanged, null),
        );
      }
    } catch (e) {
      // On any unexpected error, default to logged-out state
      store.dispatch(ActionCreators.success(AuthActionTypes.userChanged, null));
    }
  }
}
