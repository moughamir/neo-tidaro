import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  runApp(const AuthFlowApp());
}

class AuthFlowApp extends StatelessWidget {
  const AuthFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create Redux store
    final Store<AppState> store = createStore(enableLogging: true);

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'Auth Flow Example',
        localizationsDelegates: Languist.localizationsDelegates,
        supportedLocales: Languist.supportedLocales,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
          useMaterial3: true,
        ),
        home: const AuthFlowPage(),
      ),
    );
  }
}

class AuthFlowPage extends StatelessWidget {
  const AuthFlowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthState>(
      converter: (store) => store.state.authState,
      builder: (context, authState) {
        if (authState.isAuthenticated) {
          return const AuthenticatedView();
        } else {
          return const LoginView();
        }
      },
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: StoreConnector<AppState, AuthState>(
        converter: (store) => store.state.authState,
        builder: (context, authState) {
          return SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),

                    // App Logo/Title
                    Icon(
                      Icons.security,
                      size: 80,
                      color: Theme.of(context).primaryColor,
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Authentication Flow',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),

                    Text(
                      'Workspace Integration Example',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 48),

                    // Login Form
                    GlassyCard(
                      title: 'Sign In',
                      subtitle: 'Enter your credentials',
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          children: [
                            // Email Field
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                labelText: 'Email',
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!value.contains('@')) {
                                  return 'Please enter a valid email';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 16),

                            // Password Field
                            TextFormField(
                              controller: _passwordController,
                              obscureText: !_showPassword,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _showPassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                    });
                                  },
                                ),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),

                            const SizedBox(height: 24),

                            // Error Display
                            if (authState.error != null)
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16.0),
                                child: Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(12.0),
                                  decoration: BoxDecoration(
                                    color: Colors.red.shade100,
                                    borderRadius: BorderRadius.circular(8.0),
                                    border: Border.all(color: Colors.red),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Text(
                                          'Error: ${authState.error}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                            // Loading or Login Button
                            if (authState.isLoading)
                              const LoadingIndicator()
                            else
                              StoreConnector<AppState, VoidCallback>(
                                converter: (store) =>
                                    () => _handleLogin(store),
                                builder: (context, callback) => ElevatedButton(
                                  onPressed: callback,
                                  style: ElevatedButton.styleFrom(
                                    minimumSize: const Size(
                                      double.infinity,
                                      48,
                                    ),
                                  ),
                                  child: const Text('Sign In'),
                                ),
                              ),

                            const SizedBox(height: 16),

                            // Demo Actions
                            Text(
                              'Demo Actions:',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 8),

                            Wrap(
                              spacing: 8.0,
                              children: [
                                StoreConnector<AppState, VoidCallback>(
                                  converter: (store) =>
                                      () => store.dispatch(
                                        LoginSuccessAction({
                                          'email': 'demo@example.com',
                                          'name': 'Demo User',
                                        }),
                                      ),
                                  builder: (context, callback) =>
                                      ElevatedButton(
                                        onPressed: authState.isLoading
                                            ? null
                                            : callback,
                                        child: const Text('Demo Login'),
                                      ),
                                ),
                                StoreConnector<AppState, VoidCallback>(
                                  converter: (store) =>
                                      () => store.dispatch(
                                        LoginFailureAction(
                                          'Invalid credentials',
                                        ),
                                      ),
                                  builder: (context, callback) =>
                                      ElevatedButton(
                                        onPressed: authState.isLoading
                                            ? null
                                            : callback,
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red.shade100,
                                        ),
                                        child: const Text('Demo Error'),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Additional Actions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          onPressed: () => _showForgotPasswordDialog(context),
                          child: const Text('Forgot Password?'),
                        ),
                        TextButton(
                          onPressed: () => _showSignUpDialog(context),
                          child: const Text('Create Account'),
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

  void _handleLogin(Store<AppState> store) {
    if (_formKey.currentState?.validate() ?? false) {
      // Simulate login process
      store.dispatch(LoginStartAction());

      // Simulate network delay
      Future.delayed(const Duration(seconds: 2), () {
        if (_emailController.text == 'demo@example.com' &&
            _passwordController.text == 'password') {
          store.dispatch(
            LoginSuccessAction({
              'email': _emailController.text,
              'name': 'Demo User',
            }),
          );
        } else {
          store.dispatch(LoginFailureAction('Invalid email or password'));
        }
      });
    }
  }

  void _showForgotPasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: const Text(
          'Password reset functionality would be implemented here using the core package services.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          StoreConnector<AppState, VoidCallback>(
            converter: (store) => () {
              Navigator.of(context).pop();
              store.dispatch(ResetPasswordSuccessAction());
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password reset email sent!')),
              );
            },
            builder: (context, callback) => ElevatedButton(
              onPressed: callback,
              child: const Text('Send Reset Email'),
            ),
          ),
        ],
      ),
    );
  }

  void _showSignUpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Create Account'),
        content: const Text(
          'Sign up functionality would be implemented here using the shared package Redux actions and core package services.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          StoreConnector<AppState, VoidCallback>(
            converter: (store) => () {
              Navigator.of(context).pop();
              store.dispatch(
                SignUpSuccessAction({
                  'email': 'newuser@example.com',
                  'name': 'New User',
                }),
              );
            },
            builder: (context, callback) => ElevatedButton(
              onPressed: callback,
              child: const Text('Demo Sign Up'),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthenticatedView extends StatelessWidget {
  const AuthenticatedView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Authenticated'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          StoreConnector<AppState, VoidCallback>(
            converter: (store) =>
                () => store.dispatch(LogoutAction()),
            builder: (context, callback) => IconButton(
              icon: const Icon(Icons.logout),
              onPressed: callback,
              tooltip: 'Logout',
            ),
          ),
        ],
      ),
      body: StoreConnector<AppState, AuthState>(
        converter: (store) => store.state.authState,
        builder: (context, authState) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Welcome Section
                GlassyCard(
                  title: 'Welcome!',
                  subtitle: 'You are successfully authenticated',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.verified_user,
                          size: 64,
                          color: Colors.green,
                        ),
                        const SizedBox(height: 16),
                        if (authState.user != null) ...[
                          Text(
                            'User: ${authState.user['name'] ?? 'Unknown'}',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Text(
                            'Email: ${authState.user['email'] ?? 'Unknown'}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // User Actions
                InfoCard(
                  title: 'Available Actions',
                  content: Text(
                    'This authenticated view demonstrates how the workspace packages work together.',
                  ),
                  icon: Icons.info,
                ),

                const SizedBox(height: 16),

                // Counter Example (from shared Redux)
                StoreConnector<AppState, int>(
                  converter: (store) => UiSelectors.getCounter(store.state),
                  builder: (context, counter) {
                    return GlassyCard(
                      title: 'Redux Counter Example',
                      subtitle: 'Shared state management',
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              'Counter: $counter',
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                StoreConnector<AppState, VoidCallback>(
                                  converter: (store) =>
                                      () => store.dispatch(
                                        IncrementCounterAction(),
                                      ),
                                  builder: (context, callback) =>
                                      ElevatedButton.icon(
                                        onPressed: callback,
                                        icon: const Icon(Icons.add),
                                        label: const Text('Increment'),
                                      ),
                                ),
                                StoreConnector<AppState, VoidCallback>(
                                  converter: (store) =>
                                      () => store.dispatch(
                                        DecrementCounterAction(),
                                      ),
                                  builder: (context, callback) =>
                                      ElevatedButton.icon(
                                        onPressed: callback,
                                        icon: const Icon(Icons.remove),
                                        label: const Text('Decrement'),
                                      ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 16),

                // Localization Example
                GlassyCard(
                  title: 'Localization Examples',
                  subtitle: 'Languist package integration',
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Hello - Simple greeting'),
                        Text(
                          'Hello ${authState.user?['name'] ?? 'User'} - Parameterized greeting',
                        ),
                        const Text('Just now - Time format'),
                        const Text('Settings - Settings'),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // Logout Button
                StoreConnector<AppState, VoidCallback>(
                  converter: (store) =>
                      () => store.dispatch(LogoutAction()),
                  builder: (context, callback) => ElevatedButton(
                    onPressed: callback,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                      backgroundColor: Colors.red.shade600,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Sign Out'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
