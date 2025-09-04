import 'package:flutter/material.dart';
import '../../theme/neumorphic_theme.dart';

/// A standardized info card component using Neumorphic styling
///
/// Provides consistent styling for information display cards throughout the app
class InfoCard extends StatelessWidget {
  /// The card title
  final String title;

  /// Optional subtitle text
  final String? subtitle;

  /// Optional icon to display in the card
  final IconData? icon;

  /// Main content widget
  final Widget content;

  /// Optional footer widget
  final Widget? footer;

  /// Background color for the card
  final Color? backgroundColor;

  /// Callback when the card is tapped
  final VoidCallback? onTap;

  const InfoCard({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    required this.content,
    this.footer,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: NeumorphicTheme.neumorphicBoxDecoration(
          isDark: isDark,
          color: backgroundColor ?? theme.cardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                if (icon != null) ...[
                  Icon(icon, size: 18, color: theme.colorScheme.onSurface),
                  const SizedBox(width: 8),
                ],
                Expanded(
                  child: Text(
                    title,
                    style: theme.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(
                subtitle!,
                style: theme.textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ],
            const SizedBox(height: 12),
            content,
            if (footer != null) ...[const SizedBox(height: 12), footer!],
          ],
        ),
      ),
    );
  }
}
