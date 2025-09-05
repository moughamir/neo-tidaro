# Neo-Tidaro Workspace Examples

This directory contains example Flutter applications that demonstrate how to integrate and use the Neo-Tidaro workspace packages effectively. Each example showcases different aspects of the workspace architecture and package integration.

## 📁 Available Examples

### 1. Basic App (`basic_app/`)
**Purpose**: Demonstrates basic workspace package integration  
**Packages Used**: `shared`, `core`, `ui_kit`, `languist`

A simple Flutter application that shows:
- Basic UI Kit component usage
- Localization with Languist
- Redux state management integration
- Clean architecture patterns

**Key Features**:
- Counter functionality with Redux
- Localized strings
- Material 3 theming
- UI Kit components showcase

### 2. Redux Showcase (`redux_showcase/`)
**Purpose**: Comprehensive Redux state management demonstration  
**Packages Used**: `shared`, `core`, `ui_kit`, `languist`

An interactive application demonstrating:
- Complete Redux store setup
- Actions, reducers, and selectors
- State management patterns
- Middleware integration

**Key Features**:
- Counter state management
- Loading states
- Error handling
- Success messages
- Interactive UI with Redux connections

### 3. UI Kit Showcase (`ui_kit_showcase/`)
**Purpose**: Complete UI Kit components demonstration  
**Packages Used**: `ui_kit`, `languist`

A comprehensive showcase of all UI Kit components:
- Buttons (Primary, Secondary, Neumorphic)
- Cards (Glassy, Info)
- Indicators (Loading, Progress)
- Layout components
- Grid systems
- Dialogs and modals
- Theme integration

**Key Features**:
- Interactive component gallery
- Material 3 theming
- Responsive design
- Component variations

### 4. Authentication Flow (`auth_flow/`)
**Purpose**: Complete authentication flow with workspace integration  
**Packages Used**: `shared`, `core`, `ui_kit`, `languist`

A full authentication system demonstrating:
- Login/logout functionality
- Form validation
- Error handling
- State persistence
- Security best practices

**Key Features**:
- Redux-based auth state
- Form validation
- Error display
- Demo authentication
- Protected routes

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.35.0)
- Dart SDK (>=3.9.0)
- Melos for workspace management

### Running Examples

1. **Setup the workspace**:
   ```bash
   cd /path/to/neo-tidaro/workspace
   melos bootstrap
   ```

2. **Run any example**:
   ```bash
   # Navigate to example directory
   cd examples/basic_app
   
   # Get dependencies
   flutter pub get
   
   # Run the app
   flutter run
   ```

3. **Using Melos** (from workspace root):
   ```bash
   # Run specific example
   melos exec --scope="basic_app_example" -- flutter run
   
   # Analyze all examples
   melos exec --scope="*_example" -- flutter analyze
   
   # Get dependencies for all examples
   melos exec --scope="*_example" -- flutter pub get
   ```

## 🏗️ Architecture Overview

### Package Dependencies
All examples follow the same dependency structure:

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # Workspace Dependencies
  shared:
    path: ../../packages/shared
  core:
    path: ../../packages/core
  ui_kit:
    path: ../../packages/ui_kit
  languist:
    path: ../../packages/languist
```

### Integration Patterns

#### 1. Redux Integration
```dart
// Store setup
final Store<AppState> store = createStore(enableLogging: true);

// Provider wrapper
StoreProvider<AppState>(
  store: store,
  child: MaterialApp(...),
)

// Component connection
StoreConnector<AppState, int>(
  converter: (store) => UiSelectors.getCounter(store.state),
  builder: (context, counter) => Text('$counter'),
)
```

#### 2. Localization Setup
```dart
MaterialApp(
  localizationsDelegates: Languist.localizationsDelegates,
  supportedLocales: Languist.supportedLocales,
  // ...
)

// Usage in widgets
final l10n = Languist.of(context);
Text(l10n.hello)
```

#### 3. UI Kit Components
```dart
// Import UI Kit
import 'package:ui_kit/ui_kit.dart';

// Use components
GlassyCard(
  title: 'Card Title',
  subtitle: 'Card Subtitle',
  child: YourContent(),
)
```

## 📚 Learning Path

### Beginner
1. Start with **Basic App** to understand workspace integration
2. Explore **UI Kit Showcase** to learn available components
3. Study the package structure and dependencies

### Intermediate
1. Dive into **Redux Showcase** for state management patterns
2. Understand actions, reducers, and selectors
3. Learn middleware and store configuration

### Advanced
1. Examine **Authentication Flow** for complete app architecture
2. Study form validation and error handling
3. Understand security patterns and state persistence

## 🛠️ Development Guidelines

### Code Organization
- Follow Clean Architecture principles
- Separate business logic from UI
- Use proper package imports
- Maintain consistent naming conventions

### State Management
- Use Redux for complex state
- Implement proper action creators
- Create reusable selectors
- Handle loading and error states

### UI Development
- Leverage UI Kit components
- Follow Material 3 guidelines
- Implement responsive design
- Use proper theming

### Localization
- Use Languist for all text
- Implement proper parameterization
- Support multiple languages
- Handle pluralization

## 🔧 Customization

### Adding New Examples
1. Create new directory under `examples/`
2. Add `pubspec.yaml` with workspace dependencies
3. Implement your example application
4. Update workspace configuration in root `pubspec.yaml`
5. Add documentation to this README

### Modifying Examples
- Follow existing patterns and conventions
- Maintain compatibility with workspace packages
- Update documentation as needed
- Test thoroughly before committing

## 📖 Package Documentation

### Core Packages
- **shared**: Domain logic, utilities, Redux state management
- **core**: Core services, repositories, business logic
- **ui_kit**: Reusable UI components, theming, widgets
- **languist**: Internationalization and localization

### Integration Benefits
- **Consistency**: Shared components and patterns
- **Maintainability**: Centralized logic and styling
- **Scalability**: Modular architecture
- **Reusability**: Package-based development

## 🐛 Troubleshooting

### Common Issues

1. **Dependency Conflicts**:
   ```bash
   melos clean
   melos bootstrap
   ```

2. **Import Errors**:
   - Check package paths in `pubspec.yaml`
   - Verify workspace configuration
   - Run `flutter pub get`

3. **Localization Issues**:
   ```bash
   melos run gen:l10n
   ```

4. **Redux State Issues**:
   - Check store configuration
   - Verify action dispatching
   - Debug with logging middleware

### Getting Help
- Check package documentation
- Review existing examples
- Examine workspace configuration
- Use Flutter debugging tools

## 🚀 Next Steps

After exploring these examples:
1. Create your own workspace-integrated app
2. Contribute new examples or improvements
3. Extend existing packages with new features
4. Share patterns and best practices

## 📄 License

These examples are part of the Neo-Tidaro workspace and follow the same licensing terms as the main project.
