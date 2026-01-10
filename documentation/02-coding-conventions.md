---
created_date: 07/09/2025
updated_date: 20/11/2025
---
# Neo-Tidaro Coding Conventions

This document outlines the coding standards and conventions used across the Neo-Tidaro workspace.

## General Principles

### Code Organization
- Follow Clean Architecture principles (DRY, SOLID, KISS, YAGNI)
- Use feature-based folder structure
- Separate concerns between layers (presentation, domain, data)
- Keep files focused and cohesive

### Naming Conventions
- **Files**: Use snake_case for file names
- **Classes**: Use PascalCase for class names
- **Variables/Functions**: Use camelCase
- **Constants**: Use SCREAMING_SNAKE_CASE
- **Private members**: Prefix with underscore (_)

## Flutter/Dart Conventions

### Widget Structure
```dart
class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.title,
    this.subtitle,
  });

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Widget implementation
    );
  }
}
```

### State Management (Redux)
```dart
// Actions
class IncrementCounterAction {}

// Reducers
int counterReducer(int state, dynamic action) {
  if (action is IncrementCounterAction) {
    return state + 1;
  }
  return state;
}

// Selectors
class UiSelectors {
  static int getCounter(AppState state) => state.uiState.counter;
}
```

### Error Handling
```dart
try {
  final result = await apiCall();
  return Success(result);
} catch (e) {
  return Failure(e.toString());
}
```

## Package-Specific Conventions

### UI Kit Package
- Use Material 3 design principles
- Support multiple themes (light/dark)
- Include accessibility features
- Document component usage with examples

### Shared Package
- Keep domain logic pure (no Flutter dependencies)
- Use immutable data structures
- Implement proper equality comparisons
- Follow repository pattern for data access

### Core Package
- Abstract platform-specific implementations
- Use dependency injection
- Implement proper error handling
- Include comprehensive logging

### Languist Package
- Use ARB files for translations
- Support parameterized strings
- Include context for translators
- Test all language variants

## Documentation Standards

### Code Comments
```dart
/// Calculates the total price including tax.
/// 
/// [basePrice] The price before tax
/// [taxRate] The tax rate as a decimal (e.g., 0.08 for 8%)
/// 
/// Returns the total price including tax.
/// Throws [ArgumentError] if [basePrice] is negative.
double calculateTotalPrice(double basePrice, double taxRate) {
  if (basePrice < 0) {
    throw ArgumentError('Base price cannot be negative');
  }
  return basePrice * (1 + taxRate);
}
```

### README Structure
Each package should include:
- Purpose and overview
- Installation instructions
- Usage examples
- API documentation
- Contributing guidelines

## Testing Conventions

### Unit Tests
```dart
group('Calculator', () {
  test('should add two numbers correctly', () {
    // Arrange
    final calculator = Calculator();
    
    // Act
    final result = calculator.add(2, 3);
    
    // Assert
    expect(result, equals(5));
  });
});
```

### Widget Tests
```dart
testWidgets('MyWidget displays title', (WidgetTester tester) async {
  await tester.pumpWidget(
    MaterialApp(
      home: MyWidget(title: 'Test Title'),
    ),
  );

  expect(find.text('Test Title'), findsOneWidget);
});
```

## Git Conventions

### Commit Messages
Follow conventional commits format:
```
type(scope): description

feat(auth): add login functionality
fix(ui): resolve button alignment issue
docs(readme): update installation instructions
test(core): add unit tests for calculator
```

### Branch Naming
- `feature/feature-name` - New features
- `fix/bug-description` - Bug fixes
- `docs/documentation-update` - Documentation changes
- `refactor/code-improvement` - Code refactoring

## Performance Guidelines

### Flutter Performance
- Use `const` constructors when possible
- Implement proper `build` method optimization
- Use `ListView.builder` for large lists
- Minimize widget rebuilds with proper state management

### Memory Management
- Dispose controllers and streams properly
- Use weak references where appropriate
- Monitor memory usage in development
- Implement proper caching strategies

## Accessibility

### Widget Accessibility
```dart
Semantics(
  label: 'Increment counter',
  hint: 'Double tap to increase the counter value',
  child: FloatingActionButton(
    onPressed: _incrementCounter,
    child: Icon(Icons.add),
  ),
)
```

### Color Contrast
- Ensure WCAG AA compliance
- Test with different color schemes
- Provide alternative text for images
- Support screen readers

## Localization Best Practices

### ARB Files
```json
{
  "@@locale": "en",
  "helloUser": "Hello {name}!",
  "@helloUser": {
    "description": "Greeting message for user",
    "placeholders": {
      "name": {
        "type": "String",
        "example": "John"
      }
    }
  }
}
```

### Usage in Code
```dart
Text(AppLocalizations.of(context).helloUser('John'))
```
