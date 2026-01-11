---
title: 04-packages-overview
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# Packages Overview

This document provides detailed information about each package in the Neo-Tidaro workspace.

## Core Package (`packages/core`)

### Purpose

Provides foundational utilities, services, and abstractions used across the entire workspace.

### Key Components

- **Network Layer**: HTTP clients and API interfaces
- **Storage Layer**: Local storage abstractions
- **Platform Services**: Platform-specific implementations
- **Utilities**: Common helper functions and extensions

### Usage Example

```dart
import 'package:core/core.dart';

// Network service
final apiClient = ApiClient(baseUrl: 'https://api.example.com');
final response = await apiClient.get('/users');

// Storage service
final storage = LocalStorage();
await storage.setString('user_token', token);
```

### Dependencies

- `flutter`
- `http`
- `shared_preferences`
- `path_provider`

---

## Languist Package (`packages/languist`)

### Purpose

Handles internationalization (i18n) and localization (l10n) for the entire workspace.

### Key Features

- Multi-language support (French, Arabic, Tifinagh)
- Dynamic language switching
- Parameterized translations
- ARB file management

### Configuration

```yaml
# languist.yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
output-class: AppLocalizations
```

### Usage Example

```dart
import 'package:languist/languist.dart';

// In MaterialApp
MaterialApp(
  localizationsDelegates: Languist.localizationsDelegates,
  supportedLocales: Languist.supportedLocales,
  // ...
)

// In widgets
Text(Languist.of(context).helloUser('John'))
```

### Supported Languages

- English (en)
- French (fr)
- Arabic (ar)
- Tifinagh (tzm)

---

## Shared Package (`packages/shared`)

### Purpose

Contains shared business logic, state management, and common widgets used across applications.

### Key Components

#### State Management (Redux)

```dart
// Store creation
final store = createStore<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [loggingMiddleware],
);

// Actions
class IncrementCounterAction {}
class LoginStartAction {}
class LoginSuccessAction {
  final Map<String, dynamic> user;
  LoginSuccessAction(this.user);
}

// Reducers
AppState appReducer(AppState state, dynamic action) {
  return AppState(
    authState: authReducer(state.authState, action),
    uiState: uiReducer(state.uiState, action),
  );
}

// Selectors
class UiSelectors {
  static int getCounter(AppState state) => state.uiState.counter;
  static bool isLoading(AppState state) => state.uiState.isLoading;
}
```

#### Domain Entities

```dart
abstract class Entity extends Equatable {
  final String id;
  const Entity({required this.id});

  @override
  List<Object?> get props => [id];
}

class User extends Entity {
  final String name;
  final String email;

  const User({
    required super.id,
    required this.name,
    required this.email,
  });
}
```

#### Common Widgets

- `InfoCard`: Information display card
- `ErrorDisplay`: Error state widget
- `LoadingIndicator`: Loading state widget
- `GenericDialog`: Reusable dialog component

### Dependencies

- `flutter`
- `redux`
- `flutter_redux`
- `equatable`

---

## UI Kit Package (`packages/ui_kit`)

### Purpose

Provides custom UI components, theming, and design system implementation.

### Key Components

#### Custom Widgets

```dart
// Neomorphic Button
NeomorphicButton(
  onPressed: () => print('Pressed'),
  child: Text('Click Me'),
)

// Glassy Card
KuiCard.glass(
  child: Padding(
    padding: EdgeInsets.all(16),
    child: Text('Content'),
  ),
)
```

#### Theming

```dart
class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    textTheme: _buildTextTheme(_lightColorScheme),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    textTheme: _buildTextTheme(_darkColorScheme),
  );
}
```

#### Color Scheme

- **Primary**: `#1C2C4C` (Deep blue)
- **Secondary**: `#3AAFA9` (Teal)
- **Surface**: `#F9FAFB` (Light gray)
- **Error**: `#E53E3E` (Red)

#### Typography

- **Base Font**: Noto Sans
- **Arabic Font**: Noto Sans Arabic
- **Tifinagh Font**: Noto Sans Tifinagh

### Dependencies

- `flutter`
- `google_fonts`
- `material_color_utilities`

---

## Package Integration

### Dependency Flow

```
Apps/Examples
    ↓
Shared Package ← UI Kit Package
    ↓              ↓
Core Package ← Languist Package
```

### Import Structure

```dart
// In applications
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';
import 'package:languist/languist.dart';

// Shared package imports core
import 'package:core/core.dart';

// UI Kit can import core and languist
import 'package:core/core.dart';
import 'package:languist/languist.dart';
```

### Version Management

All packages follow semantic versioning and are managed together using Melos:

```bash
# Update all package versions
melos version

# Publish all packages
melos publish
```

## Testing Strategy

### Package-Level Testing

Each package includes:

- Unit tests for business logic
- Widget tests for UI components
- Integration tests for complex flows

### Cross-Package Testing

- Integration tests verify package interactions
- End-to-end tests validate complete workflows
- Performance tests ensure optimal behavior

## Best Practices

### Package Design

- Keep packages focused and cohesive
- Minimize cross-package dependencies
- Use dependency injection for flexibility
- Implement proper error handling

### API Design

- Use consistent naming conventions
- Provide comprehensive documentation
- Include usage examples
- Support customization options

### Performance

- Lazy load heavy dependencies
- Use const constructors where possible
- Implement proper caching strategies
- Monitor memory usage