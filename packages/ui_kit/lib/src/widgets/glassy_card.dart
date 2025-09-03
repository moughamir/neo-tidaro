import 'dart:ui';

import 'package:flutter/material.dart';

class GlassyCard extends StatelessWidget {
  final Widget child;
  final double borderRadius;
  final double blurAmount;
  final Color backgroundColor;
  final double borderWidth;
  final Color borderColor;

  const GlassyCard({
    super.key,
    required this.child,
    this.borderRadius = 12.0,
    this.blurAmount = 5.0,
    this.backgroundColor = Colors.white,
    this.borderWidth = 1.0,
    this.borderColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurAmount, sigmaY: blurAmount),
        child: Container(
          decoration: BoxDecoration(
            color: backgroundColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor.withOpacity(0.3),
              width: borderWidth,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
