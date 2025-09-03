import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _lightColorScheme,
    textTheme: _buildTextTheme(_lightColorScheme),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: _darkColorScheme,
    textTheme: _buildTextTheme(_darkColorScheme),
  );

  static const ColorScheme _lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF1C2C4C), // Primary
    onPrimary: Colors.white,
    secondary: Color(0xFF3AAFA9), // Secondary
    onSecondary: Colors.white,
    error: Color(0xFFE53E3E), // Error
    onError: Colors.white,
    surface: Color(0xFFF9FAFB), // Background
    onSurface: Color(0xFF111827),
  );

  static const ColorScheme _darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF1C2C4C), // Primary (can be adjusted for dark mode)
    onPrimary: Colors.white,
    secondary: Color(0xFF3AAFA9), // Secondary (can be adjusted for dark mode)
    onSecondary: Colors.white,
    error: Color(0xFFE53E3E), // Error
    onError: Colors.white,

    surface: Color(0xFF2D3748), // Darker surface
    onSurface: Color(0xFFF9FAFB),
  );

  static TextTheme _buildTextTheme(ColorScheme colorScheme) {
    final baseTextStyle = GoogleFonts.notoSans(color: colorScheme.onSurface);
    final arabicTextStyle = GoogleFonts.notoSansArabic(
      color: colorScheme.onSurface,
    );
    final tifinaghTextStyle = GoogleFonts.notoSansTifinagh(
      color: colorScheme.onSurface,
    );

    return TextTheme(
      displayLarge: baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: colorScheme.primary,
      ),
      displayMedium: baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w500,
        color: colorScheme.secondary,
      ),
      bodyLarge: baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      bodyMedium: baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: colorScheme.onSurface,
      ),
      bodySmall: baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w300,
        color: colorScheme.onSurface,
      ),
      // You can define more text styles and apply specific fonts as needed
      // For example, for Arabic text:
      headlineMedium: arabicTextStyle.copyWith(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
      // For Tifinagh text:
      headlineSmall: tifinaghTextStyle.copyWith(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: colorScheme.onSurface,
      ),
    );
  }
}
