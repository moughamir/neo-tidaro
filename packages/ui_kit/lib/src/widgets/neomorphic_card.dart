import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/neumorphic_styles.dart';
import 'package:ui_kit/src/theme/palette.dart';

class NeumorphicCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double distance;
  final double blurRadius;
  final Color? backgroundColor;

  const NeumorphicCard({
    super.key,
    required this.child,
    this.borderRadius = 12.0,
    this.distance = 5.0,
    this.blurRadius = 10.0,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = TidaroColorPalette.forMode(theme.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);
    final effectiveBackgroundColor = backgroundColor ?? palette.surface;

    return Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: NeumorphicStyles.getShadows(
          baseColor: effectiveBackgroundColor,
          distance: distance,
          blurRadius: blurRadius,
        ),
      ),
      child: child,
    );
  }
}
