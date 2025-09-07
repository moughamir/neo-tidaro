import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A class that provides mocked font functionality for tests
class FontMocks {
  /// Initialize font mocking for tests
  /// Should be called in setUp of the test
  static void initMockFonts() {
    // Disable Google Fonts from fetching from the web
    GoogleFonts.config.allowRuntimeFetching = false;
  }
  
  /// Gets a default TextStyle that doesn't depend on Google Fonts
  /// Use this instead of GoogleFonts methods in tests
  static TextStyle getMockTextStyle({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? height,
    TextDecoration? decoration,
    FontStyle? fontStyle,
    double? letterSpacing,
    TextLeadingDistribution? leadingDistribution,
  }) {
    return TextStyle(
      fontFamily: 'Roboto', // Default test font
      package: null,
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      decoration: decoration,
      fontStyle: fontStyle,
      letterSpacing: letterSpacing,
    );
  }
}

// Extension method to simplify TextTheme creation in tests
extension TextThemeTestExtensions on TextTheme {
  /// Creates a mock TextTheme for testing without Google Fonts
  static TextTheme mockTextTheme(Color textColor) {
    return TextTheme(
      displayLarge: FontMocks.getMockTextStyle(fontSize: 57.0, fontWeight: FontWeight.normal, color: textColor),
      displayMedium: FontMocks.getMockTextStyle(fontSize: 45.0, fontWeight: FontWeight.normal, color: textColor),
      displaySmall: FontMocks.getMockTextStyle(fontSize: 36.0, fontWeight: FontWeight.normal, color: textColor),
      headlineLarge: FontMocks.getMockTextStyle(fontSize: 32.0, fontWeight: FontWeight.normal, color: textColor),
      headlineMedium: FontMocks.getMockTextStyle(fontSize: 28.0, fontWeight: FontWeight.normal, color: textColor),
      headlineSmall: FontMocks.getMockTextStyle(fontSize: 24.0, fontWeight: FontWeight.normal, color: textColor),
      titleLarge: FontMocks.getMockTextStyle(fontSize: 22.0, fontWeight: FontWeight.w500, color: textColor),
      titleMedium: FontMocks.getMockTextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: textColor),
      titleSmall: FontMocks.getMockTextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: textColor),
      bodyLarge: FontMocks.getMockTextStyle(fontSize: 16.0, fontWeight: FontWeight.normal, color: textColor),
      bodyMedium: FontMocks.getMockTextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: textColor),
      bodySmall: FontMocks.getMockTextStyle(fontSize: 12.0, fontWeight: FontWeight.normal, color: textColor),
      labelLarge: FontMocks.getMockTextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: textColor),
      labelMedium: FontMocks.getMockTextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: textColor),
      labelSmall: FontMocks.getMockTextStyle(fontSize: 11.0, fontWeight: FontWeight.w500, color: textColor),
    );
  }
}
