---
created_date: 07/09/2025
updated_date: 20/11/2025
---
## 0.0.1

Initial release of Neo‑Tidaro UI Kit.

- App scaffolding
  - `AppShell`: DRY `MaterialApp` wrapper (themes + localization)
  - `MasterLayout`: responsive scaffold builder
- Theming & localization
  - `AppTheme` with `TidaroColorPalette` and typography
  - `AppLocalizations` (wrapper around Languist) and mixins (`ThemeMixin`, `L10nMixin`, `ResponsiveMixin`)
- Auth UI
  - `AuthLayout`, `AuthCard`, `AuthInputField`, `AuthButton`, `SocialAuthButton`, `AuthDivider`
- Housekeeping widgets
  - `MetricCard`, `ActivityFeed`, `DashboardHeader`, `BookingsHeader`, `BookingCard`, `StaffHeader`, `StaffCard`
- Utilities
  - `LoadingApp`, `ErrorApp`, `LoadingScreen`
  
This release focuses on providing a consistent, reusable UI foundation across Neo‑Tidaro apps, following Clean Architecture and DRY principles.

## 0.0.2

* Centralized reusable app scaffolding widgets moved from apps to UI Kit:
  - `LoadingApp` and `LoadingScreen` under `src/app/`
  - `ErrorApp` under `src/app/`
* Updated barrel `ui_kit.dart` exports to expose these widgets.
* Tidash app now imports these widgets via `package:ui_kit/ui_kit.dart`.
