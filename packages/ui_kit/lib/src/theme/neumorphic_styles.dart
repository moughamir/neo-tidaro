import 'package:flutter/material.dart';

class NeumorphicStyles {
  static List<BoxShadow> getShadows({
    required Color baseColor,
    required double distance,
    required double blurRadius,
    bool isPressed = false,
  }) {
    final lightShadowColor = baseColor.withOpacity(0.7); // Lighter shadow for highlight
    final darkShadowColor = baseColor.withOpacity(0.3); // Darker shadow for depth

    if (isPressed) {
      return [
        BoxShadow(
          color: darkShadowColor,
          offset: Offset(distance / 2, distance / 2),
          blurRadius: blurRadius / 2,
        ),
        BoxShadow(
          color: lightShadowColor,
          offset: Offset(-distance / 2, -distance / 2),
          blurRadius: blurRadius / 2,
        ),
      ];
    } else {
      return [
        BoxShadow(
          color: darkShadowColor,
          offset: Offset(distance, distance),
          blurRadius: blurRadius,
        ),
        BoxShadow(
          color: lightShadowColor,
          offset: Offset(-distance, -distance),
          blurRadius: blurRadius,
        ),
      ];
    }
  }
}
