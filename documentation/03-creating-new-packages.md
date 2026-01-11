---
title: 03-creating-new-packages
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# 3. Creating New Packages

One of the core principles of this monorepo is **modularity**. New features, shared utilities, or reusable UI components should ideally be developed as independent packages within the `packages/` directory. This guide will walk you through the process of creating and integrating a new package.

## When to Create a New Package?

Consider creating a new package when:

*   You are developing a new, distinct feature (e.g., a new payment module, a booking system).
*   You are building a set of reusable UI widgets that might be used across multiple applications or features.
*   You are creating a core utility library that doesn't belong to a specific feature but is used widely.
*   You want to enforce clear separation of concerns and improve code organization.

## Steps to Create a New Package

### 1. Generate the Package Structure

Navigate to the root of your monorepo and use the `flutter create` command to generate a new package. Ensure you create it directly within the `packages/` directory.

```bash
flutter create --template=package packages/my_new_package
```

Replace `my_new_package` with the actual name of your package (use `snake_case` for package names).

This command will create a new directory `packages/my_new_package` with the basic Dart package structure, including a `pubspec.yaml` file, `lib/` directory, and `test/` directory.

### 2. Bootstrap the Workspace

After creating a new package, you need to run `melos bootstrap` again from the monorepo root. This command will discover your new package, install its dependencies, and link it correctly within the workspace.

```bash
melos bootstrap
```

### 3. Define Dependencies

Edit the `pubspec.yaml` file inside your new package (`packages/my_new_package/pubspec.yaml`) to declare its dependencies. This includes any external packages from Pub.dev or other local packages within the monorepo.

**Example `pubspec.yaml` for `my_new_package`:**

```yaml
name: my_new_package
description: A new feature package for the Tidaro monorepo.
version: 0.0.1

environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: '>=3.0.0'

dependencies:
  flutter:
    sdk: flutter
  # Example of an external dependency
  http: ^1.0.0
  # Example of a local package dependency (e.g., ui_kit from this monorepo)
  ui_kit:
    path: ../ui_kit

dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^2.0.0
```

*   **External Dependencies**: Add them as usual (e.g., `http: ^1.0.0`).
*   **Local Dependencies**: For other packages within this monorepo, use the `path:` directive to specify the relative path to that package (e.g., `path: ../ui_kit`).

After modifying `pubspec.yaml`, remember to run `melos bootstrap` again to ensure all dependencies are correctly resolved.

### 4. Implement Your Logic

Start writing your Dart/Flutter code within the `lib/` directory of your new package. Follow the coding conventions outlined in `04-coding-conventions.md`.

### 5. Add Tests

Create unit and widget tests in the `test/` directory of your package to ensure its functionality is robust and reliable. Refer to `05-testing-workflow.md` for guidance on testing.

### 6. Use Your New Package

To use your new package in an application (e.g., `apps/tidaro`) or another package, simply add it as a dependency in their respective `pubspec.yaml` files, using the `path:` directive for local dependencies.

**Example `pubspec.yaml` for `apps/tidaro` using `my_new_package`:**

```yaml
name: tidaro
description: The main Tidaro mobile application.
# ... other fields

dependencies:
  flutter:
    sdk: flutter
  # ... other dependencies
  my_new_package:
    path: ../../packages/my_new_package
```

---

**Next:** Dive into the project's coding standards in `04-coding-conventions.md`.