import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:shared/shared.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: UiKitDashboard(
        onThemeToggle: _toggleTheme,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class UiKitDashboard extends StatefulWidget {
  final VoidCallback onThemeToggle;
  final bool isDarkMode;

  const UiKitDashboard({
    super.key,
    required this.onThemeToggle,
    required this.isDarkMode,
  });

  @override
  State<UiKitDashboard> createState() => _UiKitDashboardState();
}

class _UiKitDashboardState extends State<UiKitDashboard> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter--;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

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
                  GlassyCard(
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
                          Text('Counter: $_counter'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  GlassyCard(
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

            // Counter Section
            _SectionCard(
              title: 'Interactive Counter',
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Counter: $_counter',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _incrementCounter,
                        child: const Icon(Icons.add),
                      ),
                      ElevatedButton(
                        onPressed: _decrementCounter,
                        child: const Icon(Icons.remove),
                      ),
                      ElevatedButton(
                        onPressed: _resetCounter,
                        child: const Icon(Icons.refresh),
                      ),
                    ],
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
                  final labels = [
                    'Components',
                    'Themes',
                    'Code',
                    'Design',
                  ];
                  
                  return GlassyCard(
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
            const SizedBox(height: 12),

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
                                config: MarkdownConfig.darkConfig(context).copyWith(
                                  shrinkWrap: false,
                                  padding: const EdgeInsets.all(8),
                                ),
                              )
                            : MarkdownWidget(
                                data: _getMarkdownExample(),
                                config: MarkdownConfig.defaultConfig(context).copyWith(
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
                              ? MarkdownConfig.darkConfig(context).copyWith(
                                  shrinkWrap: false,
                                  padding: const EdgeInsets.all(8),
                                )
                              : MarkdownConfig.compactConfig(context).copyWith(
                                  shrinkWrap: false,
                                ),
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
                              '**Counter Value:** `$_counter`\n\n*Updated dynamically with state changes*',
                          config: widget.isDarkMode
                              ? MarkdownConfig.darkConfig(context).copyWith(
                                  shrinkWrap: false,
                                  padding: const EdgeInsets.all(8),
                                )
                              : MarkdownConfig.compactConfig(context).copyWith(
                                  shrinkWrap: false,
                                ),
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
                              ? MarkdownConfig.darkConfig(context).copyWith(
                                  shrinkWrap: false,
                                  padding: const EdgeInsets.all(8),
                                )
                              : MarkdownConfig.compactConfig(context).copyWith(
                                  shrinkWrap: false,
                                ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

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
