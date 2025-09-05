# Troubleshooting Guide

This document provides solutions to common issues encountered when working with the Neo-Tidaro workspace.

## 🚨 Common Issues

### Build and Compilation Errors

#### Package Resolution Issues
```bash
# Error: Package not found or version conflicts
# Solution: Clean and rebuild workspace
melos clean
melos bootstrap
flutter clean
flutter pub get
```

#### Import Errors
```dart
// Error: 'package:shared/shared.dart' not found
// Check: Verify package dependencies in pubspec.yaml
dependencies:
  shared:
    path: ../../packages/shared
```

#### Missing Generated Files
```bash
# Error: Localization files not found
# Solution: Generate localization files
melos run gen:l10n

# Error: Build runner files missing
# Solution: Run build runner
melos run build_runner
```

### State Management Issues

#### Redux Store Not Available
```dart
// Error: Could not find the correct Provider<Store<AppState>>
// Solution: Ensure StoreProvider wraps MaterialApp
StoreProvider<AppState>(
  store: store,
  child: MaterialApp(...),
)
```

#### Actions Not Dispatching
```dart
// Error: Actions dispatched but state not updating
// Check: Verify reducer handles the action
AppState appReducer(AppState state, dynamic action) {
  switch (action.runtimeType) {
    case IncrementCounterAction:
      return state.copyWith(
        uiState: state.uiState.copyWith(
          counter: state.uiState.counter + 1,
        ),
      );
    default:
      return state;
  }
}
```

### Localization Issues

#### Missing Translations
```bash
# Error: No translation found for key
# Solution: Check ARB files in packages/languist/lib/l10n/
# Ensure all keys exist in app_en.arb and other language files
```

#### Localization Not Loading
```dart
// Error: Languist.of(context) returns null
// Check: MaterialApp configuration
MaterialApp(
  localizationsDelegates: Languist.localizationsDelegates,
  supportedLocales: Languist.supportedLocales,
  // ...
)
```

### UI Kit Component Issues

#### Component API Errors
```dart
// Error: The named parameter 'title' isn't defined
// Solution: Check component documentation
// GlassyCard no longer accepts title/subtitle parameters
GlassyCard(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Column(
      children: [
        Text('Title'), // Add title as child widget
        Text('Content'),
      ],
    ),
  ),
)
```

#### Theme Not Applied
```dart
// Error: Custom theme not working
// Check: Theme configuration in MaterialApp
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  // ...
)
```

## 🔧 Development Environment Issues

### Flutter SDK Issues
```bash
# Check Flutter installation
flutter doctor

# Update Flutter
flutter upgrade

# Check channel
flutter channel stable
```

### Melos Issues
```bash
# Install Melos globally
dart pub global activate melos

# Verify Melos installation
melos --version

# Bootstrap workspace
melos bootstrap
```

### IDE Configuration

#### VS Code Setup
```json
// .vscode/settings.json
{
  "dart.flutterSdkPath": "/path/to/flutter",
  "dart.enableSdkFormatter": true,
  "dart.lineLength": 120,
  "dart.showTodos": true
}
```

#### Android Studio Setup
- Enable Dart and Flutter plugins
- Configure Flutter SDK path
- Set up device emulators

## 🐛 Debugging Strategies

### Debug Mode
```bash
# Run in debug mode with verbose output
flutter run -d linux --verbose

# Enable Redux logging
final store = createStore(enableLogging: true);
```

### Logging
```dart
// Add debug prints
import 'dart:developer' as developer;

developer.log('Debug message', name: 'MyApp');

// Use Flutter inspector
import 'package:flutter/foundation.dart';

if (kDebugMode) {
  print('Debug information');
}
```

### Performance Issues
```bash
# Profile mode
flutter run --profile

# Performance overlay
flutter run --enable-software-rendering
```

## 📱 Platform-Specific Issues

### Linux Desktop
```bash
# Enable Linux desktop support
flutter config --enable-linux-desktop

# Install dependencies
sudo apt-get install clang cmake ninja-build pkg-config libgtk-3-dev
```

### Web Platform
```bash
# Enable web support
flutter config --enable-web

# Run on web
flutter run -d chrome
```

### Mobile Platforms
```bash
# Android setup
flutter doctor --android-licenses

# iOS setup (macOS only)
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```

## 🔍 Testing Issues

### Widget Tests
```dart
// Error: Widget not found in test
// Solution: Use proper finders and pump widgets
testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();
  expect(find.text('1'), findsOneWidget);
});
```

### Integration Tests
```bash
# Run integration tests
flutter test integration_test/

# Run on specific device
flutter test integration_test/ -d linux
```

## 🚀 Performance Optimization

### Build Optimization
```bash
# Release build
flutter build linux --release

# Analyze bundle size
flutter build linux --analyze-size
```

### Memory Issues
```dart
// Dispose controllers properly
@override
void dispose() {
  _controller.dispose();
  super.dispose();
}

// Use const constructors
const MyWidget({super.key});
```

## 📊 Monitoring and Analytics

### Error Tracking
```dart
// Add error handling
try {
  // Risky operation
} catch (e, stackTrace) {
  developer.log('Error occurred', error: e, stackTrace: stackTrace);
}
```

### Performance Monitoring
```dart
// Use Timeline for performance tracking
import 'dart:developer';

Timeline.startSync('expensive_operation');
// Expensive operation
Timeline.finishSync();
```

## 🔄 Git and Version Control Issues

### Merge Conflicts
```bash
# Check status
git status

# Resolve conflicts manually or use tools
git mergetool

# After resolution
git add .
git commit -m "Resolve merge conflicts"
```

### Branch Management
```bash
# Create feature branch
git checkout -b feature/new-feature

# Push branch
git push -u origin feature/new-feature

# Clean up merged branches
git branch -d feature/completed-feature
```

### Workspace Sync Issues
```bash
# Sync with remote
git fetch origin
git pull origin main

# Reset to clean state (use with caution)
git reset --hard origin/main
```

## 📞 Getting Help

### Documentation Resources
- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Language Tour](https://dart.dev/guides/language/language-tour)
- [Material Design](https://material.io/design)

### Community Support
- [Flutter Community](https://flutter.dev/community)
- [Stack Overflow](https://stackoverflow.com/questions/tagged/flutter)
- [GitHub Issues](https://github.com/flutter/flutter/issues)

### Workspace-Specific Help
1. Check package README files
2. Review example applications
3. Examine test files for usage patterns
4. Use IDE debugging tools

## 🛠️ Advanced Troubleshooting

### Custom Debugging Tools
```dart
// Create debug overlay
class DebugOverlay extends StatelessWidget {
  final Widget child;
  
  const DebugOverlay({required this.child, super.key});
  
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (kDebugMode)
          Positioned(
            top: 50,
            right: 10,
            child: Container(
              padding: EdgeInsets.all(8),
              color: Colors.black54,
              child: Text(
                'DEBUG MODE',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
      ],
    );
  }
}
```

### Performance Profiling
```bash
# Profile app performance
flutter run --profile --trace-startup

# Analyze performance
flutter analyze --suggestions
```

### Memory Leak Detection
```dart
// Use memory profiler
import 'package:flutter/services.dart';

class MemoryTracker {
  static void logMemoryUsage() {
    SystemChannels.platform.invokeMethod('SystemChrome.getMemoryUsage')
        .then((usage) => print('Memory usage: $usage'));
  }
}
```

Remember: When in doubt, start with `melos clean && melos bootstrap` to reset the workspace to a clean state.
