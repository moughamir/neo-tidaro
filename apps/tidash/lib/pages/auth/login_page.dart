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

  bool _isPasswordVisible = false;
  bool _rememberMe = false;

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

  void _showModernForgotPasswordDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final l10n = Languist.of(context);

    showGenericDialog(
      context,
      title: l10n.resetPassword,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(l10n.resetPasswordMessage),
          const SizedBox(height: 24),
          InputField(
            controller: emailController,
            labelText: l10n.email,
            hintText: l10n.emailHint,
            prefixIcon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        Button(
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
              showInfo(
                context,
                title: l10n.passwordResetEmailSent,
                message: '',
                type: InfoType.success,
              );
            }
          },
          label: l10n.sendResetLink,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = Languist.of(context);

    return StoreConnector<AppState, AuthState>(
      converter: (store) => store.state.authState,
      builder: (context, authState) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Header(
                title: l10n.login,
                subtitle: l10n.welcomeBackMessage,
              ),
              const SizedBox(height: 32),
              InputField(
                controller: _emailController,
                labelText: l10n.email,
                hintText: l10n.emailHint,
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: AuthValidators.email(l10n),
              ),
              const SizedBox(height: 16),
              InputField(
                controller: _passwordController,
                labelText: l10n.password,
                hintText: l10n.passwordHint,
                prefixIcon: Icons.lock_outlined,
                obscureText: !_isPasswordVisible,
                validator: AuthValidators.required(l10n),
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value ?? false;
                          });
                        },
                      ),
                      Text(l10n.rememberMe),
                    ],
                  ),
                  TextButton(
                    onPressed: () => _showModernForgotPasswordDialog(context),
                    child: Text(l10n.forgotPasswordQuestion),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (authState.error.isSome()) ...[
                ErrorDisplay(
                  message: authState.error.fold(() => '', (e) => e.toString()),
                ),
                const SizedBox(height: 24),
              ],
              Button(
                label: l10n.login,
                onPressed: authState.isLoading ? null : () => _handleLogin(context),
                isLoading: authState.isLoading,
              ),
              const SizedBox(height: 32),
              AuthDivider(text: l10n.commonOr),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.noAccountQuestion),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    child: Text(l10n.signUp),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
