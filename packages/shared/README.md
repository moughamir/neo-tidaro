# Shared Package

This package contains shared domain models, business logic, and data access layers for the Tidaro workspace.

## Overview

The `shared` package is a central place for all the business logic and data-related code that is shared across multiple applications. It is organized into the following layers:

-   **Domain:** Contains the core business objects (entities, value objects) and their logic.
-   **Data:** Contains the repositories and data sources that are responsible for fetching and storing data.
-   **DTOs (Data Transfer Objects):** Contains the models that are used to transfer data between the app and the backend.

## Usage

To use this package, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  shared:
    path: ../../packages/shared
```