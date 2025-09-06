import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

void main() {
  runApp(const ReduxShowcaseApp());
}

class ReduxShowcaseApp extends StatelessWidget {
  const ReduxShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Redux App Showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const ReduxDashboard(),
    );
  }
}

class ReduxDashboard extends StatelessWidget {
  const ReduxDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Redux State Management Showcase'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Counter State Section
            _CounterSection(),
            const SizedBox(height: 24),

            // Loading State Section
            _LoadingSection(),
            const SizedBox(height: 24),

            // Message State Section
            _MessageSection(),
            const SizedBox(height: 24),

            // Authentication State Section
            _AuthSection(),
          ],
        ),
      ),
    );
  }
}

class _CounterSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Counter State Management',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            // Counter Display
            StoreConnector<AppState, int>(
              converter: (store) => UiSelectors.getCounter(store.state),
              builder: (context, counter) {
                return Center(
                  child: Column(
                    children: [
                      Text(
                        'Current Count: $counter',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),

                      // Action Buttons
                      Wrap(
                        spacing: 8.0,
                        children: [
                          StoreConnector<AppState, VoidCallback>(
                            converter: (store) =>
                                () => store.dispatch(IncrementCounterAction()),
                            builder: (context, callback) => ElevatedButton.icon(
                              onPressed: callback,
                              icon: const Icon(Icons.add),
                              label: const Text('Increment'),
                            ),
                          ),
                          StoreConnector<AppState, VoidCallback>(
                            converter: (store) =>
                                () => store.dispatch(DecrementCounterAction()),
                            builder: (context, callback) => ElevatedButton.icon(
                              onPressed: callback,
                              icon: const Icon(Icons.remove),
                              label: const Text('Decrement'),
                            ),
                          ),
                          StoreConnector<AppState, VoidCallback>(
                            converter: (store) =>
                                () => store.dispatch(SetCounterAction(10)),
                            builder: (context, callback) => ElevatedButton.icon(
                              onPressed: callback,
                              icon: const Icon(Icons.exposure_plus_1),
                              label: const Text('Set to 10'),
                            ),
                          ),
                          StoreConnector<AppState, VoidCallback>(
                            converter: (store) =>
                                () => store.dispatch(ResetCounterAction()),
                            builder: (context, callback) => ElevatedButton.icon(
                              onPressed: callback,
                              icon: const Icon(Icons.refresh),
                              label: const Text('Reset'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LoadingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Loading State Management',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            StoreConnector<AppState, bool>(
              converter: (store) => UiSelectors.isLoading(store.state),
              builder: (context, isLoading) {
                return Column(
                  children: [
                    if (isLoading) ...[
                      const CircularProgressIndicator(),
                      const SizedBox(height: 8),
                      const Text('Loading...'),
                    ] else
                      const Text('Not loading'),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(SetLoadingAction(true)),
                          builder: (context, callback) => ElevatedButton(
                            onPressed: isLoading ? null : callback,
                            child: const Text('Start Loading'),
                          ),
                        ),
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(SetLoadingAction(false)),
                          builder: (context, callback) => ElevatedButton(
                            onPressed: !isLoading ? null : callback,
                            child: const Text('Stop Loading'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Message State Management',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            StoreConnector<AppState, UiState>(
              converter: (store) => store.state.uiState,
              builder: (context, uiState) {
                return Column(
                  children: [
                    // Error Message Display
                    if (uiState.error != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.red),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.error, color: Colors.red),
                            const SizedBox(width: 8),
                            Expanded(child: Text('Error: ${uiState.error}')),
                            StoreConnector<AppState, VoidCallback>(
                              converter: (store) =>
                                  () => store.dispatch(ClearErrorAction()),
                              builder: (context, callback) => IconButton(
                                onPressed: callback,
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                      ),

                    // Success Message Display
                    if (uiState.successMessage != null)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(color: Colors.green),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle, color: Colors.green),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text('Success: ${uiState.successMessage}'),
                            ),
                            StoreConnector<AppState, VoidCallback>(
                              converter: (store) =>
                                  () => store.dispatch(
                                    ClearSuccessMessageAction(),
                                  ),
                              builder: (context, callback) => IconButton(
                                onPressed: callback,
                                icon: const Icon(Icons.close),
                              ),
                            ),
                          ],
                        ),
                      ),

                    if (uiState.error == null && uiState.successMessage == null)
                      const Text('No messages'),

                    const SizedBox(height: 16),

                    // Message Action Buttons
                    Wrap(
                      spacing: 8.0,
                      children: [
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(
                                ShowErrorAction('This is an error message'),
                              ),
                          builder: (context, callback) => ElevatedButton.icon(
                            onPressed: callback,
                            icon: const Icon(Icons.error),
                            label: const Text('Show Error'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red.shade100,
                            ),
                          ),
                        ),
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(
                                ShowSuccessMessageAction(
                                  'Operation completed successfully!',
                                ),
                              ),
                          builder: (context, callback) => ElevatedButton.icon(
                            onPressed: callback,
                            icon: const Icon(Icons.check),
                            label: const Text('Show Success'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green.shade100,
                            ),
                          ),
                        ),
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(ClearAllMessagesAction()),
                          builder: (context, callback) => ElevatedButton.icon(
                            onPressed: callback,
                            icon: const Icon(Icons.clear_all),
                            label: const Text('Clear All'),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _AuthSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Authentication State Management',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            StoreConnector<AppState, AuthState>(
              converter: (store) => store.state.authState,
              builder: (context, authState) {
                return Column(
                  children: [
                    // Auth Status Display
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: authState.isAuthenticated
                            ? Colors.green.shade100
                            : Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                          color: authState.isAuthenticated
                              ? Colors.green
                              : Colors.grey,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            authState.isAuthenticated
                                ? Icons.verified_user
                                : Icons.person_outline,
                            color: authState.isAuthenticated
                                ? Colors.green
                                : Colors.grey,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            authState.isAuthenticated
                                ? 'Authenticated'
                                : 'Not Authenticated',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: authState.isAuthenticated
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    if (authState.user != null) ...[
                      const SizedBox(height: 8),
                      Text('User: ${authState.user}'),
                    ],

                    if (authState.error != null) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Error: ${authState.error}',
                        style: const TextStyle(color: Colors.red),
                      ),
                    ],

                    if (authState.isLoading) ...[
                      const SizedBox(height: 8),
                      const CircularProgressIndicator(),
                      const Text('Processing...'),
                    ],

                    const SizedBox(height: 16),

                    // Auth Action Buttons
                    Wrap(
                      spacing: 8.0,
                      children: [
                        if (!authState.isAuthenticated) ...[
                          StoreConnector<AppState, VoidCallback>(
                            converter: (store) =>
                                () => store.dispatch(
                                  LoginSuccessAction({
                                    'email': 'demo@example.com',
                                  }),
                                ),
                            builder: (context, callback) => ElevatedButton.icon(
                              onPressed: authState.isLoading ? null : callback,
                              icon: const Icon(Icons.login),
                              label: const Text('Simulate Login'),
                            ),
                          ),
                          StoreConnector<AppState, VoidCallback>(
                            converter: (store) =>
                                () => store.dispatch(
                                  LoginFailureAction('Invalid credentials'),
                                ),
                            builder: (context, callback) => ElevatedButton.icon(
                              onPressed: authState.isLoading ? null : callback,
                              icon: const Icon(Icons.error),
                              label: const Text('Simulate Login Error'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red.shade100,
                              ),
                            ),
                          ),
                        ] else
                          StoreConnector<AppState, VoidCallback>(
                            converter: (store) =>
                                () => store.dispatch(LogoutAction()),
                            builder: (context, callback) => ElevatedButton.icon(
                              onPressed: callback,
                              icon: const Icon(Icons.logout),
                              label: const Text('Logout'),
                            ),
                          ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
