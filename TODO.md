# Project TODOs

This document outlines tasks and improvements for the project, categorized by area and prioritized by urgency.

## 📚 Workspace Rules & Workflow

These items align the repo with our workspace-wide rules and development workflow.

- [x] Centralize i18n via `packages/languist` using `languist.yaml` and `melos run gen:l10n` (see `packages/languist/`)
- [x] Provide platform run/build scripts via Melos for all apps (see `.github/workflows`, workspace `pubspec.yaml` scripts)
- [ ] Document and enforce Git Flow: branches `main`, `develop`, `feature/*`, `release/*`, `hotfix/*` (add branch protections and docs)
- [ ] Add PR templates, issue templates, and CODEOWNERS for review rules
- [ ] Standardize state management on Redux for new features; ensure consistency across modules
- [ ] Provide Redux scaffolds and examples in `packages/shared` (or a dedicated `packages/state/`)
- [ ] Add Docker Compose for local backend services (Supabase) and document usage in `documentation/`
- [ ] Define environment management strategy: `.env`, `supabase/config.toml`, secrets via CI
- [ ] Expand CI: `flutter analyze`, `flutter test`, and build matrix for platforms
- [ ] Keep Clean Architecture docs updated in `documentation/` and ensure packages follow roles (core/shared/languist/device_sensors)

## 🚀 High Priority

### Build/Configuration

- [x] Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html). (apps/tidash/android/app/build.gradle.kts:23)
- [x] Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html). (apps/tidaro_mini/android/app/build.gradle.kts:23)
- [x] Add your own signing config for the release build. (apps/tidaro/android/app/build.gradle.kts:34)
- [x] Add your own signing config for the release build. (apps/tidash/android/app/build.gradle.kts:35)
- [x] Add your own signing config for the release build. (apps/tidaro_mini/android/app/build.gradle.kts:35)

### Dependency Management

- [x] Update outdated dependencies across all packages

## ✨ Medium Priority

### Documentation

- [x] Create comprehensive documentations

### Licensing

- [x] Add your license here. (packages/ui_kit/LICENSE:1)

### Package Development/Readiness

- [x] Describe initial release. (packages/ui_kit/CHANGELOG.md:3)
- [x] Put a short description of the package here that helps potential users (packages/ui_kit/README.md:14)
- [x] List what your package can do. Maybe include images, gifs, or videos. (packages/ui_kit/README.md:19)
- [x] List prerequisites and provide or point to information on how to (packages/ui_kit/README.md:23)
- [x] Include short and useful examples for package users. Add longer examples (packages/ui_kit/README.md:28)
- [x] Tell users more about the package: where to find more information, how to (packages/ui_kit/README.md:37)

## 🧹 Low Priority

### Build/Configuration

- [x] Move the rest of this into files in ephemeral. See (examples/ui_kit_showcase/linux/flutter/CMakeLists.txt:9)
- [x] Move the rest of this into files in ephemeral. See (examples/auth_flow/linux/flutter/CMakeLists.txt:9)
- [x] Move the rest of this into files in files in ephemeral. See (examples/basic_app/linux/flutter/CMakeLists.txt:9)
- [x] Move the rest of this into files in ephemeral. See (apps/tidaro/linux/flutter/CMakeLists.txt:9)
- [x] Move the rest of this into files in ephemeral. See (apps/tidaro/windows/flutter/CMakeLists.txt:9)
- [x] Move the rest of this into files in ephemeral. See (apps/tidash/linux/flutter/CMakeLists.txt:9)
- [x] Move the rest of this into files in ephemeral. See (apps/tidash/windows/flutter/CMakeLists.txt:9)
- [x] Move the rest of this into files in ephemeral. See (apps/tidaro_mini/linux/flutter/CMakeLists.txt:9)
- [x] Move the rest of this into files in ephemeral. See (apps/tidaro_mini/windows/flutter/CMakeLists.txt:9)

## 🛠️ UI Kit Refactoring - Common Widgets

## 🎨 Design System Implementation

### High Priority

- [ ] Replace `Card` widgets with `NeumorphicCard` throughout the application.
- [ ] Replace `ElevatedButton` widgets with `NeumorphicElevatedButton` throughout the application.
- [ ] Replace `OutlinedButton` widgets with `NeumorphicOutlinedButton` throughout the application.
- [ ] Replace `TextFormField` or `TextField` widgets with `NeumorphicInputField` throughout the application.
- [ ] Integrate `GlassContainer` into relevant UI components for glass-morphic effects (e.g., dialogs, sidebars, specific cards).

### High Priority

- [ ] Create a responsive DashboardGrid/MetricGrid widget in `ui_kit` to abstract `StaggeredGrid` usage. (apps/tidash/lib/pages/dashboard/dashboard_page.dart) (Consider generalizing to `ResponsiveGrid` or `CardGrid` for `StaffPage`'s `SliverGrid` usage.)
- [ ] Move `_formatNumber` and `_formatCurrency` utility functions to `packages/shared` or `packages/ui_kit/utils`. (apps/tidash/lib/pages/dashboard/dashboard_page.dart)
- [ ] Refactor `LoginPage` to use `AuthInputField` for email and password. (apps/tidash/lib/pages/home_page.dart)
- [ ] Refactor `LoginPage` to use `AuthButton` for the Sign In button. (apps/tidash/lib/pages/home_page.dart)
- [ ] Refactor `AddStaffDialog` to use `AuthInputField` for name, email, and phone. (apps/tidash/lib/widgets/dialogs/add_staff_dialog.dart)
- [ ] Create a reusable `SectionHeader` widget in `ui_kit` from `_buildSectionHeader`. (apps/tidash/lib/widgets/dialogs/add_staff_dialog.dart)
- [ ] Refactor `AddStaffDialog` action buttons to use `AuthButton`. (apps/tidash/lib/widgets/dialogs/add_staff_dialog.dart)
- [ ] Create a reusable `InfoCard` or `SectionCard` widget in `ui_kit` from `_buildInfoCard`. (apps/tidash/lib/widgets/dialogs/booking_details_dialog.dart)
- [ ] Create a reusable `InfoRow` or `DetailRow` widget in `ui_kit` from `_buildInfoRow`. (apps/tidash/lib/widgets/dialogs/booking_details_dialog.dart)
- [ ] Refactor `BookingFilterDialog` to use `SectionHeader` for filter sections. (apps/tidash/lib/widgets/dialogs/booking_filter_dialog.dart)
- [ ] Create a reusable `DateRangeSelector` widget in `ui_kit` from `BookingFilterDialog`'s date range selection. (apps/tidash/lib/widgets/dialogs/booking_filter_dialog.dart)
- [ ] Refactor `BookingFilterDialog` action buttons to use `AuthButton`. (apps/tidash/lib/widgets/dialogs/booking_filter_dialog.dart)
- [ ] Refactor `CreateBookingDialog` to use `AuthInputField` for all text inputs. (apps/tidash/lib/widgets/dialogs/create_booking_dialog.dart)
- [ ] Refactor `CreateBookingDialog` to use `SectionHeader` for form sections. (apps/tidash/lib/widgets/dialogs/create_booking_dialog.dart)
- [ ] Create reusable `DateSelector` and `TimeSelector` widgets in `ui_kit`. (apps/tidash/lib/widgets/dialogs/create_booking_dialog.dart)
- [ ] Refactor `CreateBookingDialog` action buttons to use `AuthButton`. (apps/tidash/lib/widgets/dialogs/create_booking_dialog.dart)
- [ ] Refactor `StaffDetailsDialog` to use `InfoCard` for information sections. (apps/tidash/lib/widgets/dialogs/staff_details_dialog.dart)
- [ ] Refactor `StaffDetailsDialog` to use `InfoRow` for detail rows. (apps/tidash/lib/widgets/dialogs/staff_details_dialog.dart)
- [ ] Refactor `StaffDetailsDialog` action buttons to use `AuthButton`. (apps/tidash/lib/widgets/dialogs/staff_details_dialog.dart)
- [ ] Refactor `StaffFilterDialog` to use `SectionHeader` for filter sections. (apps/tidash/lib/widgets/dialogs/staff_filter_dialog.dart)
- [ ] Refactor `StaffFilterDialog` action buttons to use `AuthButton`. (apps/tidash/lib/widgets/dialogs/staff_filter_dialog.dart)
- [ ] Create a reusable `EmptyState` widget in `ui_kit` from `_buildEmptyState`. (apps/tidash/lib/pages/bookings/bookings_page.dart) (apps/tidash/lib/pages/staff/staff_page.dart)
- [ ] Refactor `BookingsPage` empty state button to use `AuthButton`. (apps/tidash/lib/pages/bookings/bookings_page.dart) (apps/tidash/lib/pages/staff/staff_page.dart)
- [ ] Replace `ErrorApp` and `ErrorScreen` in `apps/tidash` with `ErrorApp` from `ui_kit`. (apps/tidash/lib/app/widgets/error_app.dart)
- [ ] Replace `LoadingApp` and `LoadingScreen` in `apps/tidash` with `LoadingApp` from `ui_kit`. (apps/tidash/lib/app/widgets/loading_app.dart) (apps/tidash/lib/app/widgets/loading_screen.dart)
- [ ] Replace `MaterialApp` and `ThemeData` in `apps/tidaro` with `AppShell` from `ui_kit`. (apps/tidaro/lib/app/app.dart)
- [ ] Consider using `MasterLayout` from `ui_kit` for `HomePage` in `apps/tidaro` if its layout grows in complexity. (apps/tidaro/lib/pages/home/page.dart)
- [ ] Replace `MaterialApp` and `ThemeData` in `apps/tidaro_mini` with `AppShell` from `ui_kit`. (apps/tidaro_mini/lib/main.dart)
- [ ] Replace `MaterialApp` and `ThemeData` in `examples/auth_flow` with `AppShell` from `ui_kit`. (examples/auth_flow/lib/main.dart)
- [ ] Replace `MaterialApp` and `ThemeData` in `examples/basic_app` with `AppShell` from `ui_kit`. (examples/basic_app/lib/main.dart)
- [ ] Replace `MaterialApp` and `ThemeData` in `examples/ui_kit_showcase` with `AppShell` from `ui_kit`. (examples/ui_kit_showcase/lib/main.dart)
- [ ] Create a reusable `SectionCard` or `ExampleCard` widget in `ui_kit` from `_SectionCard`. (examples/ui_kit_showcase/lib/main.dart)
- [ ] Refactor `ui_kit_showcase` counter example buttons to use `AuthButton` or a more generic `ThemedButton`. (examples/ui_kit_showcase/lib/main.dart)
- [ ] Generalize `GridView.builder` usage in `ui_kit_showcase` into a `ResponsiveGrid` or `CardGrid` widget. (examples/ui_kit_showcase/lib/main.dart)

### Medium Priority

- [ ] Create a generic `LoadingIndicator` widget in `ui_kit` for consistent loading states. (apps/tidash/lib/pages/dashboard/dashboard_page.dart) (apps/tidash/lib/pages/bookings/bookings_page.dart) (apps/tidash/lib/pages/staff/staff_page.dart) (apps/tidash/lib/app/widgets/error_app.dart) (apps/tidash/lib/app/widgets/loading_app.dart) (apps/tidash/lib/app/widgets/loading_screen.dart)
- [ ] Create a reusable `ErrorDisplay` or `MessageCard` widget in `ui_kit` for consistent error message presentation. (apps/tidash/lib/pages/home_page.dart) (apps/tidash/lib/pages/auth/signup_page.dart)
- [ ] Consider creating a `MultiSelectChipGroup` or `CategoryFilterChips` widget in `ui_kit` if the `FilterChip` pattern is repeated. (apps/tidash/lib/widgets/dialogs/add_staff_dialog.dart)
- [ ] Create a reusable `RatingDisplay` widget in `ui_kit` from `_buildRatingRow`. (apps/tidash/lib/widgets/dialogs/booking_details_dialog.dart)
- [ ] Move date/time formatting functions (`_formatDateTime`) to a utility in `packages/shared` or `packages/ui_kit/utils`. (apps/tidash/lib/widgets/dialogs/booking_details_dialog.dart)
- [ ] Refactor `BookingDetailsDialog` action buttons to use `AuthButton` or a more generic `ThemedButton`. (apps/tidash/lib/widgets/dialogs/booking_details_dialog.dart)
- [ ] Create a `SingleSelectChipGroup` or `StatusFilterChips` widget in `ui_kit` from `BookingFilterDialog`'s status filter. (apps/tidash/lib/widgets/dialogs/booking_filter_dialog.dart)
- [ ] Consider creating a `PriceRangeSlider` widget in `ui_kit` if the price range selection pattern is repeated. (apps/tidash/lib/widgets/dialogs/booking_filter_dialog.dart)
- [ ] Create a reusable `PriceDisplay` or `SummaryCard` widget in `ui_kit` from `CreateBookingDialog`'s price display. (apps/tidash/lib/widgets/dialogs/create_booking_dialog.dart)
- [ ] Move date formatting functions (`_formatDate`) to a utility in `packages/shared` or `packages/ui_kit/utils`. (apps/tidash/lib/widgets/dialogs/staff_details_dialog.dart)
- [ ] Create a `SingleSelectChipGroup` or `StatusFilterChips` widget in `ui_kit` from `StaffFilterDialog`'s status and availability filters. (apps/tidash/lib/widgets/dialogs/staff_filter_dialog.dart)
- [ ] Consider creating a `RatingRangeSlider` widget in `ui_kit` from `StaffFilterDialog`'s rating range filter. (apps/tidash/lib/widgets/dialogs/staff_filter_dialog.dart)
- [ ] Consider creating a generic `ThemedAlertDialog` or `InputAlertDialog` in `ui_kit` for consistent dialog presentation. (apps/tidash/lib/pages/auth/login_page.dart)
- [ ] Consider creating a `CollapsibleSection` or `ExpandableContent` widget in `ui_kit` for collapsible UI elements. (apps/tidash/lib/app/widgets/error_app.dart)
- [ ] Refactor `ErrorScreen` action buttons to use `AuthButton` or a more generic `ThemedButton`. (apps/tidash/lib/app/widgets/error_app.dart)
- [ ] Consider creating a `SupportInfoCard` or `HelpSection` widget in `ui_kit` for consistent support information display. (apps/tidash/lib/app/widgets/error_app.dart)
- [ ] Consider enhancing `ui_kit`'s `LoadingScreen` or creating a new `AnimatedLoadingIndicator` to encapsulate custom animations (pulse, rotation, pulsing dots). (apps/tidash/lib/app/widgets/loading_screen.dart)
