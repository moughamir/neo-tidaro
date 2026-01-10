---
created_date: 13/09/2025
updated_date: 20/11/2025
---
# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Project Overview

This is a **multi-platform Flutter monorepo** for **Tidaro** - a housekeeping and service mediation platform designed for Morocco with global scalability. The workspace uses **Melos** for monorepo management and supports all Flutter platforms (Android, iOS, Linux, macOS, Web, Windows).

### Primary Applications
- **`apps/tidaro/`**: Main customer-facing booking application
- **`apps/tidash/`**: Admin dashboard for operators to manage bookings, staff, and metrics
- **`apps/tidaro_mini/`**: Lightweight companion app variant
- **`apps/labo/`**: Additional laboratory/testing app

### Architecture
The project follows **Clean Architecture** with Redux state management and multi-language support (Arabic, Tifinagh, French, English).

## Common Development Commands

### Initial Setup
```bash
# Install Melos globally
dart pub global activate melos

# Bootstrap workspace (install all dependencies)
melos bootstrap

# Generate localization files
melos run gen:l10n
```

### Code Quality & Analysis
```bash
# Run static analysis on all packages
melos analyze

# Run all tests
melos test

# Run tests for specific package
melos run test --scope=ui_kit

# Clean and reinstall dependencies
melos clean
melos bootstrap

# Apply automatic fixes
melos run fix:apply

# Check fixes without applying (dry run)
melos run fix:dry
```

### Running Applications

#### Platform-Specific Commands
```bash
# Tidaro (Main App)
melos run run:tidaro:android     # Android
melos run run:tidaro:linux       # Linux Desktop  
melos run run:tidaro:web         # Web (port 8080)
melos run run:tidaro:windows     # Windows Desktop

# Tidaro Mini
melos run run:tidaro_mini:android
melos run run:tidaro_mini:web    # Web (port 8081)

# Tidash (Admin Dashboard)  
melos run run:tidash:android
melos run run:tidash:linux
melos run run:tidash:web         # Web (port 8082)

# Examples (Linux only for development)
melos run run:basic_app
melos run run:auth_flow
melos run run:ui_kit_showcase
```

### Building for Production
```bash
# Build for all platforms
melos run build:android          # Android APK
melos run build:web              # Web application
melos run build:linux            # Linux desktop
melos run build:windows          # Windows desktop
```

### Running Single Tests
```bash
# Run specific test file
flutter test test/widget_test.dart

# Run with coverage
flutter test --coverage

# Run integration tests
flutter test integration_test/
```

### Localization Workflow
```bash
# Generate localization after editing ARB files
melos run gen:l10n

# ARB files are located in packages/languist/lib/l10n/
# Edit app_*.arb files for translations
```

### Supabase Local Development
```bash
# Start local Supabase stack
supabase start

# Check status (API: 54321, DB: 54322, Studio: 54323)
supabase status

# Reset database and apply migrations
supabase db reset

# Stop local stack
supabase stop
```

## High-Level Architecture

### Package Structure
```
packages/
├── core/           # Base utilities, API clients, platform services
├── shared/         # Redux state management, domain entities, common widgets
├── ui_kit/         # Material 3 theming, custom components (NeomorphicButton, KuiCard.glass)
├── languist/       # i18n support (French, Arabic, Tifinagh, English)
├── domain/         # Domain layer entities and business logic
└── device_sensors/ # Device sensors and permissions
```

### Dependency Flow
```
Apps/Examples → Shared ← UI Kit
    ↓              ↓
Core ← Domain  ← Languist
```

### State Management Architecture
- **Pattern**: Redux (standard across all apps)
- **Structure**: Actions → Reducers → State → Selectors
- **Location**: State management logic in `packages/shared/`
- **Usage**: Apps import and compose Redux store from shared packages

### Key Architectural Principles
1. **Clean Architecture**: Separation of concerns between layers
2. **Dependency Inversion**: Core packages define interfaces, implementations in higher layers
3. **Domain-Driven Design**: Business logic encapsulated in domain entities
4. **Redux Pattern**: Predictable state updates with immutable state objects
5. **Multi-Platform Support**: Write once, run everywhere with platform-specific adaptations

### Backend Integration
- **Primary Backend**: Supabase (Auth, PostgreSQL, Realtime, Storage, Functions)
- **Local Development**: Supabase CLI with official stack
- **Security**: Environment variables for API keys, Row Level Security (RLS) policies
- **Schema Management**: Migrations in `supabase/migrations/`, seeds in `supabase/seeds/`

### UI System
- **Design System**: Material 3 with neumorphic/glassy components
- **Custom Components**: `NeomorphicButton`, `KuiCard.glass`, `AuthInputField`
- **Theming**: Light/dark themes with consistent color schemes
- **Typography**: Multi-language font support (Noto Sans, Noto Sans Arabic, Noto Sans Tifinagh)

### Internationalization (i18n)
- **Package**: `packages/languist` with `languist.yaml` configuration
- **Supported Languages**: English, French, Arabic, Tifinagh
- **ARB Files**: Located in `packages/languist/lib/l10n/`
- **Generation**: `melos run gen:l10n` after editing translations
- **Usage**: `AppLocalizations.of(context).helloUser('John')`

### Development Workflow Standards
- **Git Flow**: `main`, `develop`, `feature/*`, `release/*`, `hotfix/*` branches
- **Commit Format**: Conventional commits (`feat:`, `fix:`, `docs:`, `refactor:`)
- **Code Style**: `dart format`, 2-space indentation, trailing commas
- **Testing**: Unit tests in each package, widget tests for UI, integration tests for flows
- **CI Requirements**: `melos bootstrap`, `flutter analyze`, `flutter test`

## Important Notes

### Environment Configuration
- Copy `.env.example` to `.env` for local development
- Never commit actual Supabase keys or sensitive data
- Use `--dart-define` flags or `flutter_dotenv` for runtime configuration

### Package Development
- New features should be developed as packages under `/packages`
- Keep apps lightweight - they should primarily compose packages
- Follow existing Redux patterns when adding state management
- Use Clean Architecture principles for package organization

### Testing Strategy
- Each package maintains its own `/test` directory
- Redux state changes require unit tests
- UI changes should include widget tests
- Use `melos test --scope=package_name` for focused testing

### Performance Considerations
- Use `const` constructors for widgets
- Implement proper `dispose` methods for controllers
- Use `ListView.builder` for large lists
- Monitor memory usage with Redux DevTools

This monorepo prioritizes modularity, multi-platform support, and clean architecture. Always reference existing packages and patterns when implementing new features, and ensure proper separation of concerns between domain logic, UI components, and platform-specific implementations.

<citations>
  <document>
	  <document_type>WARP_DOCUMENTATION</document_type>
	  <document_id>getting-started/quickstart-guide/coding-in-warp</document_id>
  </document>
</citations>
