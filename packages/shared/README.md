---
created_date: 07/09/2025
updated_date: 20/11/2025
---
# KUI Shared Package

A collection of shared widgets, utilities, and domain objects for TiDaro applications using Material UI with Neumorphic styling.

## Features

### Widgets

The package provides a set of reusable, responsive widgets built with Material UI and Neumorphic styling:

- **Buttons**: PrimaryButton (with Neumorphic styling)
- **Containers**: InfoCard, KuiCard.glass
- **Dialogs**: GenericDialog
- **Indicators**: LoadingIndicator, ErrorDisplay
- **Layout**: PageScaffold, ResponsiveLayout
- **Lists**: ResponsiveGridView
- **Theme**: NeumorphicTheme

### Utilities

Commonly used utilities to simplify development:

- **Extensions**:

  - DateTimeExtensions: Format dates, relative time strings
  - StringExtensions: Capitalize, title case, truncation

- **Failures**:

  - Standardized failure handling with `Either` monad
  - Predefined failure types: Server, Connection, Validation, Unexpected

- **Type Definitions**:
  - Result<T> and ResultFuture<T> for functional error handling

### Domain Layer

Base classes for clean architecture:

- **Entities**: Base Entity class with Equatable support
- **Repositories**: Generic CRUD repository interface

## Usage

### Installation

Add this package to your pubspec.yaml:

```yaml
dependencies:
  kui_shared:
    path: ../shared
```

### Import

```dart
import 'package:kui_shared/kui_shared.dart';
```

### Examples

#### Using Responsive Layout

```dart
ResponsiveLayout(
  smallBuilder: (context) => MobileView(),
  mediumBuilder: (context) => TabletView(),
  largeBuilder: (context) => DesktopView(),
  defaultBuilder: (context) => MobileView(),
)
```

#### Using Neumorphic Theme and Components

```dart
// Apply theme to your app
MaterialApp(
  theme: NeumorphicTheme.createThemeData(isDark: false),
  darkTheme: NeumorphicTheme.createThemeData(isDark: true),
  // ...
)

// Use Neumorphic button
PrimaryButton(
  onPressed: () => print('Pressed!'),
  child: Text('Neumorphic Button'),
)

// Use Glassy Card with blur effect
KuiCard.glass(
  title: 'Frosted Glass Card',
  child: SomeContent(),
  blur: 10.0,
  opacity: 0.2,
)
```

#### Error Handling

```dart
Result<User> result = await userRepository.getUser(id);

result.fold(
  (failure) => ErrorDisplay(failure: failure, onRetry: fetchData),
  (user) => UserProfileView(user: user),
);
```

#### DateTime Formatting

```dart
final dateTime = DateTime.now();
final formatted = dateTime.format('dd/MM/yyyy');
final relativeTime = dateTime.fromNow(l10n);
```

## Dependency Notes

This package depends on:

- Material UI (Flutter's built-in Material Design)
- Languist for localization
- fpdart for functional programming
- equatable for value equality
- clay_containers for enhanced Neumorphic effects
- google_fonts for typography
