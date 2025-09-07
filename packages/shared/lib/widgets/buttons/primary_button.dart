// lib/widgets/buttons/primary_button.dart

import 'package:flutter/material.dart';
import '../../theme/neumorphic_theme.dart';

/// A standardized neumorphic button with Material UI styling.
///
/// This button uses neumorphic design principles (shadow and light)
/// to create a soft, embossed or debossed appearance.
class PrimaryButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final double? width;
  final double? height;
  final double borderRadius;
  final bool isActive;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.color,
    this.width,
    this.height,
    this.borderRadius = NeumorphicTheme.borderRadius,
    this.isActive = false,
  });

  @override
  State<PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<PrimaryButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final backgroundColor = widget.color ?? theme.scaffoldBackgroundColor;

    return GestureDetector(
      onTapDown: (_) {
        if (widget.onPressed != null) {
          setState(() => _isPressed = true);
        }
      },
      onTapUp: (_) {
        if (widget.onPressed != null) {
          setState(() => _isPressed = false);
          widget.onPressed?.call();
        }
      },
      onTapCancel: () {
        if (widget.onPressed != null) {
          setState(() => _isPressed = false);
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width,
        height: widget.height,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        decoration: widget.onPressed == null
            ? NeumorphicTheme.neumorphicBoxDecoration(
                isDark: isDark,
                color: backgroundColor.withValues(alpha: 0.7),
                radius: widget.borderRadius,
                intensity: 0.3,
              )
            : _isPressed || widget.isActive
            ? NeumorphicTheme.neumorphicInsetBoxDecoration(
                isDark: isDark,
                color: backgroundColor,
                radius: widget.borderRadius,
              )
            : NeumorphicTheme.neumorphicBoxDecoration(
                isDark: isDark,
                color: backgroundColor,
                radius: widget.borderRadius,
              ),
        child: Center(child: widget.child),
      ),
    );
  }
}
