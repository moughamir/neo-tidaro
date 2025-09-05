
# Coding Conventions & Style Guide

This document outlines the coding conventions and style guide for the Tidaro workspace. Adhering to these conventions ensures consistency, readability, and maintainability of the codebase.

## Formatting

- All Dart code should be formatted using `dart format`. This ensures a consistent code style throughout the project.
- Use 2-space indentation.
- Use trailing commas.
- All code must pass `flutter analyze` without any errors or warnings.

## Naming Conventions

- **Variables and functions:** `camelCase`
- **Classes and Widgets:** `PascalCase`
- **Files:** `snake_case.dart`

## API & State Management

- Supabase is used for all backend interactions.
- Networking, models, and services should be kept in the `packages/` directory.
- UI widgets should consume these services via dependency injection.

## Error Handling

- Always handle asynchronous errors using `try/catch`, `FutureBuilder`, or `AsyncSnapshot`.
- Use `Either` or `Result` patterns in shared packages where applicable to handle errors in a functional way.

## AI Collaboration Guidelines

- **Modularity First:** New features should be created as new packages under the `packages/` directory. The `apps/` directory should be kept lean and only import what is needed.
- **Security:** Do not commit secrets or Supabase keys to the repository. Use `.env` files and secure injection at runtime.
- **Dependencies:** Add dependencies using `dart pub add <package>` inside the correct package. Sync the workspace with `melos bootstrap` if the package graph changes.
- **Commits:** Follow the Conventional Commits specification.
