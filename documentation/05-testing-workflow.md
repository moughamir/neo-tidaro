---
created_date: 07/09/2025
updated_date: 20/11/2025
---
# 5. Testing Workflow

Testing is an integral part of the development process in the Tidaro monorepo. Each package should maintain its own set of tests to ensure the reliability and correctness of its features. This guide outlines the testing workflow and best practices.

## 1. Test Directory Structure

Every Dart/Flutter package within the `packages/` directory (and applications in `apps/`) should have a `test/` directory at its root. This directory will contain all the test files for that specific package.

```
my_package/
├── lib/
│   └── src/
│       └── my_feature.dart
└── test/
    └── my_feature_test.dart
```

## 2. Running Tests

### Running All Tests in a Package

To run all tests within a specific package, navigate to that package's root directory and use the `flutter test` command (for Flutter packages) or `dart test` (for pure Dart packages).

```bash
cd packages/my_package
flutter test
# or for pure Dart packages
# dart test
```

### Running Specific Test Files

You can run tests from a specific file by providing the file path:

```bash
cd packages/my_package
flutter test test/my_feature_test.dart
```

### Running Specific Tests within a File

To run a specific test or group of tests, you can use the `-n` (name) option with a regular expression:

```bash
flutter test test/my_feature_test.dart -n "MyFeatureService should return data"
```

### Running Tests from the Monorepo Root

While it's generally recommended to run tests from within the package directory for isolation, you can also use Melos to run tests across multiple packages or the entire workspace. This is particularly useful for CI/CD.

Melos allows you to define scripts in `melos.yaml` to run commands in parallel across packages. For example, to run tests in all packages:

```yaml
# In melos.yaml
scripts:
  test:
    run: flutter test
    packages: '*' # Run in all packages
```

Then, from the monorepo root:

```bash
melos run test
```

## 3. Types of Tests

*   **Unit Tests**: Test individual functions, methods, or classes in isolation, without external dependencies.
*   **Widget Tests**: Test a single widget or a small widget tree, ensuring its UI and interactions behave as expected.
*   **Integration Tests**: Test the interaction between multiple parts of the application, often spanning across different packages or involving external services (mocked or real).

## 4. Best Practices

*   **Testable Code**: Write code with testability in mind. Use dependency injection to easily mock dependencies.
*   **Clear Test Names**: Give your tests descriptive names that clearly indicate what they are testing.
*   **Arrange-Act-Assert (AAA)**: Structure your tests using the AAA pattern:
	*   **Arrange**: Set up the test environment and data.
	*   **Act**: Perform the action you want to test.
	*   **Assert**: Verify the expected outcome.
*   **Mocking**: Use mocking libraries (e.g., `mockito`) to isolate units under test from their dependencies.
*   **Coverage**: Strive for good test coverage, especially for critical business logic.

## 5. CI/CD Integration

The project's CI/CD pipelines (e.g., `.github/workflows/melos-ci.yml`) include steps to automatically run tests and analysis checks. This ensures that all pushed code adheres to quality standards.

Typical CI/CD steps include:

1.  `melos bootstrap`
2.  `flutter analyze` (for linting and static analysis)
3.  `flutter test` (to run all tests)

---

**Next:** Understand how Supabase is integrated into the project in `06-supabase-integration.md`.
