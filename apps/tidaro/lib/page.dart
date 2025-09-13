import 'package:ui_kit/ui_kit.dart';

class DarPage extends StatefulWidget {
  const DarPage({super.key});

  @override
  State<DarPage> createState() => _DarPageState();
}

class _DarPageState extends State<DarPage> {
  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'TiDaro Lab',
      content: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // UI Kit Components Showcase
            Text(
              'TiDaro Main App',
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            const SizedBox(height: 20),

            // Glassy Card Example
            KuiCard.glass(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text(
                      'Welcome to TiDaro',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'TiDaro application showcasing UI Kit components',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Counter section
            const KuiCard(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Text('Hello, Flutter Developer!'),
                    SizedBox(height: 20),

                    SizedBox(height: 20),
                    Text('Counter Example'),
                    Text('Just now'),
                    Text('A minute ago'),
                    Text('An hour ago'),
                    Text('A day ago'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
