# Neo-Tidaro Examples

This directory contains comprehensive examples demonstrating how to use the Neo-Tidaro workspace packages effectively.

## 🚀 Quick Start

```bash
# Bootstrap the workspace
melos bootstrap

# Run an example
cd examples/basic_app
flutter run -d linux
```

## 📱 Available Examples

### 1. Basic App (`examples/basic_app`)

**Purpose**: Demonstrates basic workspace integration and package usage.

**Features**:

- Simple UI Kit component usage
- Basic Redux state management
- Localization integration
- Clean architecture patterns

**Run**: `flutter run -d linux` from `examples/basic_app/`

### 2. Authentication Flow (`examples/auth_flow`)

**Purpose**: Complete authentication system with form validation and state management.

**Features**:

- Login/logout functionality
- Form validation and error handling
- Loading states and user feedback
- Redux state management integration
- Demo authentication flow

**Key Components**:

- Login form with validation
- Authenticated user dashboard
- Error handling and recovery
- State persistence

**Run**: `flutter run -d linux` from `examples/auth_flow/`

### 3. Redux Showcase (`examples/redux_showcase`)

**Purpose**: Comprehensive Redux state management patterns and best practices.

**Features**:

- Complete store setup (actions, reducers, selectors)
- Counter functionality with increment/decrement
- Loading states and async operations
- Error handling patterns
- Middleware integration examples

**Key Concepts**:

- Action creators and types
- Reducer composition
- Selector patterns
- Middleware usage
- State normalization

**Run**: `flutter run -d linux` from `examples/redux_showcase/`

### 4. UI Kit Showcase (`examples/ui_kit_showcase`)

**Purpose**: Interactive demonstration of all available UI components.

**Features**:

- All UI Kit components (NeomorphicButton, KuiCard.glass)
- Shared package widgets (InfoCard, ErrorDisplay, LoadingIndicator)
- Material Design variations
- Interactive component gallery
- Theme demonstrations
- Responsive layouts

**Components Showcased**:

- Custom buttons with different styles
- Cards and containers
- Loading and error states
- Dialogs and overlays
- Grid layouts and lists

**Run**: `flutter run -d linux` from `examples/ui_kit_showcase/`

## 🏗️ Architecture Overview

### Package Integration

All examples demonstrate proper integration of workspace packages:

```dart
// Typical imports in examples
import 'package:flutter/material.dart';
import 'package:languist/languist.dart';  // Localization
import 'package:shared/shared.dart';      // State management & widgets
import 'package:ui_kit/ui_kit.dart';      // Custom UI components
```

### State Management Pattern

Examples use Redux for predictable state management:

```dart
// Store setup
final store = createStore<AppState>(
  appReducer,
  initialState: AppState.initial(),
  middleware: [loggingMiddleware],
);

// Usage in widgets
StoreConnector<AppState, AuthState>(
  converter: (store) => store.state.authState,
  builder: (context, authState) => AuthWidget(authState),
)
```

### Localization Integration

All examples support multiple languages:

```dart
MaterialApp(
  localizationsDelegates: Languist.localizationsDelegates,
  supportedLocales: Languist.supportedLocales,
  // ...
)
```

## 📚 Learning Path

### Beginner → `basic_app`

Start here to understand:

- Workspace package structure
- Basic component usage
- Simple state management
- Localization basics

### Intermediate → `auth_flow`

Learn about:

- Form handling and validation
- Complex state management
- Error handling patterns
- User experience flows

### Advanced → `redux_showcase`

Master:

- Advanced Redux patterns
- Middleware implementation
- State normalization
- Performance optimization

### Expert → `ui_kit_showcase`

Explore:

- Custom component development
- Advanced theming
- Responsive design
- Component composition

## 🛠️ Development Setup

### Prerequisites

- Flutter SDK (>=3.35.0)
- Dart SDK (>=3.9.0)
- Linux desktop support enabled

### Installation

```bash
# Clone and setup workspace
git clone https://github.com/moughamir/neo-tidaro.git
cd neo-tidaro
melos bootstrap

# Verify setup
melos run analyze
melos run test
```

### Running Examples

```bash
# Method 1: Direct Flutter command
cd examples/[example_name]
flutter run -d linux

# Method 2: Using Melos (if configured)
melos run flutter:run:[example_name]
```

## 🧪 Testing Examples

### Run All Tests

```bash
# Test all examples
melos run test --scope="*example*"

# Test specific example
cd examples/basic_app
flutter test
```

### Widget Testing

Each example includes widget tests demonstrating:

- Component rendering
- User interaction testing
- State change verification
- Error condition handling

### Integration Testing

Examples include integration tests for:

- Complete user flows
- Cross-component interactions
- State persistence
- Navigation patterns

## 🎨 Customization Guide

### Theming

Customize the appearance by modifying theme configurations:

```dart
// In your app
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  // ...
)
```

### Adding New Components

1. Create component in `packages/ui_kit/lib/src/widgets/`
2. Export in `packages/ui_kit/lib/ui_kit.dart`
3. Add example usage in `ui_kit_showcase`
4. Include tests and documentation

### State Management Extensions

1. Define new actions in `packages/shared/lib/redux/actions/`
2. Add reducers in `packages/shared/lib/redux/reducers/`
3. Create selectors in `packages/shared/lib/redux/selectors/`
4. Demonstrate usage in examples

## 🔧 Troubleshooting

### Common Issues

#### Build Errors

```bash
# Clean and rebuild
flutter clean
flutter pub get
melos bootstrap
```

#### Package Resolution Issues

```bash
# Reset workspace
melos clean
melos bootstrap
```

#### Hot Reload Issues

- Restart the app completely
- Check for syntax errors
- Verify import statements

### Getting Help

- Check the documentation in `/documentation/`
- Review package README files
- Examine working examples
- Run `flutter doctor` for environment issues

## 🚀 Next Steps

After exploring the examples:

1. **Build Your Own App**: Use the patterns learned to create your application
2. **Contribute**: Add new examples or improve existing ones
3. **Extend Packages**: Add new components or features to workspace packages
4. **Share**: Document your learnings and share with the community

## 📖 Additional Resources

- [Workspace Structure](../documentation/01-workspace-structure.md)
- [Coding Conventions](../documentation/02-coding-conventions.md)
- [Development Workflow](../documentation/03-development-workflow.md)
- [Packages Overview](../documentation/04-packages-overview.md)

Happy coding! 🎉
