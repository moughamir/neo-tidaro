import 'package:flutter/material.dart';

/// A standardized loading indicator using Material UI with Neumorphic styling
///
/// Provides consistent loading visualization across the application
class LoadingIndicator extends StatelessWidget {
  /// Optional message to display with the loading indicator
  final String? message;

  /// Size of the loading indicator
  final double size;

  /// Whether to center the indicator in its parent
  final bool centered;

  /// Whether to display the indicator with a transparent background
  final bool transparent;

  /// Whether to show the progress ring
  final bool showRing;

  /// Whether to display the indicator as an overlay
  final bool overlay;

  /// Padding for the content
  final EdgeInsets? padding;

  /// Color of the progress indicator
  final Color? color;

  /// Stroke width of the progress indicator
  final double strokeWidth;

  /// Whether the background should be transparent
  final bool transparentBackground;

  const LoadingIndicator({
    super.key,
    this.message,
    this.size = 36.0,
    this.centered = true,
    this.transparent = false,
    this.showRing = true,
    this.overlay = false,
    this.padding,
    this.color,
    this.strokeWidth = 4.0,
    this.transparentBackground = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final content = Padding(
      padding: padding ?? const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showRing)
            _NeumorphicCircularProgressIndicator(
              color: color ?? theme.colorScheme.primary,
              strokeWidth: strokeWidth,
              isDark: isDark,
            ),
          if (message != null && showRing) const SizedBox(height: 16),
          if (message != null)
            Text(
              message!,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
        ],
      ),
    );

    if (overlay) {
      return Container(
        color: transparentBackground
            ? Colors.transparent
            : theme.scaffoldBackgroundColor.withValues(alpha: 0.7),
        width: double.infinity,
        height: double.infinity,
        child: Center(child: content),
      );
    }

    return Center(child: content);
  }
}

/// A custom circular progress indicator with neumorphic styling
class _NeumorphicCircularProgressIndicator extends StatelessWidget {
  final Color? color;
  final double strokeWidth;
  final bool isDark;

  const _NeumorphicCircularProgressIndicator({
    required this.isDark,
    this.color,
    this.strokeWidth = 4.0,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDark ? Colors.grey[800]! : Colors.grey[200]!;
    final progressColor = color ?? Theme.of(context).colorScheme.primary;

    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).scaffoldBackgroundColor,
        boxShadow: [
          // Outer shadow
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.5)
                : Colors.grey[400]!.withValues(alpha: 0.5),
            blurRadius: 8,
            offset: const Offset(4, 4),
          ),
          // Outer highlight
          BoxShadow(
            color: isDark
                ? Colors.grey[800]!.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.8),
            blurRadius: 8,
            offset: const Offset(-4, -4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
          backgroundColor: backgroundColor,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
