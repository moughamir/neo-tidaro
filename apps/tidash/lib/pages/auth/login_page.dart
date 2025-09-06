import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return AuthLayout(
      isDarkMode: theme.brightness == Brightness.dark,
      currentLanguage: 'en', // TODO: Get from app state
      onThemeToggle: () {
        // TODO: Implement theme toggle
      },
      onLanguageChanged: (String language) {
        // TODO: Implement language change
      },
      child: StoreConnector<AppState, LoginViewModel>(
        converter: LoginViewModel.fromStore,
        builder: (BuildContext context, LoginViewModel viewModel) {
          return SingleChildScrollView(
            child: AuthCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Header
                    Text(
                      l10n.login,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.welcomeBackMessage,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Email field
                    AuthInputField(
                      label: l10n.email,
                      hint: l10n.emailHint,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(Icons.email_outlined),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return l10n.fieldRequired;
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                        ).hasMatch(value)) {
                          return l10n.invalidEmail;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Password field
                    AuthInputField(
                      label: l10n.password,
                      hint: l10n.passwordHint,
                      controller: _passwordController,
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outlined),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return l10n.fieldRequired;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 12),

                    // Forgot password link
                    Align(
                      alignment: Alignment.centerRight,
                      child: AuthButton(
                        onPressed: () =>
                            _showForgotPasswordDialog(context, viewModel),
                        text: l10n.forgotPasswordQuestion,
                        variant: AuthButtonVariant.ghost,
                        width: 120,
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Error message
                    if (viewModel.error != null) ...<Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error.withValues(
                            alpha: 0.1,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: theme.colorScheme.error.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.error_outline,
                              color: theme.colorScheme.error,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                viewModel.error!,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],

                    // Login button
                    AuthButton(
                      onPressed: () => _handleLogin(viewModel),
                      text: l10n.login,
                      isLoading: viewModel.isLoading,
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    const AuthDivider(),

                    const SizedBox(height: 24),

                    // Social login buttons
                    SocialAuthButton(
                      onPressed: () => viewModel.loginWithProvider('github'),
                      provider: SocialAuthProvider.github,
                      isLoading: viewModel.isLoading,
                    ),

                    const SizedBox(height: 32),

                    // Sign up link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          l10n.noAccountQuestion,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                        AuthButton(
                          onPressed: () => Navigator.pushReplacementNamed(
                            context,
                            '/signup',
                          ),
                          text: l10n.signUp,
                          variant: AuthButtonVariant.ghost,
                          width: 120,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _handleLogin(LoginViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      viewModel.login(_emailController.text.trim(), _passwordController.text);
    }
  }

  void _showForgotPasswordDialog(
    BuildContext context,
    LoginViewModel viewModel,
  ) {
    final TextEditingController emailController = TextEditingController();
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(l10n.resetPasswordTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              l10n.resetPasswordMessage,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            AuthInputField(
              label: l10n.email,
              hint: l10n.emailHint,
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          AuthButton(
            onPressed: () {
              if (emailController.text.isNotEmpty) {
                viewModel.forgotPassword(emailController.text.trim());
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.passwordResetEmailSent)),
                );
              }
            },
            text: l10n.sendResetLink,
            width: 120,
          ),
        ],
      ),
    );
  }
}

class LoginViewModel {
  const LoginViewModel({
    required this.isLoading,
    required this.error,
    required this.login,
    required this.loginWithProvider,
    required this.forgotPassword,
  });

  final bool isLoading;
  final String? error;
  final Function(String email, String password) login;
  final Function(String provider) loginWithProvider;
  final Function(String email) forgotPassword;

  factory LoginViewModel.fromStore(Store<AppState> store) {
    return LoginViewModel(
      isLoading: store.state.authState.isLoading,
      error: store.state.authState.error,
      login: (String email, String password) => store.dispatch(
        DashboardLoginAction(email: email, password: password),
      ),
      loginWithProvider: (String provider) =>
          store.dispatch(DashboardLoginWithProviderAction(provider: provider)),
      forgotPassword: (String email) =>
          store.dispatch(DashboardForgotPasswordAction(email: email)),
    );
  }
}
