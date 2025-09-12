import 'package:flutter/material.dart';
import 'package:ui_kit/src/design_system/design_system.dart';

export 'cards/cards.dart';

/// Unified card component that consolidates all card variants
///
/// Replaces KuiCard.glass and other card duplicates with a single,
/// consistent implementation using the unified design system
class KuiCard extends StatelessWidget {
  final Widget child;
  final CardVariant variant;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final int elevation;
  final VoidCallback? onTap;
  final String? title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final bool showBorder;
  final Color? borderColor;

  const KuiCard({
    super.key,
    required this.child,
    this.variant = CardVariant.elevated,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.elevation = 2,
    this.onTap,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.showBorder = false,
    this.borderColor,
  });

  /// Elevated card with neumorphic shadows
  const KuiCard.elevated({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.elevation = 2,
    this.onTap,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.showBorder = false,
    this.borderColor,
  }) : variant = CardVariant.elevated;

  /// Glassmorphic card (replaces KuiCard.glass)
  const KuiCard.glass({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.elevation = 0,
    this.onTap,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.showBorder = true,
    this.borderColor,
  }) : variant = CardVariant.glass;

  /// Outlined card
  const KuiCard.outlined({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.elevation = 0,
    this.onTap,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.showBorder = true,
    this.borderColor,
  }) : variant = CardVariant.outlined;

  /// Flat card without elevation
  const KuiCard.flat({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.elevation = 0,
    this.onTap,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.showBorder = false,
    this.borderColor,
  }) : variant = CardVariant.flat;

  /// Hybrid card combining neumorphic and glass effects
  const KuiCard.hybrid({
    super.key,
    required this.child,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.padding,
    this.margin,
    this.elevation = 2,
    this.onTap,
    this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.showBorder = false,
    this.borderColor,
  }) : variant = CardVariant.hybrid;

  @override
  Widget build(BuildContext context) {
    final colors = KuiTheme.colorsOf(context);
    final textTheme = Theme.of(context).textTheme;

    final effectiveRadius = borderRadius ?? DesignTokens.radiusLg;
    final effectivePadding = padding ?? EdgeInsets.all(DesignTokens.space4);
    final effectiveMargin = margin ?? EdgeInsets.all(DesignTokens.space2);
    final effectiveBackgroundColor = backgroundColor ?? colors.surface;

    Widget cardContent = _buildCardContent(context, colors, textTheme);
    Widget decoratedCard = _buildDecoratedCard(
      context,
      colors,
      cardContent,
      effectiveRadius,
      effectivePadding,
      effectiveBackgroundColor,
    );

    // Wrap with margin
    decoratedCard = Container(margin: effectiveMargin, child: decoratedCard);

    // Add tap functionality if provided
    if (onTap != null) {
      decoratedCard = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(effectiveRadius),
        child: decoratedCard,
      );
    }

    return decoratedCard;
  }

  Widget _buildCardContent(
    BuildContext context,
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    Widget content = child;

    // Build header if title or subtitle provided
    if (title != null ||
        subtitle != null ||
        leading != null ||
        trailing != null) {
      final header = _buildHeader(context, colors, textTheme);
      content = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          header,
          if (title != null || subtitle != null)
            SizedBox(height: DesignTokens.space3),
          Expanded(child: content),
        ],
      );
    }

    return content;
  }

  Widget _buildHeader(
    BuildContext context,
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    return Row(
      children: [
        if (leading != null) ...[
          leading!,
          SizedBox(width: DesignTokens.space3),
        ],
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != null)
                Text(
                  title!,
                  style: textTheme.titleMedium?.copyWith(
                    color: colors.onSurface,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              if (subtitle != null) ...[
                SizedBox(height: DesignTokens.space1),
                Text(
                  subtitle!,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ],
          ),
        ),
        if (trailing != null) ...[
          SizedBox(width: DesignTokens.space3),
          trailing!,
        ],
      ],
    );
  }

  Widget _buildDecoratedCard(
    BuildContext context,
    DesignColorTokens colors,
    Widget child,
    double radius,
    EdgeInsetsGeometry padding,
    Color backgroundColor,
  ) {
    switch (variant) {
      case CardVariant.elevated:
        return Container(
          width: width,
          height: height,
          padding: padding,
          decoration: DesignEffects.elevationLevel(
            colors: colors,
            level: elevation,
            radius: radius,
            backgroundColor: backgroundColor,
          ),
          child: child,
        );

      case CardVariant.glass:
        return DesignEffects.glassContainer(
          child: Container(
            width: width,
            height: height,
            padding: padding,
            child: child,
          ),
          colors: colors,
          radius: radius,
        );

      case CardVariant.outlined:
        return Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(
              color: borderColor ?? colors.outline,
              width: 1.0,
            ),
          ),
          child: child,
        );

      case CardVariant.flat:
        return Container(
          width: width,
          height: height,
          padding: padding,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(radius),
            border: showBorder
                ? Border.all(
                    color: borderColor ?? colors.outline.withValues(alpha: 0.2),
                    width: 0.5,
                  )
                : null,
          ),
          child: child,
        );

      case CardVariant.hybrid:
        return DesignEffects.hybridCard(
          child: Container(
            width: width,
            height: height,
            padding: padding,
            child: child,
          ),
          colors: colors,
          radius: radius,
        );
    }
  }
}

/// Card visual variants
enum CardVariant { elevated, glass, outlined, flat, hybrid }
