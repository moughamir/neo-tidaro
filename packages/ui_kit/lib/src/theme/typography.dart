import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'palette.dart';

/// Advanced typography system with support for multi-script text
class TidaroTypography {
  // Font families
  final String primaryFontFamily;
  final String arabicFontFamily;
  final String tifinaghFontFamily;

  // Text styles with clear semantic names
  final TextStyle displayLarge;
  final TextStyle displayMedium;
  final TextStyle displaySmall;
  final TextStyle headlineLarge;
  final TextStyle headlineMedium;
  final TextStyle headlineSmall;
  final TextStyle titleLarge;
  final TextStyle titleMedium;
  final TextStyle titleSmall;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle caption;
  final TextStyle button;
  final TextStyle overline;

  // Script-specific styles
  final TextStyle arabicHeadline;
  final TextStyle arabicBody;
  final TextStyle tifinaghHeadline;
  final TextStyle tifinaghBody;

  // Combined text theme for Flutter
  final TextTheme textTheme;

  const TidaroTypography._({
    required this.primaryFontFamily,
    required this.arabicFontFamily,
    required this.tifinaghFontFamily,
    required this.displayLarge,
    required this.displayMedium,
    required this.displaySmall,
    required this.headlineLarge,
    required this.headlineMedium,
    required this.headlineSmall,
    required this.titleLarge,
    required this.titleMedium,
    required this.titleSmall,
    required this.body1,
    required this.body2,
    required this.caption,
    required this.button,
    required this.overline,
    required this.arabicHeadline,
    required this.arabicBody,
    required this.tifinaghHeadline,
    required this.tifinaghBody,
    required this.textTheme,
  });

  factory TidaroTypography.forPalette(TidaroColorPalette palette) {
    // Base text styles with the primary font
    final baseTextStyle = GoogleFonts.notoSans(color: palette.onSurface);

    // Script-specific base styles
    final arabicTextStyle = GoogleFonts.notoSansArabic(
      color: palette.onSurface,
    );
    final tifinaghTextStyle = GoogleFonts.notoSansTifinagh(
      color: palette.onSurface,
    );

    // Define all the text styles
    final TextStyle displayLarge = baseTextStyle.copyWith(
      fontSize: 40,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.5,
      height: 1.2,
    );

    final TextStyle displayMedium = baseTextStyle.copyWith(
      fontSize: 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.25,
      height: 1.2,
    );

    final TextStyle displaySmall = baseTextStyle.copyWith(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.3,
    );

    final TextStyle headlineLarge = baseTextStyle.copyWith(
      fontSize: 22,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.4,
    );

    final TextStyle headlineMedium = baseTextStyle.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.4,
    );

    final TextStyle headlineSmall = baseTextStyle.copyWith(
      fontSize: 18,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.1,
      height: 1.4,
    );

    final TextStyle titleLarge = baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.15,
      height: 1.5,
    );

    final TextStyle titleMedium = baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.15,
      height: 1.5,
    );

    final TextStyle titleSmall = baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.5,
    );

    final TextStyle body1 = baseTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.15,
      height: 1.5,
    );

    final TextStyle body2 = baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.25,
      height: 1.5,
    );

    final TextStyle caption = baseTextStyle.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      letterSpacing: 0.4,
      height: 1.5,
    );

    final TextStyle button = baseTextStyle.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.1,
      height: 1.5,
    );

    final TextStyle overline = baseTextStyle.copyWith(
      fontSize: 10,
      fontWeight: FontWeight.w400,
      letterSpacing: 1.5,
      height: 1.6,
    );

    // Script-specific styles
    final arabicHeadline = arabicTextStyle.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.4,
    );

    final arabicBody = arabicTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.5,
    );

    final tifinaghHeadline = tifinaghTextStyle.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w600,
      letterSpacing: 0,
      height: 1.4,
    );

    final tifinaghBody = tifinaghTextStyle.copyWith(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      letterSpacing: 0,
      height: 1.5,
    );

    // Create Flutter TextTheme
    final TextTheme textTheme = TextTheme(
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium.copyWith(color: palette.primary),
      headlineSmall: headlineSmall.copyWith(color: palette.secondary),
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      bodyLarge: body1,
      bodyMedium: body2,
      bodySmall: caption,
      labelLarge: button,
      labelSmall: overline,
    );

    return TidaroTypography._(
      primaryFontFamily: 'Noto Sans',
      arabicFontFamily: 'Noto Sans Arabic',
      tifinaghFontFamily: 'Noto Sans Tifinagh',
      displayLarge: displayLarge,
      displayMedium: displayMedium,
      displaySmall: displaySmall,
      headlineLarge: headlineLarge,
      headlineMedium: headlineMedium,
      headlineSmall: headlineSmall,
      titleLarge: titleLarge,
      titleMedium: titleMedium,
      titleSmall: titleSmall,
      body1: body1,
      body2: body2,
      caption: caption,
      button: button,
      overline: overline,
      arabicHeadline: arabicHeadline,
      arabicBody: arabicBody,
      tifinaghHeadline: tifinaghHeadline,
      tifinaghBody: tifinaghBody,
      textTheme: textTheme,
    );
  }
}
