/// Unified Design System for Neo-Tidaro UI Kit
///
/// This barrel file exports all design system components for easy access
/// and consistent usage across the application.
///
/// Usage:
/// ```dart
/// import 'package:ui_kit/src/design_system/design_system.dart';
///
/// // Access design tokens
/// final spacing = DesignTokens.space4;
/// final colors = DesignTokens.colorsFor(Brightness.light);
///
/// // Create effects
/// final decoration = DesignEffects.neumorphicElevated(colors: colors);
/// final glassWidget = DesignEffects.glassContainer(child: myWidget, colors: colors);
///
/// // Use unified theme
/// MaterialApp(
///   theme: UnifiedTheme.light(),
///   darkTheme: UnifiedTheme.dark(),
///   // ...
/// );
/// ```

library;

// Core design tokens
export 'design_tokens.dart';

// Visual effects system
export 'effects.dart';

// Unified theme system
export 'kui_theme.dart';
