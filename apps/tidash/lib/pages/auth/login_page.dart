import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import 'base_auth_page.dart';

class LoginPage extends BaseAuthPage {
  const LoginPage({super.key});

  @override
  Widget buildAuthContent(BuildContext context, IntlLocalizations l10n) {
    return const _ModernLoginForm();
  }
}

class _ModernLoginForm extends StatefulWidget {
  const _ModernLoginForm();

  @override
  State<_ModernLoginForm> createState() => _ModernLoginFormState();
}

class _ModernLoginFormState extends State<_ModernLoginForm>
    with TickerProviderStateMixin {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late AnimationController _buttonController;
  late Animation<double> _buttonScaleAnimation;

  bool _isPasswordVisible = false;
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();

    _buttonController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _buttonController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _buttonController.dispose();
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

  void _showModernForgotPasswordDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    showDialog(
      context: context,
      builder: (BuildContext context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.resetPassword,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                l10n.resetPasswordMessage,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: l10n.email,
                  hintText: l10n.emailHint,
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest
                      .withValues(alpha: 0.5),
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
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        l10n.commonCancel,
                        style: TextStyle(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.7,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (emailController.text.isNotEmpty) {
                          StoreProvider.of<AppState>(
                            context,
                            listen: false,
                          ).dispatch(
                            ResetPasswordAction(
                              email: emailController.text.trim(),
                            ),
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(l10n.passwordResetEmailSent),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(l10n.sendResetLink),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return StoreConnector<AppState, AuthState>(
      converter: (Store<AppState> store) => store.state.authState,
      builder: (BuildContext context, AuthState authState) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // Modern header with welcome message
              _buildModernHeader(theme, l10n),
              const SizedBox(height: 4),
              // Modern email field
              _buildModernEmailField(theme, l10n),
              const SizedBox(height: 4),
              // Modern password field with visibility toggle
              _buildModernPasswordField(theme, l10n),
              const SizedBox(height: 4),
              // Remember me and forgot password row
              _buildRememberMeRow(theme, l10n, context),
              const SizedBox(height: 4),
              // Modern error display
              if (authState.error.isSome()) ...<Widget>[
                _buildModernErrorMessage(theme, authState),
                const SizedBox(height: 24),
              ],
              const SizedBox(height: 4),
              // Modern login button with animation
              _buildModernLoginButton(theme, l10n, authState, context),
              const SizedBox(height: 4),
              // // Modern divider
              // _buildModernDivider(theme, l10n),

              // const SizedBox(height: 32),

              // Modern sign up link
              _buildModernSignUpLink(theme, l10n, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildModernHeader(ThemeData theme, IntlLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.login,
          style: theme.textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.welcomeBackMessage,
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildModernEmailField(ThemeData theme, IntlLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.email,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          validator: AuthValidators.email(l10n),
          decoration: InputDecoration(
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
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernPasswordField(ThemeData theme, IntlLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.password,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: _passwordController,
          obscureText: !_isPasswordVisible,
          validator: AuthValidators.required(l10n),
          decoration: InputDecoration(
            hintText: l10n.passwordHint,
            prefixIcon: Icon(
              Icons.lock_outlined,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
              icon: Icon(
                _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
              ),
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
              borderSide: BorderSide(color: theme.colorScheme.error, width: 2),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberMeRow(
    ThemeData theme,
    IntlLocalizations l10n,
    BuildContext context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Remember me checkbox
        Row(
          children: [
            Checkbox(
              value: _rememberMe,
              onChanged: (bool? value) {
                setState(() {
                  _rememberMe = value ?? false;
                });
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Text(
              l10n.rememberMe,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),

        // Forgot password link
        TextButton(
          onPressed: () => _showModernForgotPasswordDialog(context),
          child: Text(
            l10n.forgotPasswordQuestion,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.primary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildModernErrorMessage(ThemeData theme, AuthState authState) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: theme.colorScheme.error.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: theme.colorScheme.onErrorContainer,
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              authState.error.fold(
                () => '',
                (Exception error) => error.toString(),
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernLoginButton(
    ThemeData theme,
    IntlLocalizations l10n,
    AuthState authState,
    BuildContext context,
  ) {
    return ScaleTransition(
      scale: _buttonScaleAnimation,
      child: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: authState.isLoading
              ? null
              : () {
                  _buttonController.forward().then((_) {
                    _buttonController.reverse();
                    _handleLogin(context);
                  });
                },
          style: ElevatedButton.styleFrom(
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: theme.colorScheme.onPrimary,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: authState.isLoading
              ? SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      theme.colorScheme.onPrimary,
                    ),
                  ),
                )
              : Text(
                  l10n.login,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
        ),
      ),
    );
  }

  // Widget _buildModernDivider(ThemeData theme, IntlLocalizations l10n) {
  //   return Row(
  //     children: [
  //       Expanded(
  //         child: Divider(
  //           color: theme.colorScheme.outline.withValues(alpha: 0.2),
  //           thickness: 1,
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16),
  //         child: Text(
  //           l10n.commonOr,
  //           style: theme.textTheme.bodySmall?.copyWith(
  //             color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
  //             fontWeight: FontWeight.w500,
  //           ),
  //         ),
  //       ),
  //       Expanded(
  //         child: Divider(
  //           color: theme.colorScheme.outline.withValues(alpha: 0.2),
  //           thickness: 1,
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildModernSignUpLink(
    ThemeData theme,
    IntlLocalizations l10n,
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.noAccountQuestion,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () => Navigator.pushNamed(context, '/signup'),
            child: Text(
              l10n.signUp,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
