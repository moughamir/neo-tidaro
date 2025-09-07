import 'package:flutter/material.dart';

/// Independent color palette system with semantic naming
class TidaroColorPalette {
  // Core colors
  final Color primary;
  final Color onPrimary;
  final Color secondary;
  final Color onSecondary;
  final Color tertiary;
  final Color onTertiary;

  // Surface colors
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color inverseSurface;
  final Color onInverseSurface;

  // State colors
  final Color error;
  final Color onError;
  final Color success;
  final Color onSuccess;
  final Color warning;
  final Color onWarning;
  final Color info;
  final Color onInfo;

  // Utility colors
  final Color outline;
  final Color shadow;
  final Color scrim;

  // Accessibility
  final Color focusColor;
  final Color hoverColor;
  final Color pressedColor;

  // Constructor
  const TidaroColorPalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.onSecondary,
    required this.tertiary,
    required this.onTertiary,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.inverseSurface,
    required this.onInverseSurface,
    required this.error,
    required this.onError,
    required this.success,
    required this.onSuccess,
    required this.warning,
    required this.onWarning,
    required this.info,
    required this.onInfo,
    required this.outline,
    required this.shadow,
    required this.scrim,
    required this.focusColor,
    required this.hoverColor,
    required this.pressedColor,
  });

  // Factory for creating theme mode-specific palettes
  factory TidaroColorPalette.forMode(ThemeMode mode) {
    return mode == ThemeMode.light
        ? TidaroColorPalette.light()
        : TidaroColorPalette.dark();
  }

  // Light theme palette
  factory TidaroColorPalette.light() {
    return const TidaroColorPalette(
      // Core colors
      primary: Color(0xFF1C2C4C), // Deep navy blue
      onPrimary: Colors.white,
      secondary: Color(0xFF3AAFA9), // Teal
      onSecondary: Colors.white,
      tertiary: Color(0xFF9381FF), // Purple
      onTertiary: Colors.white,

      // Surface colors
      background: Color(0xFFF9FAFB),
      onBackground: Color(0xFF111827),
      surface: Color(0xFFFFFFFF),
      onSurface: Color(0xFF111827),
      inverseSurface: Color(0xFF111827),
      onInverseSurface: Color(0xFFF9FAFB),

      // State colors
      error: Color(0xFFE53E3E),
      onError: Colors.white,
      success: Color(0xFF10B981),
      onSuccess: Colors.white,
      warning: Color(0xFFF59E0B),
      onWarning: Color(0xFF111827),
      info: Color(0xFF3B82F6),
      onInfo: Colors.white,

      // Utility colors
      outline: Color(0xFFE2E8F0),
      shadow: Color(0x33000000),
      scrim: Color(0x99000000),

      // Accessibility
      focusColor: Color(0x1F3AAFA9),
      hoverColor: Color(0x0A000000),
      pressedColor: Color(0x1F000000),
    );
  }

  // Dark theme palette
  factory TidaroColorPalette.dark() {
    return const TidaroColorPalette(
      // Core colors
      primary: Color(0xFF3A8EF7), // Bright blue for dark theme
      onPrimary: Colors.white,
      secondary: Color(0xFF4ECDC4), // Brighter teal for dark theme
      onSecondary: Color(0xFF111827),
      tertiary: Color(0xFFB39DDB), // Lighter purple for dark theme
      onTertiary: Color(0xFF111827),

      // Surface colors
      background: Color(0xFF1F2937),
      onBackground: Color(0xFFF9FAFB),
      surface: Color(0xFF2D3748),
      onSurface: Color(0xFFF9FAFB),
      inverseSurface: Color(0xFFF9FAFB),
      onInverseSurface: Color(0xFF111827),

      // State colors
      error: Color(0xFFF87171),
      onError: Color(0xFF111827),
      success: Color(0xFF34D399),
      onSuccess: Color(0xFF111827),
      warning: Color(0xFFFBBF24),
      onWarning: Color(0xFF111827),
      info: Color(0xFF60A5FA),
      onInfo: Color(0xFF111827),

      // Utility colors
      outline: Color(0xFF4B5563),
      shadow: Color(0x66000000),
      scrim: Color(0xBF000000),

      // Accessibility
      focusColor: Color(0x4D4ECDC4),
      hoverColor: Color(0x0AFFFFFF),
      pressedColor: Color(0x1FFFFFFF),
    );
  }

  // Convert to Flutter's ColorScheme
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: onSurface.computeLuminance() > 0.5
          ? Brightness.dark
          : Brightness.light,
      primary: primary,
      onPrimary: onPrimary,
      secondary: secondary,
      onSecondary: onSecondary,
      tertiary: tertiary,
      onTertiary: onTertiary,
      error: error,
      onError: onError,

      surface: surface,
      onSurface: onSurface,
      outline: outline,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: onInverseSurface,
    );
  }
}
