import 'package:flutter/material.dart';
import 'package:ui_kit/src/localization/app_localizations.dart';

class NeomorphicButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final double borderRadius;
  final double blurRadius;
  final double distance;
  final Color? backgroundColor;
  final Color? shadowColor;
  final Color? lightShadowColor;
  final String? tooltip;

  const NeomorphicButton({
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
  });

  @override
  State<NeomorphicButton> createState() => _NeomorphicButtonState();
}

class _NeomorphicButtonState extends State<NeomorphicButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    
    final effectiveBackgroundColor = widget.backgroundColor ?? colorScheme.surface;
    final effectiveShadowColor = widget.shadowColor ?? 
        (isDark ? Colors.black.withValues(alpha: 0.6) : colorScheme.shadow);
    final effectiveLightShadowColor = widget.lightShadowColor ?? 
        (isDark ? colorScheme.surface.withValues(alpha: 0.1) : 
         colorScheme.surface.withValues(alpha: 0.9));

    return Listener(
      onPointerDown: (_) => setState(() => _isPressed = true),
      onPointerUp: (_) => setState(() => _isPressed = false),
      child: Tooltip(
        message: widget.tooltip != null && context.mounted
            ? AppLocalizations.of(context).helloUser(widget.tooltip!)
            : '',
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              color: effectiveBackgroundColor,
              boxShadow: _isPressed
                  ? [
                      BoxShadow(
                        color: effectiveShadowColor.withValues(alpha: 0.3),
                        offset: Offset(
                          widget.distance / 2,
                          widget.distance / 2,
                        ),
                        blurRadius: widget.blurRadius / 2,
                      ),
                      BoxShadow(
                        color: effectiveLightShadowColor.withValues(alpha: 0.8),
                        offset: Offset(
                          -widget.distance / 2,
                          -widget.distance / 2,
                        ),
                        blurRadius: widget.blurRadius / 2,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: effectiveShadowColor.withValues(alpha: 0.5),
                        offset: Offset(widget.distance, widget.distance),
                        blurRadius: widget.blurRadius,
                      ),
                      BoxShadow(
                        color: effectiveLightShadowColor.withValues(alpha: 0.8),
                        offset: Offset(-widget.distance, -widget.distance),
                        blurRadius: widget.blurRadius,
                      ),
                    ],
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
