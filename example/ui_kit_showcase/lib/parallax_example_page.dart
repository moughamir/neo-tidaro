import 'package:device_sensors/device_sensors.dart';
import 'package:flutter/material.dart';
import 'package:languist/languist.dart';

class ParallaxExamplePage extends StatefulWidget {
  const ParallaxExamplePage({super.key});

  @override
  State<ParallaxExamplePage> createState() => _ParallaxExamplePageState();
}

class _ParallaxExamplePageState extends State<ParallaxExamplePage> {
  final DeviceSensorService _sensorService = DeviceSensorService();
  Offset _offset = Offset.zero;
  bool _useMouseInput = false;

  @override
  void initState() {
    super.initState();
    _sensorService.gyroscopeEvents.listen((GyroscopeEvent event) {
      if (!_useMouseInput) {
        setState(() {
          // Simple parallax effect: move in the opposite direction of the gyroscope
          _offset = Offset(event.y * 10, event.x * 10);
        });
      }
    });
  }

  void _updateParallaxFromMouse(Offset position, Size screenSize) {
    setState(() {
      _useMouseInput = true;
      // Convert mouse position to parallax offset
      // Center the coordinates and normalize to screen size
      final centerX = screenSize.width / 2;
      final centerY = screenSize.height / 2;
      final normalizedX = (position.dx - centerX) / centerX;
      final normalizedY = (position.dy - centerY) / centerY;

      // Apply parallax effect with reasonable multipliers
      _offset = Offset(normalizedX * 50, normalizedY * 50);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text(l10n.parallaxExampleTitle),
        // Let AppBar use themed colors from AppTheme/AppBarTheme
      ),
      body: MouseRegion(
        onHover: (event) {
          final screenSize = MediaQuery.of(context).size;
          _updateParallaxFromMouse(event.position, screenSize);
        },
        onExit: (_) {
          // Reset to gyroscope input when mouse leaves
          setState(() {
            _useMouseInput = false;
          });
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Input method indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: colors.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _useMouseInput
                      ? l10n.parallaxMouseMode
                      : l10n.parallaxGyroscopeMode,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: colors.onPrimaryContainer,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              // Parallax stack
              Stack(
                alignment: Alignment.center,
                children: [
                  // Background layer
                  Transform.translate(
                    offset: _offset * -0.5, // Moves slower
                    child: _ParallaxTile(
                      size: 200,
                      color: colors.secondary.withValues(alpha: 0.5),
                      text: l10n.parallaxBackgroundText,
                      textStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Middle layer
                  Transform.translate(
                    offset: _offset * 0.5, // Moves faster
                    child: _ParallaxTile(
                      size: 150,
                      color: colors.primary.withValues(alpha: 0.5),
                      text: l10n.parallaxMiddleText,
                      textStyle: theme.textTheme.bodyMedium?.copyWith(
                        color: colors.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  // Foreground layer
                  _ParallaxTile(
                    size: 100,
                    color: colors.tertiary.withValues(alpha: 0.5),
                    text: l10n.parallaxForegroundText,
                    textStyle: theme.textTheme.bodyMedium?.copyWith(
                      color: colors.onTertiary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ParallaxTile extends StatelessWidget {
  const _ParallaxTile({
    required this.size,
    required this.color,
    required this.text,
    this.textStyle,
  });

  final double size;
  final Color color;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colors.shadow,
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Center(child: Text(text, style: textStyle)),
    );
  }
}
