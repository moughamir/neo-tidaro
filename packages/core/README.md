# Core Package

A foundational package for Neo-Tidaro applications that provides essential utilities, services, and abstractions following clean architecture principles.

## Features

- **Supabase Integration**: Comprehensive service for authentication, database operations, storage, realtime subscriptions, and edge functions
- **Functional Error Handling**: Type-safe error handling using `Either<Failure, T>` pattern with `fpdart`
- **Logging System**: Structured logging with `KuiVerb` utility supporting multiple log levels
- **Configuration Management**: Environment-specific configuration with `AppConfig`
- **Dependency Injection**: Service locator pattern using `GetIt` for loose coupling
- **Clean Architecture**: Abstract interfaces for services enabling testability and maintainability

## Architecture

The package follows clean architecture principles with clear separation of concerns:

```
lib/
├── config/           # Configuration management
├── di/              # Dependency injection setup
├── network/         # Network layer with services and interfaces
│   ├── interfaces/  # Abstract service interfaces
│   └── supabase_service.dart
└── utils/           # Utilities (logging, error handling, type definitions)
```

## Usage

### Basic Setup

```dart
import 'package:core/core.dart';

// Initialize services
await setupServiceLocator();

// Access services
final supabaseService = getIt<SupabaseService>();
```

### Configuration

```dart
// Set up environment-specific configuration
appConfig = AppConfig.development(); // or .staging() / .production()

// Initialize Supabase
await SupabaseService.init(
  appConfig.supabaseUrl,
  appConfig.supabaseAnonKey,
);
```

### Authentication

```dart
final authService = getIt<AuthService>();

// Sign up
final result = await authService.signUpWithPassword(
  email: 'user@example.com',
  password: 'password123',
);

result.fold(
  (failure) => print('Error: ${failure.message}'),
  (user) => print('User created: ${user.email}'),
);
```

### Database Operations

```dart
final dbService = getIt<DatabaseService>();

// Fetch data
final result = await dbService.getTableData(
  table: 'users',
  equals: {'status': 'active'},
  orderBy: 'created_at',
  limit: 10,
);
```

### Storage Operations

```dart
final storageService = getIt<StorageService>();

// Upload file
final result = await storageService.uploadFile(
  bucket: 'avatars',
  path: 'user-123/avatar.jpg',
  file: File('path/to/image.jpg'),
);
```

### Error Handling

The package uses functional error handling with `Either<Failure, T>`:

```dart
final result = await someOperation();

result.fold(
  (failure) {
    switch (failure.type) {
      case FailureType.server:
        // Handle server error
        break;
      case FailureType.auth:
        // Handle authentication error
        break;
      case FailureType.network:
        // Handle network error
        break;
    }
  },
  (success) {
    // Handle success
  },
);
```

### Logging

```dart
import 'package:core/core.dart';

KuiVerb.info('Operation completed successfully');
KuiVerb.error('Something went wrong', error: exception);
KuiVerb.debug('Debug information', tag: 'MyService');
```

## Dependencies

- `supabase_flutter`: Supabase client for Flutter
- `fpdart`: Functional programming utilities
- `get_it`: Service locator for dependency injection
- `equatable`: Value equality for data classes
- `kui_shared`: Shared utilities from workspace

## Integration with Other Packages

This core package is designed to work seamlessly with other workspace packages:

- **kui_shared**: Provides shared utilities and domain models
- **languist**: Internationalization support
- **ui_kit**: UI components that can consume core services

## Best Practices

1. **Use Interfaces**: Always depend on abstractions (`AuthService`, `DatabaseService`) rather than concrete implementations
2. **Error Handling**: Use the `Result<T>` pattern for operations that can fail
3. **Logging**: Use `KuiVerb` for consistent logging across the application
4. **Configuration**: Use `AppConfig` for environment-specific settings
5. **Dependency Injection**: Register services in `service_locator.dart` and access via `getIt<T>()`

## Development

### Running Tests

```bash
flutter test
```

### Code Generation

```bash
flutter packages pub run build_runner build
```

### Linting

```bash
flutter analyze
```

## Contributing

Follow the established patterns and ensure all new features include:
- Proper error handling with `Result<T>`
- Comprehensive logging
- Unit tests
- Interface abstractions where appropriate
