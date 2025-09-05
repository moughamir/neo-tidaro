# Core Package

This package contains the core utilities, helpers, and extensions used across the Tidaro workspace.

## Overview

The `core` package is a foundational library that provides a set of common tools and functionalities that are shared by other packages and applications in the monorepo. This includes:

-   **Constants:** Application-wide constants such as API endpoints, feature flags, and configuration values.
-   **Extensions:** Dart extension methods that add functionality to existing classes (e.g., `String`, `DateTime`).
-   **Utilities:** Helper functions and classes for common tasks such as date formatting, validation, and device information.
-   **Networking:** A lightweight networking layer for making API requests.

## Usage

To use this package, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  core:
    path: ../../packages/core
```