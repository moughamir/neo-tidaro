
# Workspace Structure

This document provides a detailed overview of the Tidaro workspace structure. The workspace is organized into a multi-package Flutter/Dart monorepo managed with Melos.

## Root Directory

The root directory of the workspace contains the following files and directories:

- `.gitignore`: A gitignore file to exclude files from version control.
- `CODE_OF_CONDUCT.md`: The code of conduct for the project.
- `CONTRIBUTING.md`: The contributing guidelines for the project.
- `GEMINI.md`: A file containing context for AI models and contributors.
- `mason.yaml`: A configuration file for the Mason code generator.
- `package.json`: The package.json file for the root of the project.
- `pnpm-lock.yaml`: The pnpm lock file for the root of the project.
- `pubspec.yaml`: The pubspec.yaml file for the root of the project.
- `README.md`: The README file for the project.
- `TODO.md`: A file containing a list of tasks to be completed.
- `tree.txt`: A file containing a tree representation of the workspace structure.
- `apps/`: A directory containing the application entrypoints.
- `packages/`: A directory containing shared and feature packages.
- `documentation/`: A directory containing the workspace documentation.
- `examples/`: A directory containing example applications.

## `apps/` Directory

The `apps/` directory contains the application entrypoints. Each subdirectory in this directory represents a separate application.

- `tidaro/`: The main Tidaro mobile app.
- `tidaro_mini/`: A miniature version of the Tidaro app.
- `tidash/`: A dashboard for the Tidaro app.

## `packages/` Directory

The `packages/` directory contains shared and feature packages. Each subdirectory in this directory represents a separate package.

- `core/`: A package containing core functionality and utilities.
- `languist/`: A package for managing localization and internationalization.
- `shared/`: A package containing shared domain models and business logic.
- `ui_kit/`: A package containing a set of reusable UI components.

## `documentation/` Directory

The `documentation/` directory contains the workspace documentation. This is where you're reading this file!

## `examples/` Directory

The `examples/` directory contains example applications showcasing various features and packages.

- `auth_flow/`: An example of an authentication flow.
- `basic_app/`: A basic example of a Flutter application.
- `redux_showcase/`: An example of a Flutter application using Redux.
- `ui_kit_showcase/`: An example of a Flutter application showcasing the UI kit.
