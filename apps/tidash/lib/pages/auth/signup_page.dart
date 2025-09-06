import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:languist/languist.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return AuthLayout(
      backgroundImage: 'assets/images/orange.jpg',
      isDarkMode: theme.brightness == Brightness.dark,
      currentLanguage: 'en', // TODO: Get from app state
      onThemeToggle: () {
        // TODO: Implement theme toggle
      },
      onLanguageChanged: (String language) {
        // TODO: Implement language change
      },
      child: StoreConnector<AppState, SignUpViewModel>(
        converter: (Store<AppState> store) => SignUpViewModel.fromStore(store),
        builder: (BuildContext context, SignUpViewModel viewModel) {
          return SingleChildScrollView(
            child: AuthCard(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    // Header
                    Text(
                      l10n.createAccount,
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n.createAccountSubtitle,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Name field
                    AuthInputField(
                      label: l10n.name,
                      hint: l10n.nameHint,
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      prefixIcon: const Icon(Icons.person_outlined),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return l10n.fieldRequired;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

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
                        if (value.length < 8) {
                          return l10n.passwordTooShort;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 20),

                    // Confirm password field
                    AuthInputField(
                      label: l10n.confirmPasswordLabel,
                      hint: l10n.confirmPasswordHint,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      prefixIcon: const Icon(Icons.lock_outlined),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return l10n.fieldRequired;
                        }
                        if (value != _passwordController.text) {
                          return l10n.passwordsDontMatch;
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 24),

                    // Error message
                    if (viewModel.error != null) ...<Widget>[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.error.withValues(alpha: 0.1),
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

                    // Sign up button
                    AuthButton(
                      onPressed: () => _handleSignUp(viewModel),
                      text: l10n.signUp,
                      isLoading: viewModel.isLoading,
                    ),

                    const SizedBox(height: 24),

                    // Divider
                    const AuthDivider(),

                    const SizedBox(height: 24),

                    // Social login buttons
                    SocialAuthButton(
                      onPressed: () => viewModel.signUpWithProvider('github'),
                      provider: SocialAuthProvider.github,
                      isLoading: viewModel.isLoading,
                    ),

                    const SizedBox(height: 32),

                    // Terms and privacy
                    Text(
                      l10n.termsAgreement,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.6,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 24),

                    // Login link
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          l10n.haveAccountQuestion,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.7,
                            ),
                          ),
                        ),
                        AuthButton(
                          onPressed: () =>
                              Navigator.pushReplacementNamed(context, '/login'),
                          text: l10n.login,
                          variant: AuthButtonVariant.ghost,
                          width: 60,
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

  void _handleSignUp(SignUpViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      viewModel.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        _nameController.text.trim(),
      );
    }
  }
}

class SignUpViewModel {
  const SignUpViewModel({
    required this.isLoading,
    required this.error,
    required this.signUp,
    required this.signUpWithProvider,
  });

  final bool isLoading;
  final String? error;
  final Function(String email, String password, String name) signUp;
  final Function(String provider) signUpWithProvider;

  factory SignUpViewModel.fromStore(Store<AppState> store) {
    return SignUpViewModel(
      isLoading: store.state.authState.isLoading,
      error: store.state.authState.error,
      signUp: (String email, String password, String name) => store.dispatch(
        DashboardSignUpAction(email: email, password: password, name: name),
      ),
      signUpWithProvider: (String provider) =>
          store.dispatch(DashboardLoginWithProviderAction(provider: provider)),
    );
  }
}
