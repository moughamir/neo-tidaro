import 'package:flutter/material.dart';
import 'package:ui_kit/src/widgets/card.dart';

/// Legacy glass container component - now uses KuiCard.glass internally
///
/// This component is maintained for backward compatibility but delegates
/// to the unified KuiCard to follow DRY principles.
class GlassContainer extends StatelessWidget {

  const GlassContainer({
    super.key,
    required this.child,
    this.borderRadius = 12.0,
    this.backgroundColor = Colors.white54, // Semi-transparent white
    this.borderColor = Colors.white70,
    this.borderWidth = 1.0,
    this.blurAmount = 5.0,
  });
  final Widget child;
  final double borderRadius;
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double blurAmount;

  @override
  Widget build(BuildContext context) {
    return KuiCard.glass(
      borderRadius: borderRadius,
      backgroundColor: backgroundColor,
      borderColor: borderColor,
      padding: EdgeInsets.zero,
      child: child,
    );
  }
}
