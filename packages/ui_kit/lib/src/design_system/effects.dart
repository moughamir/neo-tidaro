import 'dart:ui';
import 'package:flutter/material.dart';
import 'design_tokens.dart';

/// Unified effects system combining Neumorphism and Glassmorphism
/// 
/// Provides consistent visual effects across the design system with
/// proper DRY principles and centralized configuration
class DesignEffects {
  DesignEffects._();

  // ═══════════════════════════════════════════════════════════════════════════
  // NEUMORPHIC EFFECTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Creates elevated neumorphic decoration
  static BoxDecoration neumorphicElevated({
    required DesignColorTokens colors,
    double radius = DesignTokens.radiusLg,
    double distance = DesignTokens.neuDistanceMd,
    double blur = DesignTokens.neuBlurMd,
    double intensity = DesignTokens.neuIntensityNormal,
    Color? backgroundColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? colors.surface,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        // Dark shadow (bottom-right)
        BoxShadow(
          color: colors.neuShadowDark.withValues(alpha: intensity),
          offset: Offset(distance, distance),
          blurRadius: blur,
          spreadRadius: 0,
        ),
        // Light highlight (top-left)
        BoxShadow(
          color: colors.neuHighlight.withValues(alpha: intensity),
          offset: Offset(-distance, -distance),
          blurRadius: blur,
          spreadRadius: 0,
        ),
      ],
    );
  }

  /// Creates inset neumorphic decoration (pressed state)
  static BoxDecoration neumorphicInset({
    required DesignColorTokens colors,
    double radius = DesignTokens.radiusLg,
    double distance = DesignTokens.neuDistanceMd,
    double blur = DesignTokens.neuBlurMd,
    double intensity = DesignTokens.neuIntensityNormal,
    Color? backgroundColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? colors.surface,
      borderRadius: BorderRadius.circular(radius),
      boxShadow: [
        // Inner dark shadow (top-left)
        BoxShadow(
          color: colors.neuShadowDark.withValues(alpha: intensity),
          offset: Offset(-distance / 2, -distance / 2),
          blurRadius: blur / 2,
          spreadRadius: 0,
        ),
        // Inner light highlight (bottom-right)
        BoxShadow(
          color: colors.neuHighlight.withValues(alpha: intensity * 0.5),
          offset: Offset(distance / 2, distance / 2),
          blurRadius: blur / 2,
          spreadRadius: 0,
        ),
      ],
    );
  }

  /// Creates flat neumorphic decoration (neutral state)
  static BoxDecoration neumorphicFlat({
    required DesignColorTokens colors,
    double radius = DesignTokens.radiusLg,
    Color? backgroundColor,
  }) {
    return BoxDecoration(
      color: backgroundColor ?? colors.surface,
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: colors.outline.withValues(alpha: 0.1),
        width: 0.5,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // GLASSMORPHISM EFFECTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Creates glassmorphic decoration with backdrop blur
  static BoxDecoration glassmorphic({
    required DesignColorTokens colors,
    double radius = DesignTokens.radiusLg,
    double opacity = DesignTokens.glassOpacityMedium,
    double borderOpacity = DesignTokens.glassBorderOpacity,
    Color? overlayColor,
  }) {
    return BoxDecoration(
      color: (overlayColor ?? colors.glassOverlay).withValues(alpha: opacity),
      borderRadius: BorderRadius.circular(radius),
      border: Border.all(
        color: colors.glassBorder.withValues(alpha: borderOpacity),
        width: 1.0,
      ),
    );
  }

  /// Creates glassmorphic container with backdrop filter
  static Widget glassContainer({
    required Widget child,
    required DesignColorTokens colors,
    double radius = DesignTokens.radiusLg,
    double blur = DesignTokens.glassBlurMedium,
    double opacity = DesignTokens.glassOpacityMedium,
    double borderOpacity = DesignTokens.glassBorderOpacity,
    EdgeInsetsGeometry? padding,
    Color? overlayColor,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          padding: padding,
          decoration: glassmorphic(
            colors: colors,
            radius: radius,
            opacity: opacity,
            borderOpacity: borderOpacity,
            overlayColor: overlayColor,
          ),
          child: child,
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // HYBRID EFFECTS (Neumorphism + Glassmorphism)
  // ═══════════════════════════════════════════════════════════════════════════

  /// Creates hybrid effect combining neumorphic shadows with glass overlay
  static Widget hybridCard({
    required Widget child,
    required DesignColorTokens colors,
    double radius = DesignTokens.radiusLg,
    double neuDistance = DesignTokens.neuDistanceSm,
    double neuBlur = DesignTokens.neuBlurSm,
    double neuIntensity = DesignTokens.neuIntensitySubtle,
    double glassBlur = DesignTokens.glassBlurLight,
    double glassOpacity = DesignTokens.glassOpacitySubtle,
    EdgeInsetsGeometry? padding,
    Color? backgroundColor,
  }) {
    return Container(
      decoration: neumorphicElevated(
        colors: colors,
        radius: radius,
        distance: neuDistance,
        blur: neuBlur,
        intensity: neuIntensity,
        backgroundColor: backgroundColor,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: glassBlur, sigmaY: glassBlur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: colors.glassOverlay.withValues(alpha: glassOpacity),
              borderRadius: BorderRadius.circular(radius),
            ),
            child: child,
          ),
        ),
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // ELEVATION SYSTEM
  // ═══════════════════════════════════════════════════════════════════════════

  /// Material Design elevation levels adapted for neumorphic design
  static BoxDecoration elevationLevel({
    required DesignColorTokens colors,
    required int level,
    double radius = DesignTokens.radiusLg,
    Color? backgroundColor,
  }) {
    switch (level) {
      case 0:
        return neumorphicFlat(
          colors: colors,
          radius: radius,
          backgroundColor: backgroundColor,
        );
      case 1:
        return neumorphicElevated(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceXs,
          blur: DesignTokens.neuBlurXs,
          intensity: DesignTokens.neuIntensitySubtle,
          backgroundColor: backgroundColor,
        );
      case 2:
        return neumorphicElevated(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceSm,
          blur: DesignTokens.neuBlurSm,
          intensity: DesignTokens.neuIntensitySubtle,
          backgroundColor: backgroundColor,
        );
      case 3:
        return neumorphicElevated(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceMd,
          blur: DesignTokens.neuBlurMd,
          intensity: DesignTokens.neuIntensityNormal,
          backgroundColor: backgroundColor,
        );
      case 4:
        return neumorphicElevated(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceLg,
          blur: DesignTokens.neuBlurLg,
          intensity: DesignTokens.neuIntensityNormal,
          backgroundColor: backgroundColor,
        );
      case 5:
      default:
        return neumorphicElevated(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceXl,
          blur: DesignTokens.neuBlurXl,
          intensity: DesignTokens.neuIntensityStrong,
          backgroundColor: backgroundColor,
        );
    }
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // COMPONENT-SPECIFIC EFFECTS
  // ═══════════════════════════════════════════════════════════════════════════

  /// Button states with consistent neumorphic effects
  static BoxDecoration buttonState({
    required DesignColorTokens colors,
    required ButtonState state,
    double radius = DesignTokens.radiusLg,
    Color? backgroundColor,
  }) {
    switch (state) {
      case ButtonState.normal:
        return neumorphicElevated(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceSm,
          blur: DesignTokens.neuBlurSm,
          backgroundColor: backgroundColor,
        );
      case ButtonState.hovered:
        return neumorphicElevated(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceMd,
          blur: DesignTokens.neuBlurMd,
          backgroundColor: backgroundColor,
        );
      case ButtonState.pressed:
        return neumorphicInset(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceSm,
          blur: DesignTokens.neuBlurSm,
          backgroundColor: backgroundColor,
        );
      case ButtonState.disabled:
        return neumorphicFlat(
          colors: colors,
          radius: radius,
          backgroundColor: backgroundColor?.withValues(alpha: 0.5),
        );
    }
  }

  /// Input field states with consistent effects
  static BoxDecoration inputState({
    required DesignColorTokens colors,
    required InputState state,
    double radius = DesignTokens.radiusLg,
    Color? backgroundColor,
  }) {
    switch (state) {
      case InputState.normal:
        return neumorphicInset(
          colors: colors,
          radius: radius,
          distance: DesignTokens.neuDistanceXs,
          blur: DesignTokens.neuBlurXs,
          intensity: DesignTokens.neuIntensitySubtle,
          backgroundColor: backgroundColor,
        );
      case InputState.focused:
        return BoxDecoration(
          color: backgroundColor ?? colors.surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: colors.primary,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.primary.withValues(alpha: 0.2),
              blurRadius: DesignTokens.neuBlurSm,
              spreadRadius: 0,
            ),
          ],
        );
      case InputState.error:
        return BoxDecoration(
          color: backgroundColor ?? colors.surface,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: colors.error,
            width: 2.0,
          ),
          boxShadow: [
            BoxShadow(
              color: colors.error.withValues(alpha: 0.2),
              blurRadius: DesignTokens.neuBlurSm,
              spreadRadius: 0,
            ),
          ],
        );
      case InputState.disabled:
        return neumorphicFlat(
          colors: colors,
          radius: radius,
          backgroundColor: backgroundColor?.withValues(alpha: 0.5),
        );
    }
  }
}

/// Button interaction states
enum ButtonState {
  normal,
  hovered,
  pressed,
  disabled,
}

/// Input field states
enum InputState {
  normal,
  focused,
  error,
  disabled,
}
