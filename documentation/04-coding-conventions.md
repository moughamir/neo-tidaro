---
created_date: 07/09/2025
updated_date: 20/11/2025
---
# 4. Coding Conventions and Style Guide

Adhering to consistent coding conventions and a style guide is paramount in a monorepo environment. It ensures code readability, maintainability, and seamless collaboration across different packages and teams. This document outlines the key conventions to follow in the Tidaro project.

## 1. Formatting

*   **Automated Formatting**: Always use `dart format` to automatically format your code. This ensures consistent indentation (2 spaces), line breaks, and other stylistic elements.

	```bash
    dart format .
    ```

*   **Trailing Commas**: Use trailing commas for better readability and easier diffs, especially in multi-line lists, argument lists, and collections.

	```dart
    Widget build(BuildContext context) {
      return Column(
        children: <Widget>[
          Text('Hello'),
          Text('World'),
        ],
      );
    }
    ```

*   **Linting**: All code must pass `flutter analyze` (or `dart analyze` for pure Dart packages). The `analysis_options.yaml` file at the root of each package defines the linting rules. Address all warnings and errors before committing.

	```bash
    flutter analyze
    ```

## 2. Naming Conventions

Follow standard Dart naming conventions:

*   **Variables and Functions**: Use `camelCase`.

	```dart
    String userName = 'John Doe';
    void calculateTotalAmount() { /* ... */ }
    ```

*   **Classes, Enums, Extensions, Mixins, and Widgets**: Use `PascalCase`.

	```dart
    class UserProfileScreen extends StatelessWidget { /* ... */ }
    enum AuthStatus { authenticated, unauthenticated }
    ```

*   **Files and Directories**: Use `snake_case.dart` for file names and `snake_case` for directories.

	```
    lib/src/user_profile/user_profile_screen.dart
    lib/src/auth_repository/
    ```

*   **Constants**: Use `camelCase` for `const` and `final` variables, unless they are global constants, in which case `SCREAMING_SNAKE_CASE` can be used (though `camelCase` is generally preferred for consistency with other variables).

	```dart
    const int maxRetries = 3;
    final String appName = 'Tidaro';
    ```

## 3. API & State Management

*   **Backend Interactions**: Supabase is the primary backend for this project. All backend interactions should be handled through dedicated service layers or repositories, typically residing within the `packages/` that interact with Supabase.

*   **Models**: Define clear and immutable data models for your entities. Avoid using `Equatable` or `Freezed` for classes or entities, as per project guidelines.

*   **Dependency Injection**: Prefer explicit dependency injection for services and repositories. This improves testability and modularity.

*   **State Management**: While the project doesn't enforce a single state management solution, ensure that the chosen approach within a package is consistent and idiomatic for Flutter. Focus on clean, testable, and maintainable state logic.

*   **Either/Result Patterns**: Where applicable, especially in shared packages dealing with asynchronous operations that can result in success or failure, consider using `Either` or `Result` patterns to explicitly handle potential errors and success states.

## 4. Error Handling

*   **Asynchronous Operations**: Always handle errors in asynchronous operations using `try/catch` blocks, `FutureBuilder` snapshots, or other appropriate mechanisms.

	```dart
    try {
      final data = await someApiService.fetchData();
      // Process data
    } catch (e) {
      // Handle error
      print('Error fetching data: $e');
    }
    ```

*   **User Feedback**: Provide clear and informative feedback to the user when errors occur. Avoid generic error messages.

*   **Logging**: Use a consistent logging mechanism for debugging and error reporting.

## 5. Comments

*   **Purpose**: Use comments to explain *why* a piece of code exists or *what* a complex algorithm does, rather than simply restating *what* the code does (which should be clear from the code itself).
*   **Doc Comments**: Use `///` for documentation comments on public APIs (classes, methods, functions, fields) to generate API documentation.

	```dart
    /// Calculates the sum of two integers.
    ///
    /// Throws [ArgumentError] if either [a] or [b] is negative.
    int add(int a, int b) {
      // ...
    }
    ```

## 6. General Best Practices

*   **Small Functions/Methods**: Keep functions and methods small and focused on a single responsibility.
*   **Avoid Deep Nesting**: Limit nesting levels to improve readability.
*   **Immutability**: Prefer immutable objects where possible, especially for data models.
*   **Generics**: Use generics to write flexible and reusable code.
*   **Clean Code**: Strive for clean, readable, and self-documenting code.

---

**Next:** Learn about the testing workflow in `05-testing-workflow.md`.
