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

  void _handleLogin(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      StoreProvider.of<AppState>(context, listen: false).dispatch(
        SignInAction(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  void _handleSocialLogin(BuildContext context, String provider) {
    StoreProvider.of<AppState>(context, listen: false).dispatch(
      SocialSignInAction(
        provider: SocialProvider.values.firstWhere(
          (SocialProvider p) => p.name == provider.toLowerCase(),
          orElse: () => SocialProvider.google,
        ),
      ),
    );
  }

  void _showForgotPasswordDialog(BuildContext context) {
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
            Text(l10n.resetPasswordMessage, style: theme.textTheme.bodyMedium),
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
                StoreProvider.of<AppState>(context, listen: false).dispatch(
                  ResetPasswordAction(
                    email: emailController.text.trim(),
                  ),
                );
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return StoreConnector<AppState, UiState>(
      converter: (Store<AppState> store) => store.state.uiState,
      builder: (BuildContext context, UiState uiState) {
        return AuthLayout(
          backgroundImage: 'assets/images/orange.jpg',
          isDarkMode:
              uiState.themeMode == ThemeMode.dark ||
              (uiState.themeMode == ThemeMode.system &&
                  theme.brightness == Brightness.dark),
          currentLanguage: uiState.locale.languageCode,
          onThemeToggle: () {
            StoreProvider.of<AppState>(
              context,
              listen: false,
            ).dispatch(const ToggleThemeModeAction());
          },
          onLanguageChanged: (String language) {
            StoreProvider.of<AppState>(
              context,
              listen: false,
            ).dispatch(ChangeLanguageAction(language));
          },
          child: StoreConnector<AppState, AuthState>(
            converter: (Store<AppState> store) => store.state.authState,
            builder: (BuildContext context, AuthState authState) {
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
                            onPressed: () => _showForgotPasswordDialog(context),
                            text: l10n.forgotPasswordQuestion,
                            variant: AuthButtonVariant.ghost,
                            width: 120,
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Error message
                        if (authState.error.isSome()) ...<Widget>[
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
                                    authState.error.fold(
                                      () => '',
                                      (Exception error) => error.toString(),
                                    ),
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
                          onPressed: () => _handleLogin(context),
                          text: l10n.login,
                          isLoading: authState.isLoading,
                        ),

                        const SizedBox(height: 24),

                        // Divider
                        const AuthDivider(),

                        const SizedBox(height: 24),

                        // Social login buttons
                        SocialAuthButton(
                          onPressed: () =>
                              _handleSocialLogin(context, 'github'),
                          provider: SocialAuthProvider.github,
                          isLoading: authState.isLoading,
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
      },
    );
  }
}
