# Tidaro Workspace

Welcome to the Tidaro monorepo, a modular workspace for developing the Tidaro platform and its related applications. This repository is managed using [Melos](https://melos.invertase.dev) to streamline development across multiple Dart and Flutter packages.

## About the Project

Tidaro is a housekeeping and service mediation platform designed for Morocco, with a vision for global scalability. The primary application is mobile-first, with a strong emphasis on multi-language accessibility to support Arabic, Tifinagh, Berber Latin, English, and French.

## Workspace Structure

The workspace is organized into two main directories: `apps` and `packages`.

-   `apps/`: Contains the entry-point applications for different platforms (e.g., mobile, web, desktop).
    -   `tidaro`: The main customer-facing mobile application.
    -   `tidaro_mini`: A lightweight version of the app.
    -   `tidash`: The admin dashboard.
-   `packages/`: Contains shared libraries and feature-specific modules.
    -   `core`: Core utilities, constants, and extensions.
    -   `languist`: Language and localization tools.
    -   `shared`: Shared domain models, business logic, and data layers.
    -   `ui_kit`: The design system and reusable UI components.

## Getting Started

### Prerequisites

-   [Flutter SDK](https://flutter.dev/docs/get-started/install) (latest stable)
-   [Dart SDK](https://dart.dev/get-dart) (comes with Flutter)
-   [Melos](https://melos.invertase.dev/getting-started):
    ```bash
    dart pub global activate melos
    ```

### Setup

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd neo-tidaro/workspace
    ```

2.  **Bootstrap the workspace:**
    This command links all the packages together and installs their dependencies.
    ```bash
    melos bootstrap
    ```

### Running the Apps

To run any of the applications, use the `flutter run` command from within the app's directory.

-   **Run the main Tidaro app:**
    ```bash
    cd apps/tidaro
    flutter run
    ```

-   **Run a specific build flavor or target:**
    ```bash
    flutter run --flavor staging -t lib/main_staging.dart
    ```

## Development Workflow

### Running Tests

Run tests for all packages from the root of the workspace:

```bash
melos run test
```

To run tests for a specific package, use Melos' scoping feature:

```bash
melos exec --scope="*ui_kit*" -- "flutter test"
```

### Code Quality

This project enforces strict code quality standards. Before committing, ensure your changes pass the linter and formatter checks.

-   **Format all code:**
    ```bash
    melos run format
    ```

-   **Analyze all code:**
    ```bash
    melos run analyze
    ```

### Adding Dependencies

-   **To a specific package:**
    Use `melos exec` to run `dart pub add` within the target package.
    ```bash
    melos exec --scope="*core*" -- "dart pub add http"
    ```

-   **To an app:**
    ```bash
    cd apps/tidaro
    dart pub add <package_name>
    ```

After adding or removing dependencies, re-run `melos bootstrap` to ensure the workspace is up-to-date.

## Contributing

Please read our `CONTRIBUTING.md` for details on our code of conduct and the process for submitting pull requests.
