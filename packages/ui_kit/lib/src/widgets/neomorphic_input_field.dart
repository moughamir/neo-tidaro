import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/neumorphic_styles.dart';
import 'package:ui_kit/src/theme/palette.dart';

class NeumorphicInputField extends StatefulWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final double borderRadius;
  final double blurRadius;
  final double distance;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? hintColor;

  const NeumorphicInputField({
    super.key,
    this.controller,
    this.hintText,
    this.labelText,
    this.obscureText = false,
    this.keyboardType,
    this.onChanged,
    this.validator,
    this.borderRadius = 12.0,
    this.blurRadius = 10.0,
    this.distance = 5.0,
    this.backgroundColor,
    this.textColor,
    this.hintColor,
  });

  @override
  State<NeumorphicInputField> createState() => _NeumorphicInputFieldState();
}

class _NeumorphicInputFieldState extends State<NeumorphicInputField> {
  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final palette = TidaroColorPalette.forMode(theme.brightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light);
    
    final effectiveBackgroundColor = widget.backgroundColor ?? palette.surface;
    final effectiveTextColor = widget.textColor ?? palette.onSurface;
    final effectiveHintColor = widget.hintColor ?? palette.onSurface.withOpacity(0.6);

    return Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        boxShadow: NeumorphicStyles.getShadows(
          baseColor: effectiveBackgroundColor,
          distance: widget.distance,
          blurRadius: widget.blurRadius,
          isPressed: _isFocused, // Simulate pressed state when focused
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: _focusNode,
        obscureText: widget.obscureText,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        validator: widget.validator,
        style: TextStyle(color: effectiveTextColor),
        decoration: InputDecoration(
          hintText: widget.hintText,
          labelText: widget.labelText,
          hintStyle: TextStyle(color: effectiveHintColor),
          labelStyle: TextStyle(color: effectiveHintColor),
          border: InputBorder.none, // Remove default border
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        ),
      ),
    );
  }
}
