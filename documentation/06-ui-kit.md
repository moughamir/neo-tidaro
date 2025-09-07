# UI Kit: Design System and Components

This document describes the Neo‑Tidaro UI Kit: design principles, theming, localization, mixins, and primary components available for app teams.

## Design Principles

- Material 3 baseline with subtle glassmorphism/neumorphism accents.
- Clean Architecture: UI kit provides UI only; state/business lives in `shared/` or app layer.
- DRY, SOLID, KISS, YAGNI.
- Internationalization is first‑class via Languist.

## Theming

UI Kit provides `AppTheme` built on `TidaroColorPalette` and custom typography.

```dart
MaterialApp(
  theme: AppTheme.lightTheme,
  darkTheme: AppTheme.darkTheme,
  themeMode: ThemeMode.system,
)
```

Access palette/colors anywhere using:

```dart
final colors = Theme.of(context).colorScheme; // primary, secondary, surface, etc.
```

## Localization

UI Kit ships with `AppLocalizations`, a thin wrapper around Languist.

```dart
final l10n = AppLocalizations.of(context);
Text(l10n.login);
```

Ensure your app adds:

```dart
localizationsDelegates: AppLocalizations.localizationsDelegates,
supportedLocales: AppLocalizations.supportedLocales,
```

## Mixins

- `ThemeMixin<T>`: `theme` and `colors`
- `L10nMixin<T>`: `l10n`
- `ResponsiveMixin<T>`: `isMobile`, `isTablet`, `isDesktop` and `withConstraints(builder)`

## App Shell & Layout

- `AppShell`: DRY `MaterialApp` wrapper wiring theme + localization
- `MasterLayout`: responsive scaffold builder

```dart
return const AppShell(
  title: 'My App',
  home: MyHomePage(),
);
```

## Auth Components

- `AuthLayout`, `AuthCard`, `AuthInputField`, `AuthButton`, `SocialAuthButton`, `AuthDivider`

Example:

```dart
AuthInputField(
  label: l10n.email,
  hint: l10n.emailHint,
  controller: emailController,
  prefixIcon: const Icon(Icons.email_outlined),
)
```

## Housekeeping Components

- `DashboardHeader`, `MetricCard`, `ActivityFeed`
- `BookingsHeader`, `BookingCard`
- `StaffHeader`, `StaffCard`

These are used extensively in the TiDash dashboard and staff pages.

## Usage Guidelines

- Prefer `package:ui_kit/ui_kit.dart` barrel imports.
- Avoid importing from `src/...` implementation paths.
- Keep UI widgets stateless where possible; prefer passing callbacks/data down from app state.
- Add new user‑facing strings to Languist.

## Screenshots

Place images under `packages/ui_kit/docs/images/` and reference them in the UI Kit README.

- `showcase-hero.png`
- `dashboard.png`
- `auth.png`
