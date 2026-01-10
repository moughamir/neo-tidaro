---
created_date: 07/09/2025
updated_date: 20/11/2025
---
# Changelog

All notable changes to the Neo-Tidaro project will be documented in this file.

## [0.1.0-pre-alpha.3] - 2025-09-13

### Fixed
- **Publishing Issues**: Resolved several warnings and errors that prevented publishing the package.
- **LICENSE**: Added a `LICENSE` file to the root of the project.
- **Directory Structure**: Renamed `examples` directory to `example` to align with pub.dev conventions.
- **pubspec.yaml**:
  - Added `homepage` and `repository` fields.
  - Loosened dependency constraints to allow for more flexible versioning.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.1.0-pre-alpha.1] - 2025-09-05

### Added
- **Comprehensive Platform Support**: Added support for all Flutter platforms (Android, iOS, Linux, macOS, Web, Windows)
- **Platform-Specific Melos Scripts**:
  - Run commands for each app on all platforms (`melos run run:tidaro:android`, etc.)
  - Build commands for production releases (`melos run build:android`, etc.)
  - Web apps configured with separate ports (8080, 8081, 8082)
- **Platform Support Documentation**: Created comprehensive guide at `documentation/05-platform-support.md`
- **Workspace Configuration**: Added platform declarations in workspace `pubspec.yaml`

### Changed
- **Version Alignment**: Updated all app versions to `0.1.0-pre-alpha.1+1` for consistent release management
- **Melos Configuration**: Enhanced with platform-specific commands and build scripts

### Technical Details
- **Architecture**: Leverages existing platform folders in all apps (android/, ios/, linux/, macos/, web/, windows/)
- **Development Approach**: Enables "write once, run everywhere" Flutter development
- **Material Design**: Consistent UI across all platforms with platform-specific adaptations

### Breaking Changes
- None

### Migration Guide
- No migration required for existing code
- New platform-specific run commands available via Melos
- Existing Linux-only example runners remain unchanged for development

### Known Issues
- Some analysis warnings in example test files (non-blocking)
- Flutter secure storage dependency version constraints in some packages

### Next Steps
- Alpha release planning
- Platform-specific testing and optimization
- UI/UX enhancements for different form factors
