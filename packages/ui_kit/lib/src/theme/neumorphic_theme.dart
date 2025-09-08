import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// A theme helper class that provides standardized neumorphic styling
///
/// This class provides constants and helper methods for creating consistent
/// neumorphic UI elements across the application.
class NeumorphicTheme {
  /// Cannot be instantiated
  NeumorphicTheme._();

  /// Default background color for light theme
  static const Color lightBackground = Color(0xFFE0E5EC);

  /// Default background color for dark theme
  static const Color darkBackground = Color(0xFF303234);

  /// Default text color for light theme
  static const Color lightTextColor = Color(0xFF2D3748);

  /// Default text color for dark theme
  static const Color darkTextColor = Color(0xFFEDF2F7);

  /// Default accent color
  static const Color accentColor = Color(0xFF4299E1);

  /// Default border radius for components
  static const double borderRadius = 16.0;

  /// Default distance for shadows
  static const double distance = 8.0;

  /// Default intensity for shadows (0.0 to 1.0)
  static const double intensity = 0.5;

  /// Creates default text theme with Google Fonts
  static TextTheme createTextTheme(bool isDark) {
    final baseTextTheme = GoogleFonts.robotoTextTheme();
    final textColor = isDark ? darkTextColor : lightTextColor;

    return baseTextTheme.copyWith(
      displayLarge: baseTextTheme.displayLarge?.copyWith(color: textColor),
      displayMedium: baseTextTheme.displayMedium?.copyWith(color: textColor),
      displaySmall: baseTextTheme.displaySmall?.copyWith(color: textColor),
      headlineLarge: baseTextTheme.headlineLarge?.copyWith(color: textColor),
      headlineMedium: baseTextTheme.headlineMedium?.copyWith(color: textColor),
      headlineSmall: baseTextTheme.headlineSmall?.copyWith(color: textColor),
      titleLarge: baseTextTheme.titleLarge?.copyWith(color: textColor),
      titleMedium: baseTextTheme.titleMedium?.copyWith(color: textColor),
      titleSmall: baseTextTheme.titleSmall?.copyWith(color: textColor),
      bodyLarge: baseTextTheme.bodyLarge?.copyWith(color: textColor),
      bodyMedium: baseTextTheme.bodyMedium?.copyWith(color: textColor),
      bodySmall: baseTextTheme.bodySmall?.copyWith(color: textColor),
      labelLarge: baseTextTheme.labelLarge?.copyWith(color: textColor),
      labelMedium: baseTextTheme.labelMedium?.copyWith(color: textColor),
      labelSmall: baseTextTheme.labelSmall?.copyWith(color: textColor),
    );
  }

  /// Creates a neumorphic box decoration for elevated elements
  static BoxDecoration neumorphicBoxDecoration({
    required bool isDark,
    Color? color,
    double radius = borderRadius,
    double intensity = NeumorphicTheme.intensity,
    double distance = NeumorphicTheme.distance,
  }) {
    final backgroundColor =
        color ?? (isDark ? darkBackground : lightBackground);
    final shadowColor = isDark ? Colors.black : Colors.grey[500];
    final highlightColor = isDark ? Colors.grey[800] : Colors.white;

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        // Shadow
        BoxShadow(
          color: shadowColor!.withValues(alpha: intensity),
          offset: Offset(distance / 2, distance / 2),
          blurRadius: distance,
          spreadRadius: 0,
        ),
        // Highlight
        BoxShadow(
          color: highlightColor!.withValues(alpha: intensity),
          offset: Offset(-distance / 2, -distance / 2),
          blurRadius: distance,
          spreadRadius: 0,
        ),
      ],
    );
  }

  /// Creates a neumorphic box decoration for inset/pressed elements
  static BoxDecoration neumorphicInsetBoxDecoration({
    required bool isDark,
    Color? color,
    double radius = borderRadius,
    double intensity = NeumorphicTheme.intensity,
    double distance = NeumorphicTheme.distance,
  }) {
    final backgroundColor =
        color ?? (isDark ? darkBackground : lightBackground);
    final shadowColor = isDark ? Colors.black : Colors.grey[500];
    final highlightColor = isDark ? Colors.grey[800] : Colors.white;

    return BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        // Inner Shadow
        BoxShadow(
          color: shadowColor!.withValues(alpha: intensity),
          offset: Offset(-distance / 2, -distance / 2),
          blurRadius: distance,
          spreadRadius: 0,
        ),
        // Inner Highlight
        BoxShadow(
          color: highlightColor!.withValues(alpha: intensity),
          offset: Offset(distance / 2, distance / 2),
          blurRadius: distance,
          spreadRadius: 0,
        ),
      ],
    );
  }

  /// Creates a Material ThemeData using neumorphic styling
  static ThemeData createThemeData({bool isDark = false}) {
    final backgroundColor = isDark ? darkBackground : lightBackground;
    final textColor = isDark ? darkTextColor : lightTextColor;

    return ThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      scaffoldBackgroundColor: backgroundColor,
      primaryColor: accentColor,
      colorScheme: ColorScheme(
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: accentColor,
        onPrimary: Colors.white,
        secondary: accentColor.withValues(alpha: 0.8),
        onSecondary: Colors.white,
        error: Colors.redAccent,
        onError: Colors.white,

        surface: backgroundColor,
        onSurface: textColor,
      ),
      textTheme: createTextTheme(isDark),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: backgroundColor,
      ),
      cardTheme: CardThemeData(
        color: backgroundColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
