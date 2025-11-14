import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import 'base_auth_page.dart';

class SignUpPage extends BaseAuthPage {
  const SignUpPage({super.key});

  @override
  Widget buildAuthContent(BuildContext context, IntlLocalizations l10n) {
    return const _SignUpForm();
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm();

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

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

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
    final l10n = Languist.of(context);

    return StoreConnector<AppState, SignUpViewModel>(
      converter: (store) => SignUpViewModel.fromStore(store),
      builder: (context, viewModel) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Header(
                title: l10n.createAccount,
                subtitle: l10n.createAccountSubtitle,
              ),
              const SizedBox(height: 32),
              _buildNameField(l10n),
              const SizedBox(height: 16),
              _buildEmailField(l10n),
              const SizedBox(height: 16),
              _buildPasswordField(l10n),
              const SizedBox(height: 16),
              _buildConfirmPasswordField(l10n),
              const SizedBox(height: 24),
              if (viewModel.error.isSome()) ...[
                ErrorDisplay(
                  message: viewModel.error.fold(() => '', (e) => e.toString()),
                ),
                const SizedBox(height: 24),
              ],
              Button(
                label: l10n.signUp,
                onPressed: viewModel.isLoading ? null : () => _handleSignUp(viewModel),
                isLoading: viewModel.isLoading,
              ),
              const SizedBox(height: 32),
              _buildTermsAndPrivacy(l10n),
              const SizedBox(height: 32),
              _buildLoginLink(l10n, context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildNameField(IntlLocalizations l10n) {
    return InputField(
      controller: _nameController,
      labelText: l10n.name,
      hintText: l10n.nameHint,
      prefixIcon: Icons.person_outlined,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return l10n.fieldRequired;
        }
        return null;
      },
    );
  }

  Widget _buildEmailField(IntlLocalizations l10n) {
    return InputField(
      controller: _emailController,
      labelText: l10n.email,
      hintText: l10n.emailHint,
      prefixIcon: Icons.email_outlined,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      validator: AuthValidators.email(l10n),
    );
  }

  Widget _buildPasswordField(IntlLocalizations l10n) {
    return InputField(
      controller: _passwordController,
      labelText: l10n.password,
      hintText: l10n.createPasswordHint,
      prefixIcon: Icons.lock_outlined,
      obscureText: _obscurePassword,
      textInputAction: TextInputAction.next,
      suffixIcon: IconButton(
        icon: Icon(
          _obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
        ),
        onPressed: () {
          setState(() {
            _obscurePassword = !_obscurePassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.fieldRequired;
        }
        if (value.length < 8) {
          return l10n.passwordTooShort;
        }
        return null;
      },
    );
  }

  Widget _buildConfirmPasswordField(IntlLocalizations l10n) {
    return InputField(
      controller: _confirmPasswordController,
      labelText: l10n.confirmPasswordLabel,
      hintText: l10n.confirmPasswordHint,
      prefixIcon: Icons.lock_outlined,
      obscureText: _obscureConfirmPassword,
      textInputAction: TextInputAction.done,
      suffixIcon: IconButton(
        icon: Icon(
          _obscureConfirmPassword
              ? Icons.visibility_outlined
              : Icons.visibility_off_outlined,
        ),
        onPressed: () {
          setState(() {
            _obscureConfirmPassword = !_obscureConfirmPassword;
          });
        },
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return l10n.fieldRequired;
        }
        if (value != _passwordController.text) {
          return l10n.passwordsDontMatch;
        }
        return null;
      },
    );
  }

  Widget _buildTermsAndPrivacy(IntlLocalizations l10n) {
    return Text(
      l10n.termsAgreement,
      style: Theme.of(context).textTheme.bodySmall,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildLoginLink(IntlLocalizations l10n, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(l10n.haveAccountQuestion),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.login),
        ),
      ],
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
  factory SignUpViewModel.fromStore(Store<AppState> store) {
    return SignUpViewModel(
      isLoading: store.state.authState.isLoading,
      error: store.state.authState.error,
      signUp: (String email, String password, String name) => store.dispatch(
        SignUpAction(
          email: email,
          password: password,
          confirmPassword: password,
          userMetadata: <String, dynamic>{'name': name},
        ),
      ),
    );
  }
  const SignUpViewModel({
    required this.isLoading,
    required this.error,
    required this.signUp,
  });

  final bool isLoading;
  final Option<Exception> error;
  final Function(String email, String password, String name) signUp;
}
