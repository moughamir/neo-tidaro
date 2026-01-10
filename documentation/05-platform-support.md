---
created_date: 07/09/2025
updated_date: 20/11/2025
---
# Platform Support

This workspace provides comprehensive platform support for all Flutter-supported platforms across all applications.

## Supported Platforms

- **Android** - Mobile platform
- **iOS** - Mobile platform
- **Linux** - Desktop platform
- **macOS** - Desktop platform
- **Web** - Browser platform
- **Windows** - Desktop platform

## Platform Configuration

Platform support is configured at the workspace level in `pubspec.yaml`:

```yaml
platforms:
  android:
  ios:
  linux:
  macos:
  web:
  windows:
```

## Running Applications

### Tidaro (Main App)

```bash
# Android
melos run run:tidaro:android

# iOS
melos run run:tidaro:ios

# Linux Desktop
melos run run:tidaro:linux

# macOS Desktop
melos run run:tidaro:macos

# Web Browser (port 8080)
melos run run:tidaro:web

# Windows Desktop
melos run run:tidaro:windows
```

### Tidaro Mini

```bash
# Android
melos run run:tidaro_mini:android

# iOS
melos run run:tidaro_mini:ios

# Linux Desktop
melos run run:tidaro_mini:linux

# macOS Desktop
melos run run:tidaro_mini:macos

# Web Browser (port 8081)
melos run run:tidaro_mini:web

# Windows Desktop
melos run run:tidaro_mini:windows
```

### Tidash (Admin Dashboard)

```bash
# Android
melos run run:tidash:android

# iOS
melos run run:tidash:ios

# Linux Desktop
melos run run:tidash:linux

# macOS Desktop
melos run run:tidash:macos

# Web Browser (port 8082)
melos run run:tidash:web

# Windows Desktop
melos run run:tidash:windows
```

## Building for Production

### Build All Platforms

```bash
# Android APK
melos run build:android

# iOS App
melos run build:ios

# Web App
melos run build:web

# Linux Desktop
melos run build:linux

# macOS Desktop
melos run build:macos

# Windows Desktop
melos run build:windows
```

## Development Examples

Examples are configured to run on Linux desktop for development:

```bash
# Basic App Example
melos run run:basic_app

# Authentication Flow Example
melos run run:auth_flow

# Redux Showcase Example
melos run run:redux_showcase

# UI Kit Showcase Example
melos run run:ui_kit_showcase
```

## Platform-Specific Considerations

### Mobile Platforms (Android/iOS)
- Requires device or emulator to be connected
- Use `flutter devices` to list available devices
- Material Design components work across all platforms
- Cupertino components provide iOS-native look and feel

### Desktop Platforms (Linux/macOS/Windows)
- Native desktop integration
- Window management and system tray support
- File system access capabilities
- Platform-specific UI adaptations

### Web Platform
- Runs in browser environment
- Different ports assigned to avoid conflicts:
  - Tidaro: 8080
  - Tidaro Mini: 8081
  - Tidash: 8082
- Progressive Web App (PWA) capabilities
- Responsive design considerations

## Architecture Benefits

1. **Unified Codebase**: Single codebase supports all platforms
2. **Consistent UI**: Material Design ensures consistent experience
3. **Shared Business Logic**: Core functionality shared across platforms
4. **Platform Adaptation**: UI adapts to platform conventions
5. **Efficient Development**: Write once, run everywhere approach

## Best Practices

1. **Platform Detection**: Use `Platform.isAndroid`, `Platform.isIOS`, etc. for platform-specific code
2. **Responsive Design**: Implement responsive layouts for different screen sizes
3. **Platform UI Guidelines**: Follow Material Design and platform-specific guidelines
4. **Testing**: Test on all target platforms before release
5. **Performance**: Optimize for each platform's capabilities and constraints
