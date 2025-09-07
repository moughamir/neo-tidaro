import 'package:flutter/material.dart';
import 'palette.dart';
import 'typography.dart';

/// A comprehensive theme system with DRY principles,
/// independent color palette, and typography system.
class AppTheme {
  // Static themes for direct usage
  static ThemeData get lightTheme => _buildTheme(ThemeMode.light);
  static ThemeData get darkTheme => _buildTheme(ThemeMode.dark);

  // Core theme builder
  static ThemeData _buildTheme(ThemeMode mode) {
    final palette = TidaroColorPalette.forMode(mode);
    final typography = TidaroTypography.forPalette(palette);

    return ThemeData(
      useMaterial3: true,
      colorScheme: palette.toColorScheme(),
      textTheme: typography.textTheme,
      appBarTheme: _buildAppBarTheme(palette),
      cardTheme: _buildCardTheme(palette),
      elevatedButtonTheme: _buildElevatedButtonTheme(palette),
      outlinedButtonTheme: _buildOutlinedButtonTheme(palette),
      inputDecorationTheme: _buildInputTheme(palette, typography),
      tooltipTheme: _buildTooltipTheme(palette, typography),
      brightness: mode == ThemeMode.light ? Brightness.light : Brightness.dark,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  // Component theme builders
  static AppBarTheme _buildAppBarTheme(TidaroColorPalette palette) {
    return AppBarTheme(
      backgroundColor: palette.background,
      foregroundColor: palette.onBackground,
      elevation: 0,
      centerTitle: false,
    );
  }

  static CardThemeData _buildCardTheme(TidaroColorPalette palette) {
    return CardThemeData(
      color: palette.surface,
      shadowColor: palette.shadow,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: Clip.antiAlias,
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    TidaroColorPalette palette,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: palette.primary,
        foregroundColor: palette.onPrimary,
        minimumSize: const Size(88, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
    TidaroColorPalette palette,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: palette.primary,
        side: BorderSide(color: palette.primary),
        minimumSize: const Size(88, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  static InputDecorationTheme _buildInputTheme(
    TidaroColorPalette palette,
    TidaroTypography typography,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: palette.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: palette.error, width: 2),
      ),
      labelStyle: typography.body2,
      hintStyle: typography.body2.copyWith(
        color: palette.onSurface.withValues(alpha: 0.6),
      ),
    );
  }

  static TooltipThemeData _buildTooltipTheme(
    TidaroColorPalette palette,
    TidaroTypography typography,
  ) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: palette.inverseSurface,
        borderRadius: BorderRadius.circular(6),
      ),
      textStyle: typography.caption.copyWith(color: palette.onInverseSurface),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    );
  }
}
