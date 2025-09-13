import 'package:flutter/material.dart';
import 'package:ui_kit/src/design_system/design_system.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.variant = AuthButtonVariant.primary,
    this.width = double.infinity,
    this.icon,
  });

  final VoidCallback? onPressed;
  final String text;
  final bool isLoading;
  final AuthButtonVariant variant;
  final double width;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    ButtonVariant kuiVariant;
    switch (variant) {
      case AuthButtonVariant.primary:
        kuiVariant = ButtonVariant.elevated;
        break;
      case AuthButtonVariant.secondary:
        kuiVariant = ButtonVariant.outlined;
        break;
      case AuthButtonVariant.ghost:
        kuiVariant = ButtonVariant.text;
        break;
    }

    return KuiButton(
      onPressed: onPressed,
      width: width,
      height: 48,
      isLoading: isLoading,
      variant: kuiVariant,
      icon: icon,
      child: Text(text),
    );
  }
}

enum AuthButtonVariant { primary, secondary, ghost }

class SocialAuthButton extends StatelessWidget {
  const SocialAuthButton({
    super.key,
    required this.onPressed,
    required this.provider,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final SocialAuthProvider provider;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return KuiButton(
      variant: ButtonVariant.outlined,
      onPressed: onPressed,
      width: double.infinity,
      height: 48,
      isLoading: isLoading,
      icon: _getProviderIcon(),
      child: Text('Continue with ${_getProviderName()}'),
    );
  }

  Widget _getProviderIcon() {
    switch (provider) {
      case SocialAuthProvider.github:
        return const Icon(Icons.code, size: 20);
      case SocialAuthProvider.google:
        return const Icon(Icons.g_mobiledata, size: 20);
      case SocialAuthProvider.apple:
        return const Icon(Icons.apple, size: 20);
    }
  }

  String _getProviderName() {
    switch (provider) {
      case SocialAuthProvider.github:
        return 'GitHub';
      case SocialAuthProvider.google:
        return 'Google';
      case SocialAuthProvider.apple:
        return 'Apple';
    }
  }
}

enum SocialAuthProvider { github, google, apple }

/// Unified button component that consolidates all button variants
///
/// Replaces NeomorphicButton, PrimaryButton, and other button duplicates
/// with a single, consistent implementation using the unified design system
class KuiButton extends StatefulWidget {

  const KuiButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.variant = ButtonVariant.elevated,
    this.size = ButtonSize.medium,
    this.width,
    this.height,
    this.borderRadius,
    this.backgroundColor,
    this.foregroundColor,
    this.padding,
    this.tooltip,
    this.icon,
    this.isLoading = false,
    this.animationDuration = DesignTokens.durationFast,
  });
  final Widget child;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final ButtonSize size;
  final double? width;
  final double? height;
  final double? borderRadius;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final EdgeInsetsGeometry? padding;
  final String? tooltip;
  final Widget? icon;
  final bool isLoading;
  final Duration animationDuration;

  @override
  State<KuiButton> createState() => _KuiButtonState();
}

class _KuiButtonState extends State<KuiButton> {
  bool _isPressed = false;
  bool _isHovered = false;

  ButtonState get _currentState {
    if (widget.onPressed == null) return ButtonState.disabled;
    if (_isPressed) return ButtonState.pressed;
    if (_isHovered) return ButtonState.hovered;
    return ButtonState.normal;
  }

  @override
  Widget build(BuildContext context) {
    final colors = KuiTheme.colorsOf(context);
    final textTheme = Theme.of(context).textTheme;

    final effectiveRadius =
        widget.borderRadius ?? _getRadiusForSize(widget.size);
    final effectivePadding = widget.padding ?? _getPaddingForSize(widget.size);
    final effectiveHeight = widget.height ?? _getHeightForSize(widget.size);

    final Widget buttonChild = _buildButtonContent(context, colors, textTheme);

    // Apply decoration based on variant
    Widget decoratedButton = _buildDecoratedButton(
      context,
      colors,
      buttonChild,
      effectiveRadius,
      effectivePadding,
      effectiveHeight,
    );

    // Wrap with tooltip if provided
    if (widget.tooltip != null) {
      decoratedButton = Tooltip(
        message: widget.tooltip!,
        child: decoratedButton,
      );
    }

    return decoratedButton;
  }

  Widget _buildButtonContent(
    BuildContext context,
    DesignColorTokens colors,
    TextTheme textTheme,
  ) {
    final effectiveForegroundColor =
        widget.foregroundColor ?? _getForegroundColor(colors);

    Widget content = widget.child;

    // Add icon if provided
    if (widget.icon != null) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          widget.icon!,
          const SizedBox(width: DesignTokens.space2),
          Flexible(child: content),
        ],
      );
    }

    // Show loading indicator if loading
    if (widget.isLoading) {
      content = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                effectiveForegroundColor,
              ),
            ),
          ),
          const SizedBox(width: DesignTokens.space2),
          Flexible(child: content),
        ],
      );
    }

    return DefaultTextStyle(
      style: _getTextStyleForSize(
        textTheme,
        widget.size,
      ).copyWith(color: effectiveForegroundColor),
      child: IconTheme(
        data: IconThemeData(
          color: effectiveForegroundColor,
          size: _getIconSizeForSize(widget.size),
        ),
        child: content,
      ),
    );
  }

  Widget _buildDecoratedButton(
    BuildContext context,
    DesignColorTokens colors,
    Widget child,
    double radius,
    EdgeInsetsGeometry padding,
    double height,
  ) {
    final effectiveBackgroundColor =
        widget.backgroundColor ?? _getBackgroundColor(colors);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Listener(
        onPointerDown: (_) => setState(() => _isPressed = true),
        onPointerUp: (_) => setState(() => _isPressed = false),
        onPointerCancel: (_) => setState(() => _isPressed = false),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: AnimatedContainer(
            duration: widget.animationDuration,
            width: widget.width,
            height: height,
            padding: padding,
            decoration: _getDecorationForVariant(
              colors,
              effectiveBackgroundColor,
              radius,
            ),
            child: Center(child: child),
          ),
        ),
      ),
    );
  }

  BoxDecoration _getDecorationForVariant(
    DesignColorTokens colors,
    Color backgroundColor,
    double radius,
  ) {
    switch (widget.variant) {
      case ButtonVariant.elevated:
        return DesignEffects.buttonState(
          colors: colors,
          state: _currentState,
          radius: radius,
          backgroundColor: backgroundColor,
        );

      case ButtonVariant.neumorphic:
        return DesignEffects.buttonState(
          colors: colors,
          state: _currentState,
          radius: radius,
          backgroundColor: backgroundColor,
        );

      case ButtonVariant.outlined:
        return BoxDecoration(
          color: _currentState == ButtonState.pressed
              ? colors.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(
            color: widget.onPressed == null
                ? colors.outline.withValues(alpha: 0.38)
                : colors.primary,
            width: _currentState == ButtonState.pressed ? 2 : 1,
          ),
        );

      case ButtonVariant.text:
        return BoxDecoration(
          color: _currentState == ButtonState.pressed
              ? colors.primary.withValues(alpha: 0.1)
              : _currentState == ButtonState.hovered
              ? colors.primary.withValues(alpha: 0.05)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(radius),
        );

      case ButtonVariant.glass:
        return DesignEffects.glassmorphic(
          colors: colors,
          radius: radius,
          opacity: _currentState == ButtonState.pressed
              ? DesignTokens.glassOpacityMedium
              : DesignTokens.glassOpacitySubtle,
        );
    }
  }

  Color _getBackgroundColor(DesignColorTokens colors) {
    switch (widget.variant) {
      case ButtonVariant.elevated:
      case ButtonVariant.neumorphic:
        return colors.primary;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
        return Colors.transparent;
      case ButtonVariant.glass:
        return colors.glassOverlay;
    }
  }

  Color _getForegroundColor(DesignColorTokens colors) {
    switch (widget.variant) {
      case ButtonVariant.elevated:
      case ButtonVariant.neumorphic:
        return colors.onPrimary;
      case ButtonVariant.outlined:
      case ButtonVariant.text:
      case ButtonVariant.glass:
        return colors.primary;
    }
  }

  double _getRadiusForSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return DesignTokens.radiusMd;
      case ButtonSize.medium:
        return DesignTokens.radiusLg;
      case ButtonSize.large:
        return DesignTokens.radiusXl;
    }
  }

  EdgeInsetsGeometry _getPaddingForSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(
          horizontal: DesignTokens.space3,
          vertical: DesignTokens.space2,
        );
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(
          horizontal: DesignTokens.space4,
          vertical: DesignTokens.space3,
        );
      case ButtonSize.large:
        return const EdgeInsets.symmetric(
          horizontal: DesignTokens.space6,
          vertical: DesignTokens.space4,
        );
    }
  }

  double _getHeightForSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return DesignTokens.buttonHeightSm;
      case ButtonSize.medium:
        return DesignTokens.buttonHeightMd;
      case ButtonSize.large:
        return DesignTokens.buttonHeightLg;
    }
  }

  TextStyle _getTextStyleForSize(TextTheme textTheme, ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return textTheme.labelMedium ?? const TextStyle();
      case ButtonSize.medium:
        return textTheme.labelLarge ?? const TextStyle();
      case ButtonSize.large:
        return textTheme.titleMedium ?? const TextStyle();
    }
  }

  double _getIconSizeForSize(ButtonSize size) {
    switch (size) {
      case ButtonSize.small:
        return 16;
      case ButtonSize.medium:
        return 20;
      case ButtonSize.large:
        return 24;
    }
  }
}

/// Button visual variants
enum ButtonVariant { elevated, neumorphic, outlined, text, glass }

/// Button size variants
enum ButtonSize { small, medium, large }
