import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import 'base_auth_page.dart';

class SignUpPage extends BaseAuthPage {
  const SignUpPage({super.key});

  @override
  Widget buildAuthContent(BuildContext context, IntlLocalizations l10n) {
    return _SignUpForm();
  }
}

class _SignUpForm extends StatefulWidget {
  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
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

    return StoreConnector<AppState, SignUpViewModel>(
      converter: (Store<AppState> store) => SignUpViewModel.fromStore(store),
      builder: (BuildContext context, SignUpViewModel viewModel) {
        return _formBuilder(l10n, theme, viewModel, context);
      },
    );
  }

  Form _formBuilder(
    IntlLocalizations l10n,
    ThemeData theme,
    SignUpViewModel viewModel,
    BuildContext context,
  ) {
    return Form(
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
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
            validator: AuthValidators.required(l10n),
          ),

          const SizedBox(height: 20),

          // Email field
          AuthInputField(
            label: l10n.email,
            hint: l10n.emailHint,
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: const Icon(Icons.email_outlined),
            validator: AuthValidators.email(l10n),
          ),

          const SizedBox(height: 20),

          // Password field
          AuthInputField(
            label: l10n.password,
            hint: l10n.passwordHint,
            controller: _passwordController,
            obscureText: true,
            prefixIcon: const Icon(Icons.lock_outlined),
            validator: AuthValidators.minLength(
              l10n,
              8,
              message: (IntlLocalizations l) => l.passwordTooShort,
            ),
          ),

          const SizedBox(height: 20),

          // Confirm password field
          AuthInputField(
            label: l10n.confirmPasswordLabel,
            hint: l10n.confirmPasswordHint,
            controller: _confirmPasswordController,
            obscureText: true,
            prefixIcon: const Icon(Icons.lock_outlined),
            validator: AuthValidators.confirmPassword(
              l10n,
              _passwordController,
            ),
          ),

          const SizedBox(height: 24),

          // Error message
          if (viewModel.error.isSome()) ...<Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: theme.colorScheme.error.withValues(alpha: 0.3),
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
                      viewModel.error.fold(
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

          // Sign up button
          AuthButton(
            onPressed: () => _handleSignUp(viewModel),
            text: l10n.signUp,
            isLoading: viewModel.isLoading,
          ),

          const SizedBox(height: 24),

          // Terms and privacy
          Text(
            l10n.termsAgreement,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
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
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
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
    );
  }

  void _handleSignUp(SignUpViewModel viewModel) {
    if (_formKey.currentState!.validate()) {
      viewModel.signUp(
        _emailController.text.trim(),
        _passwordController.text,
        _confirmPasswordController.text,
      );
    }
  }
}

class SignUpViewModel {
  factory SignUpViewModel.fromStore(Store<AppState> store) {
    return SignUpViewModel(
      isLoading: store.state.authState.isLoading,
      error: store.state.authState.error,
      signUp: (String email, String password, String name) => store.dispatch(
        SignUpAction(
          email: email,
          password: password,
          confirmPassword:
              password, // Note: confirmPassword validation should be done in UI
          userMetadata: <String, dynamic>{'name': name},
        ),
      ),
      signUpWithProvider: (String provider) => store.dispatch(
        const SocialSignInAction(provider: AuthProvider.email),
      ),
    );
  }
  const SignUpViewModel({
    required this.isLoading,
    required this.error,
    required this.signUp,
    required this.signUpWithProvider,
  });

  final bool isLoading;
  final Option<Exception> error;
  final Function(String email, String password, String name) signUp;
  final Function(String provider) signUpWithProvider;
}
