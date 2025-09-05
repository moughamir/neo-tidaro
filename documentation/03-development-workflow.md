
# Development & Testing Workflow

This document describes the development and testing workflow for the Tidaro workspace.

## Setup

To set up the development environment, follow these steps:

1.  Install the Flutter SDK (latest stable version).
2.  Install the Dart SDK (latest stable version).
3.  Install Melos.
4.  Run `melos bootstrap` in the root of the workspace to link all the packages.

## Development

To run an app, navigate to the app's directory in the `apps/` directory and run the following command:

```bash
futter run
```

For example, to run the main Tidaro app, you would run the following command:

```bash
cd apps/tidaro
flutter run
```

## Testing

- Unit and widget tests should be written for all packages.
- Each package should maintain its own `test/` directory.
- To run the tests for a package, navigate to the package's directory and run the following command:

```bash
flutter test
```

## CI/CD

The CI/CD pipeline should include the following steps:

1.  `melos bootstrap`
2.  `flutter analyze`
3.  `flutter test`

In the future, the pipeline will be updated to include build and deploy steps for Android, iOS, and Web.
