---
created_date: 07/09/2025
updated_date: 20/11/2025
---
# Neo‑Tidaro UI Kit

A centralized, unified Flutter UI component library featuring a comprehensive design system that combines Neumorphism and Glassmorphism effects. Built for Clean Architecture with DRY, SOLID, KISS, and YAGNI principles. Fully localized via the Languist package.

![Showcase](./docs/images/showcase-hero.png)

## 🎨 Unified Design System

The UI Kit now features a **centralized design system** that consolidates all previous theme implementations into a single, cohesive foundation:

- **Design Tokens**: Centralized spacing, colors, typography, and effects
- **Unified Theme**: Single theme system replacing AppTheme, NeumorphicTheme, and TidaroColorPalette
- **Effect System**: Consistent Neumorphism and Glassmorphism effects across all components
- **Consolidated Components**: Unified button and card components replacing duplicates

## Design Philosophy

- **Material 3** as the baseline for accessibility and consistency
- **Unified Design System** with centralized tokens and consistent effects
- **Neumorphism + Glassmorphism** seamlessly integrated for modern UI
- **Clean Architecture** separation: UI here, state/business elsewhere
- **DRY Principles** with consolidated components and shared design tokens
- **First‑class internationalization** via Languist (centralized ARB strings)

## What’s inside

- App scaffolding
  - `AppShell`: DRY wrapper around `MaterialApp` wiring theme and localization
  - `MasterLayout`: responsive scaffold builder
- Theming & localization
  - `AppTheme` with `TidaroColorPalette` and typography
  - `AppLocalizations` wrapper around Languist
  - Mixins: `ThemeMixin`, `L10nMixin`, `ResponsiveMixin`
- Auth UI
  - `AuthLayout`, `AuthCard`, `AuthInputField`, `AuthButton`, `SocialAuthButton`, `AuthDivider`
- Housekeeping widgets
  - `MetricCard`, `ActivityFeed`, `DashboardHeader`
  - `BookingsHeader`, `BookingCard`
  - `StaffHeader`, `StaffCard`
- Utilities
  - `LoadingApp`, `ErrorApp`, `LoadingScreen`

![Dashboard](./docs/images/dashboard.png)
![Auth](./docs/images/auth.png)

## Quick start

1. Add dependency (in a Melos workspace this is already wired):

```yaml
dependencies:
  ui_kit:
    path: ../packages/ui_kit
  languist:
    path: ../packages/languist
```

2. Use the DRY `AppShell` and a UI Kit page:

```dart
import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const AppShell(
      title: 'My App',
      home: Scaffold(
        body: Center(child: Text('Hello UI Kit')),
      ),
    );
  }
}
```

## Localization

UI Kit uses the centralized Languist configuration. Access strings via the wrapper:

```dart
// From a StatefulWidget using L10nMixin
final l10n = this.l10n; // AppLocalizations
Text(l10n.login);

// Or directly
Text(AppLocalizations.of(context).login);
```

Ensure your app’s `MaterialApp` (or `AppShell`) has:

```dart
localizationsDelegates: AppLocalizations.localizationsDelegates,
supportedLocales: AppLocalizations.supportedLocales,
```

## Theming

Use the unified design system `KuiTheme`:

```dart
import 'package:ui_kit/src/design_system/design_system.dart';

MaterialApp(
  theme: KuiTheme.light(),
  darkTheme: KuiTheme.dark(),
  themeMode: ThemeMode.system,
)
```

Quick helpers:

```dart
final colors = KuiTheme.colorsOf(context); // DesignColorTokens
final deco = KuiTheme.neumorphicOf(context, elevation: 2);
final glass = KuiTheme.glassOf(context, child: myWidget);
```

## Responsive helpers

Use `ResponsiveMixin` for simple breakpoints:

```dart
class MyPage extends StatefulWidget { /* ... */ }
class _MyPageState extends State<MyPage>
    with ThemeMixin<MyPage>, L10nMixin<MyPage>, ResponsiveMixin<MyPage> {
  @override
  Widget build(BuildContext context) {
    return withConstraints((c) {
      if (isMobile) return const Text('Mobile');
      if (isTablet) return const Text('Tablet');
      return const Text('Desktop');
    });
  }
}
```

## Example apps

Check `examples/ui_kit_showcase/` for a themed parallax card example and `apps/tidash/` for a full production dashboard using UI Kit components.

## Contributing

- Keep UI components stateless where possible
- Prefer `package:ui_kit/ui_kit.dart` barrel imports; avoid implementation paths
- Follow DRY, SOLID, KISS, YAGNI
- Add localization keys to Languist when introducing user-facing text
- Include screenshots (PNG) under `packages/ui_kit/docs/images/`

## License

See `LICENSE` in the package root.
