# Neo‑Tidaro UI Kit

A reusable, Material-first Flutter UI component library for Neo‑Tidaro apps, featuring a clean, modern design with subtle glassmorphism/neumorphism accents. Built for Clean Architecture with DRY, SOLID, KISS, and YAGNI principles. Fully localized via the Languist package.

![Showcase](./docs/images/showcase-hero.png)

## Design philosophy

- Material 3 as the baseline for accessibility and consistency
- Opinionated but minimal styling (glassmorphic cards, soft shadows, rounded corners)
- Clean Architecture separation: UI here, state/business elsewhere
- DRY and composable widgets with sensible defaults
- First‑class internationalization via Languist (centralized ARB strings)

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

`AppTheme` exposes light/dark `ThemeData` based on `TidaroColorPalette`:

```dart
theme: AppTheme.lightTheme,
darkTheme: AppTheme.darkTheme,
themeMode: ThemeMode.system,
```

Access semantic colors anywhere with:

```dart
final colors = Theme.of(context).colorScheme; // primary, secondary, surface, etc.
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
