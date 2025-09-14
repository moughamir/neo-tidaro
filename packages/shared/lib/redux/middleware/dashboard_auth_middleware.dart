import 'package:redux/redux.dart';
import 'package:shared/redux/actions/actions.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../states/app_state.dart';

List<Middleware<AppState>> createDashboardAuthMiddleware() {
  return [
    TypedMiddleware<AppState, DashboardLoginAction>(_handleLogin).call,
    TypedMiddleware<AppState, DashboardLoginWithProviderAction>(
      _handleSocialLogin,
    ).call,
    TypedMiddleware<AppState, DashboardSignUpAction>(_handleSignUp).call,
    TypedMiddleware<AppState, DashboardForgotPasswordAction>(
      _handleForgotPassword,
    ).call,
    TypedMiddleware<AppState, DashboardResetPasswordAction>(
      _handleResetPassword,
    ).call,
    TypedMiddleware<AppState, DashboardLogoutAction>(_handleLogout).call,
  ];
}

void _handleLogin(
  Store<AppState> store,
  DashboardLoginAction action,
  NextDispatcher next,
) async {
  next(action);
  store.dispatch(const DashboardAuthLoadingAction(true));

  try {
    final AuthResponse response = await Supabase.instance.client.auth
        .signInWithPassword(email: action.email, password: action.password);

    if (response.user != null) {
      store.dispatch(
        DashboardAuthSuccessAction(
          user: response.user!.toJson(),
          accessToken: null, // UserResponse doesn't have session
        ),
      );
    } else {
      store.dispatch(const DashboardAuthFailureAction('Login failed'));
    }
  } catch (error) {
    store.dispatch(DashboardAuthFailureAction(error.toString()));
  } finally {
    store.dispatch(const DashboardAuthLoadingAction(false));
  }
}

void _handleSocialLogin(
  Store<AppState> store,
  DashboardLoginWithProviderAction action,
  NextDispatcher next,
) async {
  next(action);
  store.dispatch(const DashboardAuthLoadingAction(true));

  try {
    OAuthProvider provider;
    switch (action.provider.toLowerCase()) {
      case 'google':
        provider = OAuthProvider.google;
        break;
      case 'apple':
        provider = OAuthProvider.apple;
        break;
      default:
        throw Exception('Unsupported provider: ${action.provider}');
    }

    await Supabase.instance.client.auth.signInWithOAuth(
      provider,
      redirectTo: 'your-app://auth-callback',
    );

    // OAuth success will be handled by auth state listener
  } catch (error) {
    store.dispatch(DashboardAuthFailureAction(error.toString()));
  } finally {
    store.dispatch(const DashboardAuthLoadingAction(false));
  }
}

void _handleSignUp(
  Store<AppState> store,
  DashboardSignUpAction action,
  NextDispatcher next,
) async {
  next(action);
  store.dispatch(const DashboardAuthLoadingAction(true));

  try {
    final AuthResponse response = await Supabase.instance.client.auth.signUp(
      email: action.email,
      password: action.password,
      data: action.name != null ? {'name': action.name} : null,
    );

    if (response.user != null) {
      store.dispatch(
        DashboardAuthSuccessAction(
          user: response.user!.toJson(),
          accessToken: null, // UserResponse doesn't have session
        ),
      );
    } else {
      store.dispatch(const DashboardAuthFailureAction('Sign up failed'));
    }
  } catch (error) {
    store.dispatch(DashboardAuthFailureAction(error.toString()));
  } finally {
    store.dispatch(const DashboardAuthLoadingAction(false));
  }
}

void _handleForgotPassword(
  Store<AppState> store,
  DashboardForgotPasswordAction action,
  NextDispatcher next,
) async {
  next(action);
  store.dispatch(const DashboardAuthLoadingAction(true));

  try {
    await Supabase.instance.client.auth.resetPasswordForEmail(
      action.email,
      redirectTo: 'your-app://reset-password',
    );

    // Success - user will receive email
    store.dispatch(const DashboardAuthLoadingAction(false));
  } catch (error) {
    store.dispatch(DashboardAuthFailureAction(error.toString()));
    store.dispatch(const DashboardAuthLoadingAction(false));
  }
}

void _handleResetPassword(
  Store<AppState> store,
  DashboardResetPasswordAction action,
  NextDispatcher next,
) async {
  next(action);
  store.dispatch(const DashboardAuthLoadingAction(true));

  try {
    final UserResponse response = await Supabase.instance.client.auth
        .updateUser(UserAttributes(password: action.newPassword));

    if (response.user != null) {
      store.dispatch(
        DashboardAuthSuccessAction(
          user: response.user!.toJson(),
          accessToken: null, // UserResponse doesn't have session
        ),
      );
    }
  } catch (error) {
    store.dispatch(DashboardAuthFailureAction(error.toString()));
  } finally {
    store.dispatch(const DashboardAuthLoadingAction(false));
  }
}

void _handleLogout(
  Store<AppState> store,
  DashboardLogoutAction action,
  NextDispatcher next,
) async {
  next(action);

  try {
    await Supabase.instance.client.auth.signOut();
    // Auth state will be updated by the auth state listener
  } catch (error) {
    store.dispatch(DashboardAuthFailureAction(error.toString()));
  }
}
