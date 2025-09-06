import 'package:flutter/material.dart';
import 'package:ui_kit/src/widgets/glassy_card.dart';

class AuthCard extends StatelessWidget {
  const AuthCard({
    super.key,
    required this.child,
    this.width = 400,
    this.padding = const EdgeInsets.all(32),
  });

  final Widget child;
  final double width;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: width,
          minWidth: 320,
        ),
        child: GlassyCard(
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
