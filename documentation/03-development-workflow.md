---
title: 03-development-workflow
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# Development Workflow

This document outlines the development workflow and best practices for the Neo-Tidaro workspace.

## Getting Started

### Prerequisites
- Flutter SDK (>=3.35.0)
- Dart SDK (>=3.9.0)
- Melos CLI (`dart pub global activate melos`)
- Git Flow (recommended)

### Initial Setup
```bash
# Clone the repository
git clone https://github.com/moughamir/neo-tidaro.git
cd neo-tidaro

# Bootstrap the workspace
melos bootstrap

# Verify setup
melos run analyze
melos run test
```

## Development Process

### 1. Feature Development
```bash
# Create feature branch
git checkout -b feature/new-feature

# Make changes to packages/apps
# Test your changes
melos run test --scope=package_name

# Analyze code
melos run analyze --scope=package_name

# Commit changes
git add .
git commit -m "feat(scope): add new feature"
```

### 2. Testing Strategy
```bash
# Run all tests
melos run test

# Run tests for specific package
melos run test --scope=ui_kit

# Run tests with coverage
melos run test:coverage

# Widget testing
flutter test test/widget_test.dart

# Integration testing
flutter test integration_test/
```

### 3. Code Quality
```bash
# Static analysis
melos run analyze

# Format code
melos run format

# Check for unused dependencies
melos run deps:check

# Update dependencies
melos run deps:update
```

## Package Development

### Creating New Packages
```bash
# Create package structure
mkdir packages/new_package
cd packages/new_package

# Initialize package
flutter create --template=package .

# Add to melos.yaml
# Update dependencies in pubspec.yaml
```

### Package Dependencies
```yaml
# pubspec.yaml
dependencies:
  flutter:
    sdk: flutter
  core:
    path: ../core
  shared:
    path: ../shared

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.0
```

### Publishing Packages
```bash
# Dry run
melos publish --dry-run

# Publish to pub.dev
melos publish
```

## Application Development

### Running Applications
```bash
# Run main app
melos run flutter:run:tidaro

# Run with specific device
melos run flutter:run:tidaro -- -d linux

# Run in debug mode
flutter run -d linux --debug

# Run in release mode
flutter run -d linux --release
```

### Building Applications
```bash
# Build all apps
melos run build

# Build specific app
cd apps/tidaro
flutter build linux

# Build for different platforms
flutter build apk
flutter build web
flutter build windows
```

## State Management Workflow

### Redux Pattern
```dart
// 1. Define Actions
class IncrementCounterAction {}

// 2. Create Reducers
int counterReducer(int state, dynamic action) {
  switch (action.runtimeType) {
    case IncrementCounterAction:
      return state + 1;
    default:
      return state;
  }
}

// 3. Use in Widgets
StoreConnector<AppState, int>(
  converter: (store) => store.state.counter,
  builder: (context, counter) => Text('$counter'),
)
```

### State Structure
```dart
class AppState {
  final AuthState authState;
  final UiState uiState;
  final DataState dataState;

  const AppState({
    required this.authState,
    required this.uiState,
    required this.dataState,
  });
}
```

## Localization Workflow

### Adding New Languages
```bash
# Generate ARB template
flutter gen-l10n

# Add translations to ARB files
# packages/languist/lib/l10n/app_*.arb

# Regenerate localization files
melos run gen:l10n
```

### Using Translations
```dart
// In widgets
Text(AppLocalizations.of(context).helloUser('John'))

// With parameters
Text(AppLocalizations.of(context).minutesAgo(5))
```

## UI Development

### Component Development
```dart
class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.variant = ButtonVariant.primary,
  });

  final VoidCallback onPressed;
  final Widget child;
  final ButtonVariant variant;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: _getButtonStyle(context, variant),
      child: child,
    );
  }
}
```

### Theme Development
```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    textTheme: _buildTextTheme(_lightColorScheme),
  );

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1C2C4C),
    // ... other colors
  );
}
```

## Testing Workflow

### Unit Testing
```dart
group('Calculator Tests', () {
  late Calculator calculator;

  setUp(() {
    calculator = Calculator();
  });

  test('should add numbers correctly', () {
    expect(calculator.add(2, 3), equals(5));
  });
});
```

### Widget Testing
```dart
testWidgets('Counter increments', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp());
  
  expect(find.text('0'), findsOneWidget);
  
  await tester.tap(find.byIcon(Icons.add));
  await tester.pump();
  
  expect(find.text('1'), findsOneWidget);
});
```

### Integration Testing
```dart
void main() {
  group('App Integration Tests', () {
    testWidgets('complete user flow', (tester) async {
      await tester.pumpWidget(MyApp());
      
      // Test complete user journey
      await tester.tap(find.text('Login'));
      await tester.pumpAndSettle();
      
      expect(find.text('Welcome'), findsOneWidget);
    });
  });
}
```

## Deployment Workflow

### Staging Deployment
```bash
# Build for staging
flutter build web --dart-define=ENV=staging

# Deploy to staging server
# (deployment scripts)
```

### Production Deployment
```bash
# Create release branch
git checkout -b release/v1.0.0

# Update version numbers
melos version

# Build for production
flutter build web --dart-define=ENV=production

# Tag release
git tag v1.0.0

# Deploy to production
# (deployment scripts)
```

## Troubleshooting

### Common Issues

#### Dependency Conflicts
```bash
# Clean and reinstall
melos clean
melos bootstrap
```

#### Build Issues
```bash
# Clean build cache
flutter clean
flutter pub get
```

#### State Management Issues
- Check Redux DevTools
- Verify action dispatching
- Ensure proper state updates

#### Localization Issues
```bash
# Regenerate l10n files
flutter gen-l10n
```

### Debug Tools
- Flutter Inspector
- Redux DevTools
- Performance Overlay
- Memory Profiler