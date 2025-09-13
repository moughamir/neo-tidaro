import 'package:flutter/material.dart';
import 'package:ui_kit/src/design_system/design_system.dart';
import 'package:ui_kit/src/widgets/card.dart';

/// A card for displaying a single, prominent metric.
class MetricCard extends StatelessWidget {
  const MetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.valueColor,
    this.trend,
    this.isPositiveTrend = true,
    this.variant = CardVariant.elevated,
    this.onTap,
    this.padding,
    this.margin,
  });

  final String title;
  final String? subtitle;
  final String value;
  final Widget? icon;
  final Color? valueColor;
  final String? trend;
  final bool isPositiveTrend;
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (icon != null) icon!,
            ],
          ),
          const SizedBox(height: DesignTokens.space2),
          Text(
            value,
            style: textTheme.headlineSmall?.copyWith(
              color: valueColor ?? colors.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (subtitle != null || trend != null) ...[
            const SizedBox(height: DesignTokens.space1),
            Row(
              children: [
                if (subtitle != null)
                  Expanded(
                    child: Text(
                      subtitle!,
                      style: textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                if (trend != null)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: DesignTokens.space2,
                      vertical: DesignTokens.space1,
                    ),
                    decoration: BoxDecoration(
                      color: (isPositiveTrend ? colors.success : colors.error)
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(
                        DesignTokens.radiusSm,
                      ),
                    ),
                    child: Text(
                      trend!,
                      style: textTheme.bodySmall?.copyWith(
                        color: isPositiveTrend ? colors.success : colors.error,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
