import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'design_tokens.dart';
import 'effects.dart';

/// Unified theme system that replaces all existing theme implementations
///
/// Consolidates NeumorphicTheme, AppTheme, and TidaroColorPalette into
/// a single, cohesive design system with DRY principles
class KuiTheme {
  KuiTheme._();

  // ═══════════════════════════════════════════════════════════════════════════
  // THEME DATA GENERATION
  // ═══════════════════════════════════════════════════════════════════════════

  /// Creates complete light theme
  static ThemeData light() => _buildTheme(Brightness.light);

  /// Creates complete dark theme
  static ThemeData dark() => _buildTheme(Brightness.dark);

  /// Builds theme for specific brightness
  static ThemeData _buildTheme(Brightness brightness) {
    final colors = DesignTokens.colorsFor(brightness);
    final textTheme = _buildTextTheme(colors);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: colors.toColorScheme(),
      textTheme: textTheme,
      scaffoldBackgroundColor: colors.background,

      // Component themes using unified design system
      appBarTheme: _buildAppBarTheme(colors, textTheme),
      cardTheme: _buildCardTheme(colors),
      elevatedButtonTheme: _buildElevatedButtonTheme(colors, textTheme),
      outlinedButtonTheme: _buildOutlinedButtonTheme(colors, textTheme),
      textButtonTheme: _buildTextButtonTheme(colors, textTheme),
      inputDecorationTheme: _buildInputTheme(colors, textTheme),
      tooltipTheme: _buildTooltipTheme(colors, textTheme),
      dialogTheme: _buildDialogTheme(colors),
      bottomSheetTheme: _buildBottomSheetTheme(colors),
      snackBarTheme: _buildSnackBarTheme(colors, textTheme),
      chipTheme: _buildChipTheme(colors, textTheme),
      tabBarTheme: _buildTabBarTheme(colors, textTheme),

      // Visual density and platform adaptations
      visualDensity: VisualDensity.adaptivePlatformDensity,

      // Animation and interaction
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.linux: FadeUpwardsPageTransitionsBuilder(),
          TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.windows: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // TEXT THEME
  // ═══════════════════════════════════════════════════════════════════════════

  static TextTheme _buildTextTheme(DesignColorTokens colors) {
    final baseTextStyle = GoogleFonts.notoSans(color: colors.onSurface);

    return TextTheme(
      // Display styles
      displayLarge: baseTextStyle.copyWith(
        fontSize: 57,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.25,
        height: 1.12,
      ),
      displayMedium: baseTextStyle.copyWith(
        fontSize: 45,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.16,
      ),
      displaySmall: baseTextStyle.copyWith(
        fontSize: 36,
        fontWeight: FontWeight.w400,
        letterSpacing: 0,
        height: 1.22,
      ),

      // Headline styles
      headlineLarge: baseTextStyle.copyWith(
        fontSize: 32,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.25,
      ),
      headlineMedium: baseTextStyle.copyWith(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.29,
      ),
      headlineSmall: baseTextStyle.copyWith(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        letterSpacing: 0,
        height: 1.33,
      ),

      // Title styles
      titleLarge: baseTextStyle.copyWith(
        fontSize: 22,
        fontWeight: FontWeight.w500,
        letterSpacing: 0,
        height: 1.27,
      ),
      titleMedium: baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      titleSmall: baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),

      // Body styles
      bodyLarge: baseTextStyle.copyWith(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.15,
        height: 1.50,
      ),
      bodyMedium: baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.25,
        height: 1.43,
      ),
      bodySmall: baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.4,
        height: 1.33,
      ),

      // Label styles
      labelLarge: baseTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.1,
        height: 1.43,
      ),
      labelMedium: baseTextStyle.copyWith(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.33,
      ),
      labelSmall: baseTextStyle.copyWith(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.5,
        height: 1.45,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // COMPONENT THEMES
  // ═══════════════════════════════════════════════════════════════════════════

  static AppBarTheme _buildAppBarTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return AppBarTheme(
      backgroundColor: colors.surface,
      foregroundColor: colors.onSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: textTheme.titleLarge,
      toolbarHeight: DesignTokens.appBarHeight,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(DesignTokens.radiusLg),
        ),
      ),
    );
  }

  static CardThemeData _buildCardTheme(DesignColorTokens colors) {
    return CardThemeData(
      color: colors.surface,
      shadowColor: colors.shadow,
      elevation: 0, // We use custom neumorphic shadows
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.all(DesignTokens.space2),
    );
  }

  static ElevatedButtonThemeData _buildElevatedButtonTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        disabledBackgroundColor: colors.outline,
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
        elevation: 0, // We use custom neumorphic effects
        shadowColor: Colors.transparent,
        minimumSize: Size(88, DesignTokens.buttonHeightMd),
        padding: EdgeInsets.symmetric(horizontal: DesignTokens.space4),
        textStyle: textTheme.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        ),
        animationDuration: DesignTokens.durationFast,
      ),
    );
  }

  static OutlinedButtonThemeData _buildOutlinedButtonTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.primary,
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
        backgroundColor: Colors.transparent,
        elevation: 0,
        minimumSize: Size(88, DesignTokens.buttonHeightMd),
        padding: EdgeInsets.symmetric(horizontal: DesignTokens.space4),
        textStyle: textTheme.labelLarge,
        side: BorderSide(color: colors.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        ),
        animationDuration: DesignTokens.durationFast,
      ),
    );
  }

  static TextButtonThemeData _buildTextButtonTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: colors.primary,
        disabledForegroundColor: colors.onSurface.withValues(alpha: 0.38),
        backgroundColor: Colors.transparent,
        elevation: 0,
        minimumSize: Size(88, DesignTokens.buttonHeightMd),
        padding: EdgeInsets.symmetric(horizontal: DesignTokens.space4),
        textStyle: textTheme.labelLarge,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        ),
        animationDuration: DesignTokens.durationFast,
      ),
    );
  }

  static InputDecorationTheme _buildInputTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colors.surface,
      contentPadding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space4,
        vertical: DesignTokens.space3,
      ),

      // Border styles using neumorphic effects
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        borderSide: BorderSide(color: colors.outline),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        borderSide: BorderSide(color: colors.outline),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        borderSide: BorderSide(color: colors.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        borderSide: BorderSide(color: colors.error, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        borderSide: BorderSide(color: colors.outline.withValues(alpha: 0.38)),
      ),

      // Text styles
      labelStyle: textTheme.bodyMedium?.copyWith(
        color: colors.onSurfaceVariant,
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: colors.onSurface.withValues(alpha: 0.6),
      ),
      errorStyle: textTheme.bodySmall?.copyWith(color: colors.error),
      helperStyle: textTheme.bodySmall?.copyWith(
        color: colors.onSurfaceVariant,
      ),
    );
  }

  static TooltipThemeData _buildTooltipTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return TooltipThemeData(
      decoration: BoxDecoration(
        color: colors.inverseSurface,
        borderRadius: BorderRadius.circular(DesignTokens.radiusSm),
      ),
      textStyle: textTheme.bodySmall?.copyWith(color: colors.onInverseSurface),
      padding: EdgeInsets.symmetric(
        horizontal: DesignTokens.space3,
        vertical: DesignTokens.space2,
      ),
      waitDuration: DesignTokens.durationSlow,
      showDuration: DesignTokens.durationSlower,
    );
  }

  static DialogThemeData _buildDialogTheme(DesignColorTokens colors) {
    return DialogThemeData(
      backgroundColor: colors.surface,
      elevation: 0, // We use custom neumorphic effects
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radius2xl),
      ),
      insetPadding: EdgeInsets.all(DesignTokens.space6),
    );
  }

  static BottomSheetThemeData _buildBottomSheetTheme(DesignColorTokens colors) {
    return BottomSheetThemeData(
      backgroundColor: colors.surface,
      elevation: 0, // We use custom neumorphic effects
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(DesignTokens.radius2xl),
        ),
      ),
      clipBehavior: Clip.antiAlias,
    );
  }

  static SnackBarThemeData _buildSnackBarTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return SnackBarThemeData(
      backgroundColor: colors.inverseSurface,
      contentTextStyle: textTheme.bodyMedium?.copyWith(
        color: colors.onInverseSurface,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      behavior: SnackBarBehavior.floating,
      elevation: 0, // We use custom neumorphic effects
    );
  }

  static ChipThemeData _buildChipTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return ChipThemeData(
      backgroundColor: colors.surface,
      deleteIconColor: colors.onSurface,
      disabledColor: colors.onSurface.withValues(alpha: 0.12),
      selectedColor: colors.secondaryVariant,
      secondarySelectedColor: colors.secondary,
      labelStyle: textTheme.bodyMedium,
      secondaryLabelStyle: textTheme.bodyMedium?.copyWith(
        color: colors.onSecondary,
      ),
      padding: EdgeInsets.symmetric(horizontal: DesignTokens.space3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
      ),
      elevation: 0, // We use custom neumorphic effects
    );
  }

  static TabBarThemeData _buildTabBarTheme(
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return TabBarThemeData(
      labelColor: colors.primary,
      unselectedLabelColor: colors.onSurfaceVariant,
      labelStyle: textTheme.titleSmall,
      unselectedLabelStyle: textTheme.titleSmall,
      indicator: BoxDecoration(
        borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
        color: colors.primary.withValues(alpha: 0.12),
      ),
      indicatorSize: TabBarIndicatorSize.tab,
      dividerColor: colors.outline,
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // UTILITY METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Get design colors for current theme
  static DesignColorTokens colorsOf(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return DesignTokens.colorsFor(brightness);
  }

  /// Create neumorphic decoration for current theme
  static BoxDecoration neumorphicOf(
    BuildContext context, {
    double radius = DesignTokens.radiusLg,
    int elevation = 2,
    Color? backgroundColor,
  }) {
    final colors = colorsOf(context);
    return DesignEffects.elevationLevel(
      colors: colors,
      level: elevation,
      radius: radius,
      backgroundColor: backgroundColor,
    );
  }

  /// Create glassmorphic container for current theme
  static Widget glassOf(
    BuildContext context, {
    required Widget child,
    double radius = DesignTokens.radiusLg,
    double blur = DesignTokens.glassBlurMedium,
    EdgeInsetsGeometry? padding,
  }) {
    final colors = colorsOf(context);
    return DesignEffects.glassContainer(
      child: child,
      colors: colors,
      radius: radius,
      blur: blur,
      padding: padding,
    );
  }

  /// Create hybrid effect for current theme
  static Widget hybridOf(
    BuildContext context, {
    required Widget child,
    double radius = DesignTokens.radiusLg,
    EdgeInsetsGeometry? padding,
  }) {
    final colors = colorsOf(context);
    return DesignEffects.hybridCard(
      child: child,
      colors: colors,
      radius: radius,
      padding: padding,
    );
  }
}
