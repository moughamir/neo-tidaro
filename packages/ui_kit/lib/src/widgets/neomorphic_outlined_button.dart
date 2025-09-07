import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/neumorphic_styles.dart';
import 'package:ui_kit/src/theme/palette.dart';

class NeumorphicOutlinedButton extends StatefulWidget {
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
  final Color? borderColor;
  final double borderWidth;

  const NeumorphicOutlinedButton({
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
    this.borderColor,
    this.borderWidth = 1.0,
  });

  @override
  State<NeumorphicOutlinedButton> createState() => _NeumorphicOutlinedButtonState();
}

class _NeumorphicOutlinedButtonState extends State<NeumorphicOutlinedButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = TidaroColorPalette.forMode(theme.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);
    final colorScheme = theme.colorScheme;
    
    final effectiveBackgroundColor = widget.backgroundColor ?? palette.surface;
    final effectiveBorderColor = widget.borderColor ?? palette.outline;

    return Listener(
      onPointerDown: (_) => setState(() => _isPressed = true),
      onPointerUp: (_) => setState(() => _isPressed = false),
      child: Tooltip(
        message: widget.tooltip ?? '',
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: effectiveBackgroundColor,
              border: Border.all(color: effectiveBorderColor, width: widget.borderWidth),
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
