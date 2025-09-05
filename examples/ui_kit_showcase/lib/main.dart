import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

void main() {
  runApp(const UiKitShowcaseApp());
}

class UiKitShowcaseApp extends StatelessWidget {
  const UiKitShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create Redux store
    final Store<AppState> store = createStore(enableLogging: true);

    return StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'UI Kit Showcase',
        localizationsDelegates: Languist.localizationsDelegates,
        supportedLocales: Languist.supportedLocales,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        home: const UiKitDashboard(),
      ),
    );
  }
}

class UiKitDashboard extends StatefulWidget {
  const UiKitDashboard({super.key});

  @override
  State<UiKitDashboard> createState() => _UiKitDashboardState();
}

class _UiKitDashboardState extends State<UiKitDashboard>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Kit Showcase'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.widgets), text: 'Components'),
            Tab(icon: Icon(Icons.palette), text: 'Theming'),
            Tab(icon: Icon(Icons.grid_view), text: 'Layouts'),
            Tab(icon: Icon(Icons.animation), text: 'Interactive'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ComponentsTab(),
          _ThemingTab(),
          _LayoutsTab(),
          _InteractiveTab(),
        ],
      ),
    );
  }
}

class _ComponentsTab extends StatelessWidget {
  const _ComponentsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // UI Kit Components Section
          Text(
            'UI Kit Components',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          // Neomorphic Buttons
          _SectionCard(
            title: 'Neomorphic Buttons',
            child: Column(
              children: [
                const SizedBox(height: 16),
                Wrap(
                  spacing: 12.0,
                  runSpacing: 12.0,
                  children: [
                    NeomorphicButton(
                      onPressed: () =>
                          _showSnackBar(context, 'Primary button pressed'),
                      child: const Text('Primary'),
                    ),
                    NeomorphicButton(
                      onPressed: () =>
                          _showSnackBar(context, 'Secondary button pressed'),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.favorite),
                          SizedBox(width: 8),
                          Text('With Icon'),
                        ],
                      ),
                    ),
                    NeomorphicButton(
                      onPressed: () {},
                      child: const Text('Disabled'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Glassy Cards
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
                          'Basic Glassy Card',
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'This card demonstrates the glassy effect with blur and transparency.',
                          style: Theme.of(context).textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
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

          // Shared Package Components
          _SectionCard(
            title: 'Shared Package Components',
            child: Column(
              children: [
                const SizedBox(height: 16),
                InfoCard(
                  title: 'Information Card',
                  content: const Text(
                    'This InfoCard component comes from the shared package and provides a consistent way to display information.',
                  ),
                  icon: Icons.info_outline,
                ),
                const SizedBox(height: 12),
                const Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text('Loading Indicator'),
                        SizedBox(height: 8),
                        LoadingIndicator(),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ErrorDisplay(
                  failure: const ValidationFailure(
                    'This is a sample error message',
                  ),
                  onRetry: () => _showSnackBar(context, 'Retry pressed'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}

class _ThemingTab extends StatelessWidget {
  const _ThemingTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Theme Showcase',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          // Color Scheme
          _SectionCard(
            title: 'Color Scheme',
            child: Column(
              children: [
                const SizedBox(height: 16),
                _ColorSwatch('Primary', Theme.of(context).colorScheme.primary),
                _ColorSwatch(
                  'Secondary',
                  Theme.of(context).colorScheme.secondary,
                ),
                _ColorSwatch('Surface', Theme.of(context).colorScheme.surface),
                _ColorSwatch('Error', Theme.of(context).colorScheme.error),
                _ColorSwatch('Surface', Theme.of(context).colorScheme.surface),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Typography
          _SectionCard(
            title: 'Typography',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(
                  'Display Large',
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  'Headline Large',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                Text(
                  'Headline Medium',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'Title Large',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                Text(
                  'Body Large',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  'Body Medium',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Label Small',
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _ColorSwatch(String name, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'RGB(${(color.r * 255).round()}, ${(color.g * 255).round()}, ${(color.b * 255).round()})',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LayoutsTab extends StatelessWidget {
  const _LayoutsTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Layout Examples',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          // Grid Layout
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
              itemCount: 6,
              itemBuilder: (context, index) {
                return GlassyCard(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.widgets,
                          size: 32,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(height: 8),
                        Text('Item ${index + 1}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // List Layout
          _SectionCard(
            title: 'List Layout',
            child: Column(
              children: List.generate(5, (index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: Text('${index + 1}'),
                    ),
                    title: Text('List Item ${index + 1}'),
                    subtitle: Text('Subtitle for item ${index + 1}'),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    tileColor: Theme.of(context).colorScheme.surface,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

class _InteractiveTab extends StatefulWidget {
  const _InteractiveTab();

  @override
  State<_InteractiveTab> createState() => _InteractiveTabState();
}

class _InteractiveTabState extends State<_InteractiveTab> {
  bool _switchValue = false;
  double _sliderValue = 50.0;
  String _selectedOption = 'Option 1';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Interactive Components',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),

          // Redux Integration
          StoreConnector<AppState, int>(
            converter: (store) => UiSelectors.getCounter(store.state),
            builder: (context, counter) {
              return _SectionCard(
                title: 'Redux Integration',
                child: Column(
                  children: [
                    const SizedBox(height: 16),
                    Text(
                      'Counter: $counter',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(IncrementCounterAction()),
                          builder: (context, callback) => NeomorphicButton(
                            onPressed: callback,
                            child: const Icon(Icons.add),
                          ),
                        ),
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(DecrementCounterAction()),
                          builder: (context, callback) => NeomorphicButton(
                            onPressed: callback,
                            child: const Icon(Icons.remove),
                          ),
                        ),
                        StoreConnector<AppState, VoidCallback>(
                          converter: (store) =>
                              () => store.dispatch(ResetCounterAction()),
                          builder: (context, callback) => NeomorphicButton(
                            onPressed: callback,
                            child: const Icon(Icons.refresh),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),

          // Form Controls
          _SectionCard(
            title: 'Form Controls',
            child: Column(
              children: [
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const Text('Enable Feature'),
                  value: _switchValue,
                  onChanged: (value) => setState(() => _switchValue = value),
                ),
                const SizedBox(height: 16),
                Text('Slider Value: ${_sliderValue.round()}'),
                Slider(
                  value: _sliderValue,
                  min: 0,
                  max: 100,
                  divisions: 10,
                  onChanged: (value) => setState(() => _sliderValue = value),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  initialValue: _selectedOption,
                  decoration: const InputDecoration(
                    labelText: 'Select Option',
                    border: OutlineInputBorder(),
                  ),
                  items: ['Option 1', 'Option 2', 'Option 3']
                      .map(
                        (option) => DropdownMenuItem(
                          value: option,
                          child: Text(option),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedOption = value!),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Dialogs and Overlays
          _SectionCard(
            title: 'Dialogs & Overlays',
            child: Column(
              children: [
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8.0,
                  children: [
                    ElevatedButton(
                      onPressed: () => _showInfoDialog(context),
                      child: const Text('Show Dialog'),
                    ),
                    ElevatedButton(
                      onPressed: () => _showBottomSheet(context),
                      child: const Text('Bottom Sheet'),
                    ),
                    ElevatedButton(
                      onPressed: () => _showSnackBar(context),
                      child: const Text('SnackBar'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Information'),
        content: const Text(
          'This is a sample dialog from the UI Kit showcase.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Bottom Sheet',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text('This is a modal bottom sheet example.'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('This is a SnackBar message!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
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
