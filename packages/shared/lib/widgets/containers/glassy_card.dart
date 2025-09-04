import 'dart:ui';

import 'package:flutter/material.dart';

/// A frosted glass effect card with neumorphic styling
///
/// This component creates a translucent card with a blur effect
/// to create a modern "glassy" appearance combined with neumorphic shadows
class GlassyCard extends StatelessWidget {
  /// Title text for the card
  final String? title;

  /// Subtitle text for the card
  final String? subtitle;

  /// Main content widget
  final Widget child;

  /// Optional background color (defaults to semi-transparent white/black)
  final Color? backgroundColor;

  /// Blur intensity for the glass effect
  final double blur;

  /// Opacity level for the glass effect
  final double opacity;

  /// Border radius for the card
  final double borderRadius;

  /// Optional callback when card is tapped
  final VoidCallback? onTap;

  const GlassyCard({
    super.key,
    this.title,
    this.subtitle,
    required this.child,
    this.backgroundColor,
    this.blur = 10.0,
    this.opacity = 0.2,
    this.borderRadius = 16.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final defaultColor = isDark
        ? Colors.black.withValues(alpha: opacity)
        : Colors.white.withValues(alpha: opacity);

    return GestureDetector(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor ?? defaultColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: isDark
                    ? Colors.white.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.1),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isDark
                      ? Colors.black.withValues(alpha: 0.3)
                      : Colors.grey.withValues(alpha: 0.2),
                  blurRadius: 15,
                  offset: const Offset(5, 5),
                ),
                BoxShadow(
                  color: Colors.white.withValues(alpha: isDark ? 0.1 : 0.3),
                  blurRadius: 15,
                  offset: const Offset(-5, -5),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: theme.textTheme.titleLarge,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                ],
                if (subtitle != null) ...[
                  Text(
                    subtitle!,
                    style: theme.textTheme.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                ],
                child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
