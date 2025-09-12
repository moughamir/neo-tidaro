import 'package:flutter/material.dart';

/// Centralized design tokens for the Neo-Tidaro design system
///
/// This class provides all design constants, spacing, colors, and effects
/// following DRY principles and supporting both Neumorphism and Glassmorphism
class DesignTokens {
  DesignTokens._();

  // ═══════════════════════════════════════════════════════════════════════════
  // SPACING & SIZING
  // ═══════════════════════════════════════════════════════════════════════════

  /// Base unit for consistent spacing (4px)
  static const double baseUnit = 4.0;

  /// Spacing scale based on base unit
  static const double space1 = baseUnit; // 4px
  static const double space2 = baseUnit * 2; // 8px
  static const double space3 = baseUnit * 3; // 12px
  static const double space4 = baseUnit * 4; // 16px
  static const double space5 = baseUnit * 5; // 20px
  static const double space6 = baseUnit * 6; // 24px
  static const double space8 = baseUnit * 8; // 32px
  static const double space10 = baseUnit * 10; // 40px
  static const double space12 = baseUnit * 12; // 48px
  static const double space16 = baseUnit * 16; // 64px

  /// Border radius scale
  static const double radiusXs = 4.0;
  static const double radiusSm = 6.0;
  static const double radiusMd = 8.0;
  static const double radiusLg = 12.0;
  static const double radiusXl = 16.0;
  static const double radius2xl = 20.0;
  static const double radius3xl = 24.0;
  static const double radiusFull = 9999.0;

  /// Component heights
  static const double buttonHeightSm = 32.0;
  static const double buttonHeightMd = 40.0;
  static const double buttonHeightLg = 48.0;
  static const double inputHeight = 48.0;
  static const double appBarHeight = 56.0;

  // ═══════════════════════════════════════════════════════════════════════════
  // NEUMORPHIC EFFECTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Neumorphic shadow distances
  static const double neuDistanceXs = 2.0;
  static const double neuDistanceSm = 4.0;
  static const double neuDistanceMd = 6.0;
  static const double neuDistanceLg = 8.0;
  static const double neuDistanceXl = 12.0;

  /// Neumorphic blur radii
  static const double neuBlurXs = 4.0;
  static const double neuBlurSm = 6.0;
  static const double neuBlurMd = 8.0;
  static const double neuBlurLg = 12.0;
  static const double neuBlurXl = 16.0;

  /// Neumorphic intensity (opacity multiplier)
  static const double neuIntensitySubtle = 0.3;
  static const double neuIntensityNormal = 0.5;
  static const double neuIntensityStrong = 0.7;

  // ═══════════════════════════════════════════════════════════════════════════
  // GLASSMORPHISM EFFECTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Glass blur effects
  static const double glassBlurLight = 10.0;
  static const double glassBlurMedium = 20.0;
  static const double glassBlurStrong = 40.0;

  /// Glass opacity levels
  static const double glassOpacitySubtle = 0.05;
  static const double glassOpacityLight = 0.1;
  static const double glassOpacityMedium = 0.15;
  static const double glassOpacityStrong = 0.25;

  /// Glass border opacity
  static const double glassBorderOpacity = 0.2;

  // ═══════════════════════════════════════════════════════════════════════════
  // ANIMATION & TRANSITIONS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Animation durations
  static const Duration durationFast = Duration(milliseconds: 150);
  static const Duration durationNormal = Duration(milliseconds: 250);
  static const Duration durationSlow = Duration(milliseconds: 350);
  static const Duration durationSlower = Duration(milliseconds: 500);

  /// Animation curves
  static const Curve curveDefault = Curves.easeInOut;
  static const Curve curveEnter = Curves.easeOut;
  static const Curve curveExit = Curves.easeIn;
  static const Curve curveBounce = Curves.elasticOut;

  // ═══════════════════════════════════════════════════════════════════════════
  // SEMANTIC COLOR TOKENS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Light theme colors
  static const DesignColorTokens light = DesignColorTokens.light();

  /// Dark theme colors
  static const DesignColorTokens dark = DesignColorTokens.dark();

  /// Get color tokens for theme mode
  static DesignColorTokens colorsFor(Brightness brightness) {
    return brightness == Brightness.light ? light : dark;
  }
}

/// Semantic color tokens for consistent theming
class DesignColorTokens {
  final Color background;
  final Color backgroundVariant;
  final Color error;
  final Color focusColor;
  final Color glassBorder;
  final Color glassOverlay;
  final Color hoverColor;
  final Color info;
  final Color inverseSurface;
  final Color neuHighlight;
  final Color neuShadowDark;
  final Color neuShadowLight;
  final Color onBackground;
  final Color onError;
  final Color onInfo;
  final Color onInverseSurface;
  final Color onPrimary;
  final Color onSecondary;
  final Color onSuccess;
  final Color onSurface;
  final Color onSurfaceVariant;
  final Color onTertiary;
  final Color onWarning;
  final Color outline;
  final Color outlineVariant;
  final Color pressedColor;
  final Color primary;
  final Color primaryVariant;
  final Color scrim;
  final Color secondary;
  final Color secondaryVariant;
  final Color shadow;
  final Color success;
  final Color surface;
  final Color surfaceVariant;
  final Color tertiary;
  final Color warning;

  const DesignColorTokens({
    required this.background,
    required this.backgroundVariant,
    required this.error,
    required this.focusColor,
    required this.glassBorder,
    required this.glassOverlay,
    required this.hoverColor,
    required this.info,
    required this.inverseSurface,
    required this.neuHighlight,
    required this.neuShadowDark,
    required this.neuShadowLight,
    required this.onBackground,
    required this.onError,
    required this.onInfo,
    required this.onInverseSurface,
    required this.onPrimary,
    required this.onSecondary,
    required this.onSuccess,
    required this.onSurface,
    required this.onSurfaceVariant,
    required this.onTertiary,
    required this.onWarning,
    required this.outline,
    required this.outlineVariant,
    required this.pressedColor,
    required this.primary,
    required this.primaryVariant,
    required this.scrim,
    required this.secondary,
    required this.secondaryVariant,
    required this.shadow,
    required this.success,
    required this.surface,
    required this.surfaceVariant,
    required this.tertiary,
    required this.warning,
  });

  const DesignColorTokens.light()
    : this(
        background: const Color(0xFFF1F3F5),

        backgroundVariant: const Color(0xFFE9ECEF),
        error: const Color(0xFFE53E3E),

        focusColor: const Color(0x1F3AAFA9),
        glassBorder: const Color(0x33FFFFFF),
        glassOverlay: const Color(0x0FFFFFFF),
        hoverColor: const Color(0x0A000000),
        info: const Color(0xFF3B82F6),

        inverseSurface: const Color(0xFF111827),

        neuHighlight: const Color(0xFFFFFFFF),
        neuShadowDark: const Color(0xFFBEC8D1),
        neuShadowLight: const Color(0xFFFFFFFF),
        onBackground: const Color(0xFF111827),

        onError: const Color(0xFFFFFFFF),

        onInfo: Colors.white,
        onInverseSurface: const Color(0xFFF9FAFB),

        onPrimary: Colors.white,
        onSecondary: const Color(0xFFFFFFFF),

        onSuccess: Colors.white,
        onSurface: const Color(0xFF111827),

        onSurfaceVariant: const Color(0xFF4A4A4A),
        onTertiary: const Color(0xFFFFFFFF),

        onWarning: const Color(0xFF111827),

        outline: const Color(0xFFE2E8F0),

        outlineVariant: const Color(0xFFF1F5F9),
        pressedColor: const Color(0x1F000000),
        primary: const Color(0xFF1C2C4C),

        primaryVariant: const Color(0xFF0F1B2E),

        scrim: const Color(0x99000000),
        secondary: const Color(0xFF3AAFA9),

        secondaryVariant: const Color(0xFF2D8B87),
        shadow: const Color(0x1A000000),

        success: const Color(0xFF10B981),

        surface: const Color(0xFFFEFEFE),

        surfaceVariant: const Color(0xFFF8F9FA),
        tertiary: const Color(0xFF9381FF),

        warning: const Color(0xFFF59E0B),
      );

  const DesignColorTokens.dark()
    : this(
        primary: const Color(0xFF3A8EF7),
        background: const Color(0xFF1F2937),
        backgroundVariant: const Color(0xFF111827),
        error: const Color(0xFFF87171),
        glassBorder: const Color(0x33FFFFFF),
        glassOverlay: const Color(0x0F000000),
        info: const Color(0xFF60A5FA),
        inverseSurface: const Color(0xFFF9FAFB),
        neuHighlight: const Color(0xFF3D4852),
        neuShadowDark: const Color(0xFF000000),
        neuShadowLight: const Color(0xFF3D4852),
        onBackground: const Color(0xFFF9FAFB),
        onError: const Color(0xFF1A1A1A),
        onInfo: const Color(0xFF1A1A1A),
        onInverseSurface: const Color(0xFF1A1A1A),
        onPrimary: const Color(0xFFFFFFFF),
        onSecondary: const Color(0xFF1A1A1A),
        onSuccess: const Color(0xFF1A1A1A),
        onSurface: const Color(0xFFF9FAFB),
        onSurfaceVariant: const Color(0xFFD1D5DB),
        onTertiary: const Color(0xFF1A1A1A),
        onWarning: const Color(0xFF1A1A1A),
        outline: const Color(0xFF4B5563),
        outlineVariant: const Color(0xFF374151),
        primaryVariant: const Color(0xFF2563EB),
        scrim: const Color(0xBF000000),
        secondary: const Color(0xFF4ECDC4),
        secondaryVariant: const Color(0xFF3AAFA9),
        shadow: const Color(0x66000000),
        success: const Color(0xFF34D399),
        surface: const Color(0xFF2D3748),
        surfaceVariant: const Color(0xFF1A202C),
        tertiary: const Color(0xFFB39DDB),
        warning: const Color(0xFFFBBF24),

        focusColor: const Color(0x4D4ECDC4),
        hoverColor: const Color(0x0AFFFFFF),

        pressedColor: const Color(0x1FFFFFFF),
      );

  /// Convert to Flutter ColorScheme
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
