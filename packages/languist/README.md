# Languist Package

This package provides localization and internationalization (i18n) services for the Tidaro workspace.

## Overview

`languist` is responsible for managing all the strings and translations used in the applications. It uses a code generation approach to create type-safe access to localized strings.

Key features:

-   **Strongly-typed keys:** No more magic strings for translations.
-   **Code generation:** Generates Dart code from YAML translation files.
-   **Multi-language support:** Designed to support Arabic, Tifinagh, Berber Latin, English, and French.

## Usage

To use this package, add it as a dependency in your `pubspec.yaml` file:

```yaml
dependencies:
  languist:
    path: ../../packages/languist
```

To add or update translations, edit the YAML files in the `lib/src/l10n` directory and then run the build runner to regenerate the Dart code:

```bash
melos run build
```
