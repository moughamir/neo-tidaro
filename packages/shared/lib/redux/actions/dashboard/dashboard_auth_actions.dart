// Dashboard-specific auth actions

class DashboardLoginAction {
  const DashboardLoginAction({required this.email, required this.password});

  final String email;
  final String password;
}

class DashboardLoginWithProviderAction {
  const DashboardLoginWithProviderAction({required this.provider});

  final String provider; // 'github', 'google', 'apple'
}

class DashboardSignUpAction {
  const DashboardSignUpAction({
    required this.email,
    required this.password,
    this.name,
  });

  final String email;
  final String password;
  final String? name;
}

class DashboardForgotPasswordAction {
  const DashboardForgotPasswordAction({required this.email});

  final String email;
}

class DashboardResetPasswordAction {
  const DashboardResetPasswordAction({
    required this.token,
    required this.newPassword,
  });

  final String token;
  final String newPassword;
}

class DashboardLogoutAction {
  const DashboardLogoutAction();
}

class DashboardAuthLoadingAction {
  const DashboardAuthLoadingAction(this.isLoading);
  final bool isLoading;
}

class DashboardAuthSuccessAction {
  const DashboardAuthSuccessAction({required this.user, this.accessToken});

  final Map<String, dynamic> user;
  final String? accessToken;
}

class DashboardAuthFailureAction {
  const DashboardAuthFailureAction(this.error);
  final String error;
}

class ClearDashboardAuthErrorAction {
  const ClearDashboardAuthErrorAction();
}
