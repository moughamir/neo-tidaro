import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/neumorphic_styles.dart';
import 'package:ui_kit/src/theme/palette.dart';

class NeumorphicElevatedButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final double blurRadius;
  final double distance;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? lightShadowColor;
  final String? tooltip;
  final EdgeInsetsGeometry? padding;

  const NeumorphicElevatedButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.borderRadius = 12.0,
    this.blurRadius = 10.0,
    this.distance = 5.0,
    this.backgroundColor,
    this.shadowColor,
    this.lightShadowColor,
    this.tooltip,
    this.padding,
  });

  @override
  State<NeumorphicElevatedButton> createState() =>
      _NeumorphicElevatedButtonState();
}

class _NeumorphicElevatedButtonState extends State<NeumorphicElevatedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = TidaroColorPalette.forMode(
      theme.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
    );

    final effectiveBackgroundColor = widget.backgroundColor ?? palette.primary;

    return Listener(
      onPointerDown: (_) => setState(() => _isPressed = true),
      onPointerUp: (_) => setState(() => _isPressed = false),
      child: Tooltip(
        message: widget.tooltip ?? '',
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding:
                widget.padding ??
                const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: effectiveBackgroundColor,
              boxShadow: NeumorphicStyles.getShadows(
                baseColor: effectiveBackgroundColor,
                distance: widget.distance,
                blurRadius: widget.blurRadius,
                isPressed: _isPressed,
              ),
            ),
            child: Center(child: widget.child),
          ),
        ),
      ),
    );
  }
}
