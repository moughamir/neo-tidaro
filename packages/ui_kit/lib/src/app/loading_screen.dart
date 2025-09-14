import 'dart:math';
import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key, required this.message, this.subtitle});
  final String message;
  final String? subtitle;

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotationController;
  late AnimationController _bounceController;
  late AnimationController _breatheController;
  late AnimationController _floatController;
  late AnimationController _twinkleController;
  late AnimationController _sparkleController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _bounceAnimation;
  late Animation<double> _breatheAnimation;
  late Animation<double> _floatAnimation;
  late Animation<double> _twinkleAnimation;
  late Animation<double> _sparkleAnimation;

  @override
  void initState() {
    super.initState();

    // Pulse animation for text
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotation animation for sparkles
    _rotationController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    // Bounce animation for icon
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 2500),
      vsync: this,
    );
    _bounceAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.elasticInOut),
    );

    // Breathe animation for container
    _breatheController = AnimationController(
      duration: const Duration(milliseconds: 3000),
      vsync: this,
    );
    _breatheAnimation = Tween<double>(begin: 0.95, end: 1.08).animate(
      CurvedAnimation(parent: _breatheController, curve: Curves.easeInOut),
    );

    // Float animation for entire icon container
    _floatController = AnimationController(
      duration: const Duration(milliseconds: 2200),
      vsync: this,
    );
    _floatAnimation = Tween<double>(begin: -8, end: 8).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    // Twinkle animation for star eyes
    _twinkleController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _twinkleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(parent: _twinkleController, curve: Curves.easeInOut),
    );

    // Sparkle animation for star effects
    _sparkleController = AnimationController(
      duration: const Duration(milliseconds: 2800),
      vsync: this,
    );
    _sparkleAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _sparkleController, curve: Curves.easeInOut),
    );

    // Start all animations
    _pulseController.repeat(reverse: true);
    _rotationController.repeat();
    _bounceController.repeat(reverse: true);
    _breatheController.repeat(reverse: true);
    _floatController.repeat(reverse: true);
    _twinkleController.repeat(reverse: true);
    _sparkleController.repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotationController.dispose();
    _bounceController.dispose();
    _breatheController.dispose();
    _floatController.dispose();
    _twinkleController.dispose();
    _sparkleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Stack(
        children: [
          // Floating particles background
          ...List.generate(
            6,
            (index) => _buildFloatingParticle(colorScheme, index),
          ),

          // Main content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Cute animated Tidy star mascot
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Sparkle effects around the star
                    ...List.generate(8, (index) => _buildSparkle(colorScheme, index)),
                    
                    // Main star character
                    AnimatedBuilder(
                      animation: Listenable.merge([
                        _bounceController,
                        _breatheController,
                        _floatController,
                        _twinkleController,
                      ]),
                      builder: (BuildContext context, Widget? child) {
                        return Transform.translate(
                          offset: Offset(0, _floatAnimation.value),
                          child: Transform.scale(
                            scale: _bounceAnimation.value * _breatheAnimation.value,
                            child: _buildTidyStar(colorScheme),
                          ),
                        );
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 40),

                // Enhanced pulsing text
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (BuildContext context, Widget? child) {
                    return Transform.scale(
                      scale: _pulseAnimation.value,
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [colorScheme.primary, colorScheme.secondary],
                        ).createShader(bounds),
                        child: Text(
                          widget.message,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  },
                ),

                if (widget.subtitle != null) ...<Widget>[
                  const SizedBox(height: 12),
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) {
                      return Opacity(
                        opacity: 0.7 + (_pulseAnimation.value - 0.95) * 2,
                        child: Text(
                          widget.subtitle!,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface.withValues(alpha: 0.6),
                            letterSpacing: 0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    },
                  ),
                ],

                const SizedBox(height: 40),

                // Modern progress indicator
                AnimatedBuilder(
                  animation: _breatheController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 0.9 + (_breatheAnimation.value - 0.95) * 0.5,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              colorScheme.primary.withValues(alpha: 0.2),
                              colorScheme.secondary.withValues(alpha: 0.1),
                            ],
                          ),
                        ),
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            colorScheme.primary,
                          ),
                          backgroundColor: colorScheme.primary.withValues(
                            alpha: 0.1,
                          ),
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 24),

                // Enhanced animated dots with wave effect
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(5, (int index) {
                    return AnimatedBuilder(
                      animation: _pulseController,
                      builder: (BuildContext context, Widget? child) {
                        final double delay = index * 0.2;
                        final double animationValue =
                            (_pulseController.value + delay) % 1.0;
                        final double scale =
                            0.5 +
                            (animationValue < 0.5
                                    ? animationValue * 2
                                    : (1.0 - animationValue) * 2) *
                                0.5;
                        final double opacity = 0.3 + scale * 0.7;

                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 6),
                          child: Transform.scale(
                            scale: scale,
                            child: Container(
                              width: 10,
                              height: 10,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: RadialGradient(
                                  colors: [
                                    colorScheme.primary.withValues(
                                      alpha: opacity,
                                    ),
                                    colorScheme.secondary.withValues(
                                      alpha: opacity * 0.7,
                                    ),
                                  ],
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.primary.withValues(
                                      alpha: opacity * 0.5,
                                    ),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTidyStar(ColorScheme colorScheme) {
    return Container(
      width: 120,
      height: 120,
      child: CustomPaint(
        painter: _TidyStarPainter(
          primaryColor: colorScheme.primary,
          secondaryColor: colorScheme.secondary,
          tertiaryColor: colorScheme.tertiary,
          twinkleValue: _twinkleAnimation.value,
        ),
      ),
    );
  }

  Widget _buildSparkle(ColorScheme colorScheme, int index) {
    final double angle = (index * 45.0) * (pi / 180); // 8 sparkles around star
    final double distance = 80.0 + (index % 2) * 20; // Varying distances
    final double delay = index * 0.2;

    return AnimatedBuilder(
      animation: _sparkleController,
      builder: (context, child) {
        final double animationValue = (_sparkleAnimation.value + delay) % 1.0;
        final double scale = 0.3 + (sin(animationValue * 2 * pi) + 1) * 0.4;
        final double opacity = 0.4 + (sin(animationValue * 2 * pi) + 1) * 0.3;
        
        final double x = cos(angle + _sparkleAnimation.value * 2 * pi) * distance;
        final double y = sin(angle + _sparkleAnimation.value * 2 * pi) * distance;

        return Transform.translate(
          offset: Offset(x, y),
          child: Transform.scale(
            scale: scale,
            child: Container(
              width: 8,
              height: 8,
              child: CustomPaint(
                painter: _SparklePainter(
                  color: colorScheme.primary.withValues(alpha: opacity),
                  glowColor: colorScheme.secondary.withValues(alpha: opacity * 0.5),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildFloatingParticle(ColorScheme colorScheme, int index) {
    final double delay = index * 0.5;
    final double size = 4 + (index % 3) * 2;
    final double leftPosition = 50.0 + (index * 60.0) % 300;
    final double topPosition = 100.0 + (index * 80.0) % 400;

    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final double animationValue = (_floatController.value + delay) % 1.0;
        final double floatOffset = sin(animationValue * 2 * 3.14159) * 20;
        final double opacity =
            0.1 + (sin(animationValue * 2 * 3.14159) + 1) * 0.15;

        return Positioned(
          left: leftPosition,
          top: topPosition + floatOffset,
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  colorScheme.primary.withValues(alpha: opacity),
                  colorScheme.secondary.withValues(alpha: opacity * 0.5),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: colorScheme.primary.withValues(alpha: opacity * 0.3),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Custom painter for the cute Tidy star mascot
class _TidyStarPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final double twinkleValue;

  _TidyStarPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.twinkleValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.35;

    // Draw star body with gradient
    final starPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.9),
          secondaryColor.withValues(alpha: 0.8),
          tertiaryColor.withValues(alpha: 0.7),
        ],
        stops: [0.0, 0.6, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    // Draw 5-pointed star
    final starPath = _createStarPath(center, radius, radius * 0.4);
    canvas.drawPath(starPath, starPaint);

    // Draw star outline
    final outlinePaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawPath(starPath, outlinePaint);

    // Draw cute face
    _drawFace(canvas, center, radius);

    // Draw glow effect
    final glowPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15);
    canvas.drawPath(starPath, glowPaint);
  }

  Path _createStarPath(Offset center, double outerRadius, double innerRadius) {
    final path = Path();
    const int points = 5;
    const double angleStep = (2 * pi) / points;
    const double startAngle = -pi / 2; // Start from top

    for (int i = 0; i < points * 2; i++) {
      final angle = startAngle + (i * angleStep / 2);
      final radius = i.isEven ? outerRadius : innerRadius;
      final x = center.dx + cos(angle) * radius;
      final y = center.dy + sin(angle) * radius;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();
    return path;
  }

  void _drawFace(Canvas canvas, Offset center, double radius) {
    // Draw eyes
    final eyePaint = Paint()
      ..color = Colors.white.withValues(alpha: twinkleValue);
    
    final leftEye = Offset(center.dx - radius * 0.25, center.dy - radius * 0.15);
    final rightEye = Offset(center.dx + radius * 0.25, center.dy - radius * 0.15);
    
    canvas.drawCircle(leftEye, radius * 0.12, eyePaint);
    canvas.drawCircle(rightEye, radius * 0.12, eyePaint);

    // Draw eye pupils
    final pupilPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.8);
    canvas.drawCircle(leftEye, radius * 0.06, pupilPaint);
    canvas.drawCircle(rightEye, radius * 0.06, pupilPaint);

    // Draw cute smile
    final smilePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.9)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final smilePath = Path();
    smilePath.addArc(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.1),
        width: radius * 0.6,
        height: radius * 0.4,
      ),
      0,
      pi,
    );
    canvas.drawPath(smilePath, smilePaint);

    // Draw cheek blush
    final blushPaint = Paint()
      ..color = secondaryColor.withValues(alpha: 0.3);
    canvas.drawCircle(
      Offset(center.dx - radius * 0.45, center.dy + radius * 0.05),
      radius * 0.08,
      blushPaint,
    );
    canvas.drawCircle(
      Offset(center.dx + radius * 0.45, center.dy + radius * 0.05),
      radius * 0.08,
      blushPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _TidyStarPainter oldDelegate) {
    return oldDelegate.twinkleValue != twinkleValue ||
           oldDelegate.primaryColor != primaryColor ||
           oldDelegate.secondaryColor != secondaryColor ||
           oldDelegate.tertiaryColor != tertiaryColor;
  }
}

// Custom painter for sparkle effects
class _SparklePainter extends CustomPainter {
  final Color color;
  final Color glowColor;

  _SparklePainter({required this.color, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..color = color;
    final glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    // Draw 4-pointed sparkle
    final path = Path();
    path.moveTo(center.dx, center.dy - size.height * 0.4);
    path.lineTo(center.dx + size.width * 0.1, center.dy - size.height * 0.1);
    path.lineTo(center.dx + size.width * 0.4, center.dy);
    path.lineTo(center.dx + size.width * 0.1, center.dy + size.height * 0.1);
    path.lineTo(center.dx, center.dy + size.height * 0.4);
    path.lineTo(center.dx - size.width * 0.1, center.dy + size.height * 0.1);
    path.lineTo(center.dx - size.width * 0.4, center.dy);
    path.lineTo(center.dx - size.width * 0.1, center.dy - size.height * 0.1);
    path.close();

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _SparklePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.glowColor != glowColor;
  }
}
