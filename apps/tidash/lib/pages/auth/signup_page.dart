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

class _SignUpFormState extends State<_SignUpForm>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  late AnimationController _buttonAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    _buttonAnimationController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _buttonAnimationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _buttonAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return StoreConnector<AppState, SignUpViewModel>(
      converter: (Store<AppState> store) => SignUpViewModel.fromStore(store),
      builder: (BuildContext context, SignUpViewModel viewModel) {
        return _buildModernSignUpForm(l10n, theme, viewModel, context);
      },
    );
  }

  Widget _buildModernSignUpForm(
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
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.name,
              hintText: l10n.nameHint,
              prefixIcon: Icon(
                Icons.person_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                  width: 1,
                ),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.fieldRequired;
              }
              return null;
            },
          ),

          const SizedBox(height: 4),

          // Email field
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.email,
              hintText: l10n.emailHint,
              prefixIcon: Icon(
                Icons.email_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                  width: 1,
                ),
              ),
            ),
            validator: (String? value) {
              if (value == null || value.trim().isEmpty) {
                return l10n.fieldRequired;
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                return l10n.invalidEmail;
              }
              return null;
            },
          ),

          const SizedBox(height: 4),

          // Password field
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: l10n.password,
              hintText: l10n.createPasswordHint,
              prefixIcon: Icon(
                Icons.lock_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                  width: 1,
                ),
              ),
            ),
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

          const SizedBox(height: 4),

          // Confirm password field
          TextFormField(
            controller: _confirmPasswordController,
            obscureText: _obscureConfirmPassword,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              labelText: l10n.confirmPasswordLabel,
              hintText: l10n.confirmPasswordHint,
              prefixIcon: Icon(
                Icons.lock_outlined,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureConfirmPassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                ),
                onPressed: () {
                  setState(() {
                    _obscureConfirmPassword = !_obscureConfirmPassword;
                  });
                },
              ),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.primary,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: theme.colorScheme.error,
                  width: 1,
                ),
              ),
            ),
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

          const SizedBox(height: 4),

          // Error message
          if (viewModel.error.isSome()) ...<Widget>[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.error.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
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
                  const SizedBox(width: 12),
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
            const SizedBox(height: 4),
          ],

          // Sign up button
          AnimatedBuilder(
            animation: _buttonScaleAnimation,
            builder: (context, child) {
              return Transform.scale(
                scale: _buttonScaleAnimation.value,
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: viewModel.isLoading
                        ? null
                        : () => _handleSignUp(viewModel),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.primary,
                      foregroundColor: theme.colorScheme.onPrimary,
                      disabledBackgroundColor: theme.colorScheme.onSurface
                          .withValues(alpha: 0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: viewModel.isLoading
                        ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                theme.colorScheme.onPrimary,
                              ),
                            ),
                          )
                        : Text(
                            l10n.signUp,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                  ),
                ),
              );
            },
          ),

          const SizedBox(height: 4),

          // Terms and privacy
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              l10n.termsAgreement,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: 32),

          // Divider with "or"
          // Row(
          //   children: [
          //     Expanded(
          //       child: Divider(
          //         color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          //         thickness: 1,
          //       ),
          //     ),
          //     Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 16),
          //       child: Text(
          //         l10n.commonOr,
          //         style: theme.textTheme.bodySmall?.copyWith(
          //           color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //     ),
          //     Expanded(
          //       child: Divider(
          //         color: theme.colorScheme.onSurface.withValues(alpha: 0.2),
          //         thickness: 1,
          //       ),
          //     ),
          //   ],
          // ),
          // const SizedBox(height: 4),

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
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Text(
                  l10n.login,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    decorationColor: theme.colorScheme.primary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _handleSignUp(SignUpViewModel viewModel) {
    _buttonAnimationController.forward().then((_) {
      _buttonAnimationController.reverse();
    });

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
