---
title: README
aliases: []
tags: []
created: '2025-09-07'
updated: '2025-11-20'
status: in_progress
---

# Languist - Comprehensive Localization Package

Languist is a comprehensive Flutter localization package designed to serve as the main l10n source for multiple projects. It provides extensive translations across 4 languages with over 140 common UI strings, making it perfect for rapid application development.

## Features

- **Multi-language Support**: English (en), Arabic (ar), Spanish (es), French (fr)
- **Comprehensive String Coverage**: 140+ UI strings covering all common use cases
- **Configuration-driven**: Uses `languist.yaml` for flexible configuration
- **Easy Integration**: Simple API for accessing localized strings
- **Production Ready**: Fully tested and optimized for performance

## Supported Languages

| Language | Code | Status | Coverage |
|----------|------|--------|----------|
| English | `en` | ✅ Complete | 100% |
| Arabic | `ar` | ✅ Complete | 100% |
| Spanish | `es` | ✅ Complete | 100% |
| French | `fr` | ✅ Complete | 100% |

## String Categories

The package includes translations for:

### Core Actions
- Basic actions: OK, Cancel, Save, Delete, Edit, Add, Create, Update, etc.
- Navigation: Back, Next, Previous, Continue, Skip, Done, Finish
- Confirmation: Yes, No, Confirm, Retry, Refresh

### Navigation & UI
- Main navigation: Home, Profile, Settings, About, Help, Contact
- Advanced navigation: Dashboard, Notifications, Search, Filter, Sort
- Settings categories: Theme Settings, Language Settings, Privacy, Security

### Authentication & Forms
- Authentication: Login, Logout, Register, Sign Up, Sign In
- Password management: Forgot Password, Reset Password, Change Password
- Form fields: Email, Password, Username, Name, Phone, Address, etc.

### Status & Feedback
- Loading states: Loading, Saving, Processing, Uploading, Downloading
- Status messages: Success, Error, Warning, Info
- Error handling: Network Error, Connection Error, Server Error
- Validation: Required, Invalid Email, Password Too Short, etc.

### Time & Dates
- Relative time: Just Now, Minutes Ago, Hours Ago, Days Ago, etc.
- Date references: Today, Yesterday, Tomorrow, This Week, Last Month
- Extended time periods: Weeks Ago, Months Ago, Years Ago

### System & Metadata
- App information: Version, Build Number, Copyright
- Legal: Terms of Service, Privacy Policy, Licenses
- Actions: Share, Copy, Paste, Cut, Select All, Undo, Redo

## Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  languist:
    path: ../packages/languist  # Adjust path as needed
```

## Usage

### Basic Setup

1. **Import the package**:
```dart
import 'package:languist/languist.dart';
```

2. **Configure your app**:
```dart
MaterialApp(
  localizationsDelegates: Languist.localizationsDelegates,
  supportedLocales: Languist.supportedLocales,
  // ... other configuration
)
```

3. **Use localized strings**:
```dart
// Simple strings
Text(Languist.of(context).hello)
Text(Languist.of(context).welcome)

// Strings with parameters
Text(Languist.of(context).helloUser('John'))
Text(Languist.of(context).minutesAgo(5))
Text(Languist.of(context).itemCount(42))
```

### Common Usage Examples

#### Authentication Flow
```dart
ElevatedButton(
  onPressed: () => login(),
  child: Text(Languist.of(context).login),
)

TextFormField(
  decoration: InputDecoration(
    labelText: Languist.of(context).email,
    errorText: isEmailValid ? null : Languist.of(context).invalidEmail,
  ),
)
```

#### Navigation
```dart
AppBar(
  title: Text(Languist.of(context).settings),
  leading: IconButton(
    icon: Icon(Icons.arrow_back),
    onPressed: () => Navigator.pop(context),
    tooltip: Languist.of(context).back,
  ),
)
```

#### Status Messages
```dart
// Loading state
if (isLoading)
  Text(Languist.of(context).loading)

// Error handling
if (hasError)
  Text(Languist.of(context).networkError)

// Success feedback
SnackBar(
  content: Text(Languist.of(context).success),
)
```

#### Time Display
```dart
// Relative time
Text(Languist.of(context).minutesAgo(30))
Text(Languist.of(context).hoursAgo(2))
Text(Languist.of(context).daysAgo(5))

// Date references
Text(Languist.of(context).today)
Text(Languist.of(context).yesterday)
```

## Configuration

The package uses `languist.yaml` for configuration:

```yaml
# languist.yaml
arb-dir: lib/l10n
template-arb-file: intl_en.arb
output-localization-file: intl_localizations.dart
output-class: IntlLocalizations
output-dir: lib/l10n/gen
no-nullable-getter: true
```

## Available Strings

### Core Actions
- `ok`, `cancel`, `save`, `delete`, `edit`, `add`, `create`, `update`
- `remove`, `close`, `open`, `submit`, `confirm`, `yes`, `no`
- `retry`, `refresh`, `back`, `next`, `previous`, `continue`
- `skip`, `done`, `finish`

### Navigation
- `home`, `profile`, `settings`, `about`, `help`, `contact`
- `dashboard`, `notifications`, `search`, `filter`, `sort`

### Authentication
- `login`, `logout`, `register`, `signUp`, `signIn`
- `forgotPassword`, `resetPassword`, `changePassword`

### Form Fields
- `email`, `password`, `username`, `name`, `firstName`, `lastName`
- `phone`, `address`, `city`, `country`, `dateOfBirth`

### Status & Loading
- `loading`, `saving`, `processing`, `uploading`, `downloading`
- `connecting`, `syncing`, `success`, `error`, `warning`, `info`

### Validation
- `required`, `invalidEmail`, `passwordTooShort`, `passwordsDoNotMatch`
- `invalidPhoneNumber`, `fieldRequired`

### Time & Dates
- `justNow`, `aMinuteAgo`, `minutesAgo(int)`, `anHourAgo`, `hoursAgo(int)`
- `aDayAgo`, `daysAgo(int)`, `aWeekAgo`, `weeksAgo(int)`
- `aMonthAgo`, `monthsAgo(int)`, `aYearAgo`, `yearsAgo(int)`
- `today`, `yesterday`, `tomorrow`, `thisWeek`, `lastWeek`, `nextWeek`

### Counts & Quantities
- `itemCount(int)`, `selectedCount(int)`, `totalCount(int)`

## Development

### Adding New Strings

1. Add the new string to `lib/l10n/intl_en.arb` (English template)
2. Add translations to all other ARB files
3. Run the generation script: `melos run gen:l10n`
4. Update this documentation

### Adding New Languages

1. Create a new ARB file: `lib/l10n/intl_[locale].arb`
2. Copy the structure from `intl_en.arb`
3. Translate all strings to the target language
4. Run the generation script: `melos run gen:l10n`

## Integration with UI Kit

This package integrates seamlessly with the UI Kit package:

```dart
// In ui_kit package
class AppLocalizations {
  static IntlLocalizations of(BuildContext context) {
    return Languist.of(context);
  }
  
  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates {
    return Languist.localizationsDelegates;
  }
  
  static List<Locale> get supportedLocales {
    return Languist.supportedLocales;
  }
}
```

## Best Practices

1. **Consistent Usage**: Always use `Languist.of(context)` for accessing strings
2. **Parameter Validation**: Validate parameters before passing to parameterized strings
3. **Fallback Handling**: Handle cases where localization context might not be available
4. **Performance**: Cache frequently used strings when appropriate
5. **Testing**: Test all supported languages in your application

## Contributing

When contributing new strings or translations:

1. Ensure all languages are updated consistently
2. Follow the existing naming conventions
3. Add appropriate descriptions in ARB files
4. Test the generation process
5. Update documentation

## License

This package is part of the Neo-Tidaro project and follows the same licensing terms.