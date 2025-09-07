# 7. Internationalization (i18n) and Localization (l10n)

The Tidaro platform is designed with a strong emphasis on multi-language accessibility, targeting a global market with a particular focus on Morocco. This guide outlines the project's approach to internationalization and localization.

## 1. Core Principle: Multi-Language Accessibility

Our primary goal is to provide a seamless and inclusive user experience for a diverse user base. This includes supporting:

*   **Arabic**
*   **Tifinagh** (Neo-Tifinagh, for Berber languages)
*   **Berber Latin** (Latin script for Berber languages)
*   **English**
*   **French**

This commitment extends beyond simple text translation to include considerations for date formats, number formats, currency, and right-to-left (RTL) text direction where applicable.

## 2. Implementation Strategy

While the specific implementation details (e.g., choice of Flutter localization package like `flutter_localizations`, `easy_localization`, or `flutter_gen_l10n`) will be managed within the `languist` package or similar, the general strategy involves:

*   **Centralized String Management**: All user-facing strings should be extracted into a centralized location (e.g., ARB files, JSON files) rather than being hardcoded in widgets.

*   **Contextual Translations**: Provide context to translators where necessary to ensure accurate and appropriate translations, especially for phrases that might have multiple meanings.

*   **Plurals and Genders**: Implement proper handling for plural forms and grammatical genders, which vary significantly across languages.

*   **Date, Time, and Number Formatting**: Utilize Flutter's built-in internationalization capabilities or a dedicated package to format dates, times, and numbers according to the user's locale.

*   **Right-to-Left (RTL) Support**: For languages like Arabic, ensure that the UI layout correctly adapts to right-to-left text direction. This includes mirroring layouts, icons, and text alignment.

## 3. `languist` Package

The `packages/languist/` directory is designated for handling language-related functionalities. This package will likely contain:

*   **Localization Delegates**: Classes responsible for loading localized resources.
*   **Translation Utilities**: Helper functions or extensions for accessing translated strings.
*   **Locale Management**: Logic for managing the user's selected language and persisting it.
*   **Font Management**: Potentially, logic to handle different fonts required for specific scripts (e.g., Tifinagh).

Developers should primarily interact with the `languist` package's public API to retrieve localized strings and manage language settings, rather than implementing localization logic directly in their features.

## 4. Adding New Languages or Strings

To add support for a new language or to introduce new translatable strings:

1.  **Define Strings**: Add new keys and their default (e.g., English) values to the primary localization file (e.g., `app_en.arb`).
2.  **Translate**: Provide translations for the new keys in all supported language files (e.g., `app_ar.arb`, `app_fr.arb`, etc.).
3.  **Generate Code**: Run the necessary code generation command (e.g., `flutter gen-l10n` or a custom script within `languist`) to update the generated localization classes.
4.  **Test**: Verify that the new strings are displayed correctly in all supported languages and that RTL layouts adapt as expected.

## 5. Cultural Sensitivity

Beyond mere translation, it's important to consider cultural nuances. This includes:

*   **Imagery**: Ensure that images and icons are culturally appropriate and universally understood.
*   **Color Meanings**: Be aware that colors can have different meanings across cultures.
*   **User Experience**: Design the user experience to be intuitive and respectful of cultural expectations.

By adhering to these guidelines, we aim to create a truly accessible and user-friendly application for our diverse global audience.
