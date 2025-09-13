
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

import 'parallax_example_page.dart';

void main() {
  runApp(const UiKitShowcaseApp());
}

class UiKitShowcaseApp extends StatefulWidget {
  const UiKitShowcaseApp({super.key});

  @override
  State<UiKitShowcaseApp> createState() => _UiKitShowcaseAppState();
}

class _UiKitShowcaseAppState extends State<UiKitShowcaseApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Kit Showcase',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: Languist.localizationsDelegates,
      supportedLocales: Languist.supportedLocales,
      home: UiKitDashboard(
        onThemeToggle: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class UiKitDashboard extends StatefulWidget {

  const UiKitDashboard({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  @override
  State<UiKitDashboard> createState() => _UiKitDashboardState();
}

class _UiKitDashboardState extends State<UiKitDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Kit Showcase'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            onPressed: widget.onThemeToggle,
            icon: Icon(widget.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            tooltip: widget.isDarkMode
                ? 'Switch to Light Mode'
                : 'Switch to Dark Mode',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'UI Kit Components',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 16),

            // Glassy Cards Section
            _SectionCard(
              title: 'Glassy Cards',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  KuiCard.glass(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Welcome to UI Kit Showcase',
                            style: Theme.of(context).textTheme.titleLarge
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'This showcases the glassy card component with blur and transparency effects.',
                            style: Theme.of(context).textTheme.bodyMedium,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
                          const Text('Welcome to UI Kit Showcase'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  KuiCard.glass(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          const Icon(Icons.info, size: 32),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Card with Icon',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Cards can contain any widget composition.',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Grid Layout Example
            _SectionCard(
              title: 'Grid Layout',
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 1.5,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  final icons = [
                    Icons.widgets,
                    Icons.palette,
                    Icons.code,
                    Icons.design_services,
                  ];
                  final labels = ['Components', 'Themes', 'Code', 'Design'];

                  return KuiCard.glass(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            icons[index],
                            size: 32,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(height: 8),
                          Text(labels[index]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            // Parallax Example Section
            _SectionCard(
              title: 'Parallax Effect',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Interactive parallax effect using device sensors',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ParallaxExamplePage(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.motion_photos_on),
                    label: const Text('View Parallax Demo'),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tilt your device to see the parallax layers move',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Markdown Widget Section
            _SectionCard(
              title: 'Markdown Widget',
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  // Default Markdown Example
                  Text(
                    'Default Style',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 150,
                      maxHeight: 250,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRect(
                      child: Builder(
                        builder: (context) => widget.isDarkMode
                            ? MarkdownWidget(
                                data: _getMarkdownExample(),
                                config: MarkdownConfig.defaultConfig(context)
                                    .copyWith(
                                      shrinkWrap: false,
                                      padding: const EdgeInsets.all(8),
                                    ),
                              )
                            : MarkdownWidget(
                                data: _getMarkdownExample(),
                                config: MarkdownConfig.defaultConfig(context)
                                    .copyWith(
                                      shrinkWrap: false,
                                      padding: const EdgeInsets.all(8),
                                    ),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Compact Markdown Example
                  Text(
                    'Compact Style',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                      maxHeight: 180,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRect(
                      child: Builder(
                        builder: (context) => MarkdownWidget(
                          data: _getCompactMarkdownExample(),
                          config: widget.isDarkMode
                              ? MarkdownConfig.compactConfig(context).copyWith(
                                  shrinkWrap: false,
                                  padding: const EdgeInsets.all(8),
                                )
                              : MarkdownConfig.compactConfig(
                                  context,
                                ).copyWith(shrinkWrap: false),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Extension Method Example
                  Text(
                    'Extension Method Usage',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 80,
                      maxHeight: 120,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRect(
                      child: Builder(
                        builder: (context) => MarkdownWidget(
                          data:
                              '**Dynamic Content:** `Live Demo`\n\n*Showcasing real-time markdown rendering*',
                          config: widget.isDarkMode
                              ? MarkdownConfig.defaultConfig(context).copyWith(
                                  shrinkWrap: false,
                                  padding: const EdgeInsets.all(8),
                                )
                              : MarkdownConfig.compactConfig(
                                  context,
                                ).copyWith(shrinkWrap: false),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Markdown Utils Example
                  Text(
                    'Generated with MarkdownUtils',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    constraints: const BoxConstraints(
                      minHeight: 100,
                      maxHeight: 150,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRect(
                      child: Builder(
                        builder: (context) => MarkdownWidget(
                          data: _getGeneratedMarkdown(),
                          config: widget.isDarkMode
                              ? MarkdownConfig.defaultConfig(context).copyWith(
                                  shrinkWrap: false,
                                  padding: const EdgeInsets.all(8),
                                )
                              : MarkdownConfig.compactConfig(
                                  context,
                                ).copyWith(shrinkWrap: false),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Authentication Components
            _SectionCard(
              title: 'Authentication Components',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const AuthButton(
                    onPressed: null,
                    text: 'Primary Button',
                    variant: AuthButtonVariant.primary,
                  ),
                  const SizedBox(height: 12),
                  const AuthButton(
                    onPressed: null,
                    text: 'Secondary Button',
                    variant: AuthButtonVariant.secondary,
                  ),
                  const SizedBox(height: 12),
                  const AuthButton(
                    onPressed: null,
                    text: 'Ghost Button',
                    variant: AuthButtonVariant.ghost,
                  ),
                  const SizedBox(height: 12),
                  const AuthButton(
                    onPressed: null,
                    text: 'Loading Button',
                    variant: AuthButtonVariant.primary,
                    isLoading: true,
                  ),
                  const SizedBox(height: 12),
                  AuthButton(
                    onPressed: () {},
                    text: 'Button with Icon',
                    variant: AuthButtonVariant.primary,
                    icon: const Icon(Icons.login, size: 18),
                  ),
                  const SizedBox(height: 16),
                  const SocialAuthButton(
                    onPressed: null,
                    provider: SocialAuthProvider.google,
                  ),
                  const SizedBox(height: 12),
                  const SocialAuthButton(
                    onPressed: null,
                    provider: SocialAuthProvider.github,
                  ),
                  const SizedBox(height: 12),
                  const SocialAuthButton(
                    onPressed: null,
                    provider: SocialAuthProvider.apple,
                  ),
                  const SizedBox(height: 12),
                  const SocialAuthButton(
                    onPressed: null,
                    provider: SocialAuthProvider.google,
                    isLoading: true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Neomorphic Components
            _SectionCard(
              title: 'Neomorphic Components',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  KuiButton(
                    onPressed: () {},
                    tooltip: 'Neomorphic Button',
                    child: const Text('Neomorphic Button'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Note: Other neomorphic components (NeomorphicCard, NeomorphicElevatedButton, etc.) are available in the UI Kit but may need proper implementation.',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Button Components
            _SectionCard(
              title: 'Button Components',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  KuiButton(
                    variant: ButtonVariant.neumorphic,
                    onPressed: () {},
                    child: const Text('Primary Button'),
                  ),
                  const SizedBox(height: 12),
                  KuiButton(
                    onPressed: () {},
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.add, size: 18),
                        SizedBox(width: 8),
                        Text('Button with Icon'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  const KuiButton(
                    onPressed: null,
                    child: Text('Disabled Button'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Cards Components
            const _SectionCard(
              title: 'Card Components',
              child: Column(
                children: [
                  SizedBox(height: 16),
                  MetricCard(
                    title: 'Total Users',
                    value: '12.5K',
                    icon: Icon(Icons.people),
                    trend: '+12%',
                  ),
                  SizedBox(height: 16),
                  InfoCard(
                    title: 'Information Card',
                    icon: Icons.info,
                    children: [
                      Text('This is an information card with custom content.'),
                      SizedBox(height: 8),
                      Text('It can contain multiple widgets.'),
                    ],
                  ),
                  SizedBox(height: 16),
                  KuiCard.hybrid(
                    title: 'Enhanced Info Card',
                    leading: Icon(Icons.star),
                    trailing: Text('Footer content here'),
                    showBorder: true,
                    child: Text(
                      'This card has a structured layout with header, content, and footer.',
                    ),
                  ),
                  SizedBox(height: 16),
                  KuiCard.glass(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('Basic Glassy Card with blur effect'),
                    ),
                  ),
                  SizedBox(height: 16),
                  KuiCard.glass(
                    title: 'Enhanced Glassy Card',
                    child: Text(
                      'This glassy card has a title and structured content area.',
                    ),
                  ),
                  SizedBox(height: 16),
                  AuthCard(
                    child: Padding(
                      padding: EdgeInsets.all(24.0),
                      child: Column(
                        children: [
                          Text(
                            'Authentication Card',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text('Specialized card for auth flows'),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  KuiCard.glass(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Base Glass Card - Foundation for glass effects',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Utility Components
            _SectionCard(
              title: 'Utility Components',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const LoadingIndicator(message: 'Loading data...', size: 32),
                  const SizedBox(height: 24),
                  ErrorDisplay(
                    failure: Failure.server('Something went wrong'),
                    details: 'Please try again later',
                    icon: Icons.error_outline,
                  ),
                  const SizedBox(height: 24),
                  const EmptyState(
                    icon: Icons.inbox_outlined,
                    title: 'No Data Available',
                    description: 'There is no data to display at the moment.',
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => GenericDialog(
                          title: 'Sample Dialog',
                          content: const Text(
                            'This is a generic dialog component.',
                          ),
                          primaryButtonText: 'OK',
                          secondaryButtonText: 'Cancel',
                          onPrimaryButtonPressed: () =>
                              Navigator.of(context).pop(),
                          onSecondaryButtonPressed: () =>
                              Navigator.of(context).pop(),
                        ),
                      );
                    },
                    child: const Text('Show Generic Dialog'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Dashboard Components
            _SectionCard(
              title: 'Dashboard Components',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  DashboardHeader(
                    onRefresh: () {},
                    lastUpdated: DateTime.now().subtract(
                      const Duration(minutes: 5),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const SectionHeader(
                    title: 'Section Header',
                    icon: Icons.dashboard,
                  ),
                  const SizedBox(height: 16),
                  ActivityFeed(
                    activities: [
                      ActivityItem(
                        id: '1',
                        title: 'User Registration',
                        description: 'New user signed up',
                        timestamp: DateTime.now().subtract(
                          const Duration(minutes: 5),
                        ),
                        type: ActivityType.user,
                      ),
                      ActivityItem(
                        id: '2',
                        title: 'System Update',
                        description: 'System was updated to v2.1.0',
                        timestamp: DateTime.now().subtract(
                          const Duration(hours: 2),
                        ),
                        type: ActivityType.system,
                      ),
                    ],
                    titleExtractor: (ActivityItem activity) {
                      return activity.title;
                    },
                    descriptionExtractor: (ActivityItem activity) {
                      return activity.description;
                    },
                    timestampExtractor: (ActivityItem activity) {
                      return activity.timestamp;
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Layout Components
            _SectionCard(
              title: 'Layout Components',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Responsive Layout',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 100,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ResponsiveLayout(
                      smallBuilder: (context) =>
                          const Center(child: Text('Small Screen Layout')),
                      mediumBuilder: (context) =>
                          const Center(child: Text('Medium Screen Layout')),
                      largeBuilder: (context) =>
                          const Center(child: Text('Large Screen Layout')),
                      defaultBuilder: (context) =>
                          const Center(child: Text('Default Layout')),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Responsive Grid View',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 200,
                    child: ResponsiveGridView(
                      children: List.generate(
                        6,
                        (index) => Card(
                          child: Center(child: Text('Item ${index + 1}')),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Input Components
            const _SectionCard(
              title: 'Input Components',
              child: Column(
                children: [
                  SizedBox(height: 16),
                  AuthInputField(
                    label: 'Email',
                    hint: 'Enter your email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  SizedBox(height: 16),
                  AuthInputField(
                    label: 'Password',
                    hint: 'Enter your password',
                    prefixIcon: Icon(Icons.lock),
                    obscureText: true,
                  ),
                  SizedBox(height: 16),
                  AuthDivider(text: 'OR'),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Container Components
            _SectionCard(
              title: 'Container Components',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  const GlassContainer(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        'Glass Container with blur and transparency effects',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const PageScaffold(
                      title: 'Page Scaffold',
                      content: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text(
                          'This is a page scaffold component for consistent page layouts.',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  String _getMarkdownExample() {
    return '''
# Welcome to Neo-Tidaro

This is a **comprehensive** Flutter workspace showcasing:

- Clean Architecture principles
- Material Design 3 components
- Cross-platform compatibility
- State management with Redux

## Features

> "Building beautiful, functional apps with modern Flutter practices"

### Code Example

```dart
class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text('Hello, World!');
  }
}
```

Visit our [documentation](https://github.com/neo-tidaro) for more details.
''';
  }

  String _getCompactMarkdownExample() {
    return '''
### Quick Start

1. **Clone** the repository
2. **Run** `melos bootstrap`
3. **Launch** your app

> Ready to build amazing apps!
''';
  }

  String _getGeneratedMarkdown() {
    final features = [
      'Markdown Widget',
      'UI Kit Components',
      'State Management',
    ];
    final header = MarkdownUtils.createHeader(
      'Dynamic Content',
      'Generated at runtime:',
      level: 3,
    );
    final list = MarkdownUtils.createList(features, ordered: true);
    final quote = MarkdownUtils.createQuote(
      'Functional and DRY implementation',
    );

    return '$header\n\n$list\n\n$quote';
  }
}

class _SectionCard extends StatelessWidget {

  const _SectionCard({required this.title, required this.child});
  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
