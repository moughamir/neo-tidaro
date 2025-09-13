import 'package:flutter/material.dart';
import 'package:ui_kit/src/design_system/design_system.dart';
import 'package:ui_kit/src/widgets/card.dart';
import 'package:ui_kit/src/widgets/utils/time_formatting.dart';

/// Activity card for displaying timeline items
class ActivityCard extends StatelessWidget {

  const ActivityCard({
    super.key,
    required this.title,
    this.description,
    required this.timestamp,
    this.avatar,
    this.statusColor,
    this.variant = CardVariant.flat,
    this.onTap,
    this.padding,
    this.margin,
  });
  final String title;
  final String? description;
  final DateTime timestamp;
  final Widget? avatar;
  final Color? statusColor;
  final CardVariant variant;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final colors = KuiTheme.colorsOf(context);
    final textTheme = Theme.of(context).textTheme;

    return KuiCard(
      variant: variant,
      onTap: onTap,
      padding: padding,
      margin: margin,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (avatar != null) ...[
            avatar!,
            const SizedBox(width: DesignTokens.space3),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (description != null) ...[
                  const SizedBox(height: DesignTokens.space1),
                  Text(
                    description!,
                    style: textTheme.bodySmall?.copyWith(
                      color: colors.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: DesignTokens.space1),
                Text(
                  formatTimestampShort(timestamp),
                  style: textTheme.bodySmall?.copyWith(
                    color: colors.onSurfaceVariant.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
          if (statusColor != null) ...[
            const SizedBox(width: DesignTokens.space3),
            Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
