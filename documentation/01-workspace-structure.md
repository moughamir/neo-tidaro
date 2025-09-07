# Neo-Tidaro Workspace Structure

This document provides an overview of the Neo-Tidaro workspace structure and organization.

## Directory Structure

```shell
neo-tidaro/
├── apps/                    # Flutter applications
│   ├── tidaro/             # Main Tidaro application
│   ├── tidaro_mini/        # Minimal version of Tidaro
│   └── tidash/             # Dashboard application
├── packages/               # Shared packages
│   ├── core/              # Core utilities and services
│   ├── languist/          # Localization package
│   ├── shared/            # Shared domain logic and widgets
│   └── ui_kit/            # UI components and theming
├── examples/              # Example applications
│   ├── auth_flow/         # Authentication flow example
│   ├── basic_app/         # Basic workspace integration
│   ├── redux_showcase/    # Redux state management demo
│   └── ui_kit_showcase/   # UI components showcase
├── documentation/         # Project documentation
└── source/               # Code generation templates
```

## Package Dependencies

### Core Dependencies Flow
```
apps → packages/shared → packages/core
apps → packages/ui_kit → packages/core
apps → packages/languist
examples → packages/*
```

### Package Purposes

#### `packages/core`
- Base utilities and services
- Network clients and API interfaces
- Common data models
- Platform-specific implementations

#### `packages/languist`
- Internationalization (i18n) support
- Multi-language content management
- Localization utilities
- ARB file generation and management

#### `packages/shared`
- Redux state management
- Domain entities and repositories
- Common widgets and components
- Business logic abstractions

#### `packages/ui_kit`
- Material 3 theming
- Custom UI components (NeomorphicButton, GlassyCard)
- Typography and color schemes
- Multi-language font support

## Workspace Management

The workspace uses [Melos](https://melos.invertase.dev/) for monorepo management:

- `melos bootstrap` - Install dependencies for all packages
- `melos run analyze` - Run static analysis on all packages
- `melos run test` - Run tests for all packages
- `melos run build` - Build all applications
- `melos run clean` - Clean all packages

## Development Workflow

1. **Setup**: Run `melos bootstrap` to install all dependencies
2. **Development**: Work on individual packages or apps
3. **Testing**: Use `melos run test` to test all packages
4. **Analysis**: Use `melos run analyze` to check code quality
5. **Build**: Use `melos run build` to build applications

## Architecture Principles

### Clean Architecture
- Separation of concerns between layers
- Dependency inversion principle
- Domain-driven design patterns

### State Management
- Redux pattern for predictable state updates
- Immutable state objects
- Action-based state mutations

### Localization
- Multi-language support (French, Arabic, Tifinagh)
- Dynamic language switching
- Parameterized translations

### UI/UX
- Material 3 design system
- Neumorphic design elements
- Responsive layouts
- Accessibility considerations
