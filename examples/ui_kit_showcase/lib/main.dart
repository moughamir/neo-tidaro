import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:shared/shared.dart';

void main() {
  runApp(const UiKitShowcaseApp());
}

class UiKitShowcaseApp extends StatelessWidget {
  const UiKitShowcaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UI Kit Showcase',
      localizationsDelegates: Languist.localizationsDelegates,
      supportedLocales: Languist.supportedLocales,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: const UiKitShowcasePage(),
    );
  }
}

class UiKitShowcasePage extends StatefulWidget {
  const UiKitShowcasePage({super.key});

  @override
  State<UiKitShowcasePage> createState() => _UiKitShowcasePageState();
}

class _UiKitShowcasePageState extends State<UiKitShowcasePage> {
  bool _isLoading = false;
  bool _showError = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('UI Kit Components Showcase'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Buttons Section
            _buildSection(
              'Buttons',
              [
                // Standard Material Buttons
                ElevatedButton(
                  onPressed: () => _showSnackBar('Primary button pressed!'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Primary Button'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: null,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Disabled Button'),
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  onPressed: () => _showSnackBar('Outlined button pressed!'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Outlined Button'),
                ),
                const SizedBox(height: 12),
                TextButton(
                  onPressed: () => _showSnackBar('Text button pressed!'),
                  style: TextButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  child: const Text('Text Button'),
                ),
                const SizedBox(height: 12),
                // Neumorphic Button from UI Kit
                NeomorphicButton(
                  onPressed: () => _showSnackBar('Neumorphic button pressed!'),
                  tooltip: 'Neumorphic Style',
                  child: const Text(
                    'Neumorphic Button',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 12),
                // Note: NeomorphicButton doesn't support disabled state in current implementation
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.0),
                    color: Colors.grey.shade300,
                  ),
                  child: const Text(
                    'Disabled Neumorphic (Demo)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),

            // Cards Section
            _buildSection(
              'Cards & Containers',
              [
                GlassyCard(
                  title: 'Basic Glassy Card',
                  subtitle: 'This is a subtitle',
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('This is the content inside a glassy card with glass morphism effect.'),
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => _showSnackBar('Glassy card tapped!'),
                  child: GlassyCard(
                    title: 'Interactive Glassy Card',
                    subtitle: 'Tap me!',
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Icon(Icons.touch_app, size: 48),
                          SizedBox(height: 8),
                          Text('This card is interactive'),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InfoCard(
                  title: 'Information Card',
                  content: const Text('This is an info card that displays important information to users.'),
                  icon: Icons.info_outline,
                ),
                const SizedBox(height: 16),
                InfoCard(
                  title: 'Warning Card',
                  content: const Text('This is a warning message that alerts users about potential issues.'),
                  icon: Icons.warning_amber,
                  backgroundColor: Colors.orange.shade50,
                ),
              ],
            ),

            // Indicators Section
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Grid Layout Demo',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 2.0,
                      ),
                      itemCount: 6,
                      itemBuilder: (context, index) => Card(
                        color: Colors.primaries[index % Colors.primaries.length].shade100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              'Item ${index + 1}',
                              style: const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Indicators Section
            _buildSection(
              'Indicators',
              [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text('Loading Indicator'),
                        const SizedBox(height: 16),
                        if (_isLoading) const LoadingIndicator(),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isLoading = !_isLoading;
                            });
                          },
                          child: Text(_isLoading ? 'Stop Loading' : 'Start Loading'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text('Error Display'),
                        const SizedBox(height: 16),
                        if (_showError)
                          ErrorDisplay(
                            failure: Failure.validation('This is an example error message that demonstrates how errors are displayed.'),
                          ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _showError = !_showError;
                            });
                          },
                          child: Text(_showError ? 'Hide Error' : 'Show Error'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // Layout Section
            _buildSection(
              'Layout Components',
              [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'PageScaffold Demo',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        const Text('PageScaffold provides consistent page layout with:'),
                        const SizedBox(height: 8),
                        const Text('• Standardized app bar'),
                        const Text('• Neumorphic theming'),
                        const Text('• Content padding'),
                        const Text('• Optional drawer support'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => PageScaffold(
                                  title: 'PageScaffold Example',
                                  content: const Center(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text('This is content inside a PageScaffold'),
                                        SizedBox(height: 16),
                                        Text('It provides consistent layout structure'),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const Text('Open PageScaffold Demo'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Responsive Layout Demo',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Current screen width: ${MediaQuery.of(context).size.width.toInt()}px'),
                        const SizedBox(height: 8),
                        Builder(
                          builder: (context) {
                            final width = MediaQuery.of(context).size.width;
                            if (width < 600) {
                              return Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(child: Text('Mobile Layout (<600px)')),
                              );
                            } else if (width < 1200) {
                              return Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.green.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(child: Text('Tablet Layout (600-1200px)')),
                              );
                            } else {
                              return Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  color: Colors.purple.shade100,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Center(child: Text('Desktop Layout (>1200px)')),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),


            // Dialogs Section
            _buildSection(
              'Dialogs & Modals',
              [
                ElevatedButton(
                  onPressed: () => _showInfoDialog(),
                  child: const Text('Show Info Dialog'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _showConfirmDialog(),
                  child: const Text('Show Confirm Dialog'),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _showCustomDialog(),
                  child: const Text('Show Custom Dialog'),
                ),
              ],
            ),

            // Theme Showcase
            _buildSection(
              'Theme & Colors',
              [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Color Palette',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            _buildColorSwatch('Primary', Theme.of(context).colorScheme.primary),
                            _buildColorSwatch('Secondary', Theme.of(context).colorScheme.secondary),
                            _buildColorSwatch('Surface', Theme.of(context).colorScheme.surface),
                            _buildColorSwatch('Error', Theme.of(context).colorScheme.error),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ...children,
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildColorSwatch(String name, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey.shade300),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          name,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Information'),
        content: const Text('This is an informational dialog using standard Material components.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to proceed with this action?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _showSnackBar('Action confirmed!');
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  void _showCustomDialog() {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                size: 48,
                color: Colors.amber,
              ),
              const SizedBox(height: 16),
              const Text(
                'Custom Dialog',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'This dialog demonstrates custom styling with icons and rounded corners.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text('Close'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
