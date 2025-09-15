import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/card.dart';

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
    const Color primaryOrange = Color(0xFFFF6B35);
    const Color secondaryOrange = Color(0xFFFF8C42);
    const Color accentOrange = Color(0xFFFFB366);

    return Scaffold(
      backgroundColor: primaryOrange,
      body: Stack(
        children: [
          // Modern geometric background with flat orange
          _buildModernBackground(),

          // Glassmorphism overlay
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.05),
                  primaryOrange.withValues(alpha: 0.8),
                  secondaryOrange.withValues(alpha: 0.6),
                ],
              ),
            ),
          ),

          // Floating particles background
          ...List.generate(8, (index) => _buildModernFloatingParticle(index)),

          // Main content with glassmorphic container
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: KuiCard.glass(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // Brand header with neumorphic effect
                        KuiCard.neumorphic(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.dashboard_rounded,
                                color: primaryOrange,
                                size: 32,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'TiDash',
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  color: primaryOrange,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.2,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 40),

                        // Cute animated Tidy star mascot with neumorphic container
                        KuiCard.neumorphic(
                          padding: const EdgeInsets.all(20),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Sparkle effects around the star
                              ...List.generate(
                                8,
                                (index) => _buildModernSparkle(index),
                              ),

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
                                      scale:
                                          _bounceAnimation.value *
                                          _breatheAnimation.value,
                                      child: Icon(Icons.star),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 32),

                        // Enhanced pulsing text with modern typography
                        AnimatedBuilder(
                          animation: _pulseAnimation,
                          builder: (BuildContext context, Widget? child) {
                            return Transform.scale(
                              scale: _pulseAnimation.value,
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    primaryOrange,
                                    secondaryOrange,
                                    accentOrange,
                                  ],
                                  stops: [0.0, 0.5, 1.0],
                                ).createShader(bounds),
                                child: Text(
                                  widget.message,
                                  style: theme.textTheme.headlineSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.8,
                                        height: 1.2,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          },
                        ),

                        if (widget.subtitle != null) ...<Widget>[
                          const SizedBox(height: 16),
                          AnimatedBuilder(
                            animation: _pulseController,
                            builder: (context, child) {
                              return Opacity(
                                opacity:
                                    0.8 + (_pulseAnimation.value - 0.95) * 2,
                                child: Text(
                                  widget.subtitle!,
                                  style: theme.textTheme.bodyLarge?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                    letterSpacing: 0.5,
                                    height: 1.4,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              );
                            },
                          ),
                        ],

                        const SizedBox(height: 40),

                        // Modern neumorphic progress indicator
                        AnimatedBuilder(
                          animation: _breatheController,
                          builder: (context, child) {
                            return Transform.scale(
                              scale:
                                  0.9 + (_breatheAnimation.value - 0.95) * 0.3,
                              child: KuiCard.neumorphic(
                                padding: const EdgeInsets.all(12),
                                child: Container(
                                  width: 60,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        primaryOrange.withValues(alpha: 0.1),
                                        secondaryOrange.withValues(alpha: 0.05),
                                      ],
                                    ),
                                  ),
                                  child: CircularProgressIndicator(
                                    strokeWidth: 4,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      primaryOrange,
                                    ),
                                    backgroundColor: primaryOrange.withValues(
                                      alpha: 0.2,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 32),

                        // Enhanced animated dots with neumorphic effect
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List<Widget>.generate(5, (int index) {
                            return AnimatedBuilder(
                              animation: _pulseController,
                              builder: (BuildContext context, Widget? child) {
                                final double delay = index * 0.15;
                                final double animationValue =
                                    (_pulseController.value + delay) % 1.0;
                                final double scale =
                                    0.6 +
                                    (animationValue < 0.5
                                            ? animationValue * 2
                                            : (1.0 - animationValue) * 2) *
                                        0.4;
                                final double opacity = 0.4 + scale * 0.6;

                                return Container(
                                  margin: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                  ),
                                  child: Transform.scale(
                                    scale: scale,
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        gradient: RadialGradient(
                                          colors: [
                                            primaryOrange.withValues(
                                              alpha: opacity,
                                            ),
                                            secondaryOrange.withValues(
                                              alpha: opacity * 0.8,
                                            ),
                                            accentOrange.withValues(
                                              alpha: opacity * 0.6,
                                            ),
                                          ],
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: primaryOrange.withValues(
                                              alpha: opacity * 0.6,
                                            ),
                                            blurRadius: 12,
                                            spreadRadius: 2,
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFFF6B35),
            const Color(0xFFFF8C42),
            const Color(0xFFFFB366),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Geometric patterns
          ...List.generate(12, (index) {
            final double size = 60 + (index % 4) * 40;
            final double left =
                (index * 80.0) % MediaQuery.of(context).size.width;
            final double top =
                (index * 120.0) % MediaQuery.of(context).size.height;
            final double rotation = (index * 30.0) * (pi / 180);

            return Positioned(
              left: left,
              top: top,
              child: Transform.rotate(
                angle: rotation,
                child: Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: index % 2 == 0
                        ? BoxShape.circle
                        : BoxShape.rectangle,
                    borderRadius: index % 2 == 1
                        ? BorderRadius.circular(12)
                        : null,
                    color: Colors.white.withValues(
                      alpha: 0.05 + (index % 3) * 0.02,
                    ),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.1),
                      width: 1,
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildModernFloatingParticle(int index) {
    const Color primaryOrange = Color(0xFFFF6B35);
    const Color secondaryOrange = Color(0xFFFF8C42);
    const Color accentOrange = Color(0xFFFFB366);

    final double delay = index * 0.3;
    final double size = 6 + (index % 4) * 3;
    final double leftPosition = 30.0 + (index * 50.0) % 350;
    final double topPosition = 80.0 + (index * 90.0) % 600;

    return AnimatedBuilder(
      animation: _floatController,
      builder: (context, child) {
        final double animationValue = (_floatController.value + delay) % 1.0;
        final double floatOffset = sin(animationValue * 2 * pi) * 25;
        final double rotationOffset = animationValue * 2 * pi;
        final double opacity = 0.15 + (sin(animationValue * 2 * pi) + 1) * 0.1;
        final double scale = 0.8 + (sin(animationValue * 2 * pi) + 1) * 0.2;

        return Positioned(
          left: leftPosition,
          top: topPosition + floatOffset,
          child: Transform.rotate(
            angle: rotationOffset,
            child: Transform.scale(
              scale: scale,
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(
                  shape: index % 3 == 0 ? BoxShape.circle : BoxShape.rectangle,
                  borderRadius: index % 3 != 0
                      ? BorderRadius.circular(size / 4)
                      : null,
                  gradient: RadialGradient(
                    colors: [
                      primaryOrange.withValues(alpha: opacity),
                      secondaryOrange.withValues(alpha: opacity * 0.7),
                      accentOrange.withValues(alpha: opacity * 0.5),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: primaryOrange.withValues(alpha: opacity * 0.4),
                      blurRadius: 8,
                      spreadRadius: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernSparkle(int index) {
    const Color primaryOrange = Color(0xFFFF6B35);
    const Color secondaryOrange = Color(0xFFFF8C42);

    final double angle = (index * 45.0) * (pi / 180);
    final double distance = 70.0 + (index % 3) * 15;
    final double delay = index * 0.25;

    return AnimatedBuilder(
      animation: _sparkleController,
      builder: (context, child) {
        final double animationValue = (_sparkleAnimation.value + delay) % 1.0;
        final double scale = 0.4 + (sin(animationValue * 2 * pi) + 1) * 0.3;
        final double opacity = 0.5 + (sin(animationValue * 2 * pi) + 1) * 0.25;
        final double rotationOffset = animationValue * 4 * pi;

        final double x = cos(angle + rotationOffset) * distance;
        final double y = sin(angle + rotationOffset) * distance;

        return Transform.translate(
          offset: Offset(x, y),
          child: Transform.rotate(
            angle: rotationOffset,
            child: Transform.scale(
              scale: scale,
              child: Container(
                width: 10,
                height: 10,
                child: CustomPaint(
                  painter: _ModernSparklePainter(
                    color: primaryOrange.withValues(alpha: opacity),
                    glowColor: secondaryOrange.withValues(alpha: opacity * 0.6),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildModernTidyStar() {
    const Color primaryOrange = Color(0xFFFF6B35);
    const Color secondaryOrange = Color(0xFFFF8C42);
    const Color accentOrange = Color(0xFFFFB366);

    return Container(
      width: 140,
      height: 140,
      child: CustomPaint(
        painter: _ModernTidyStarPainter(
          primaryColor: primaryOrange,
          secondaryColor: secondaryOrange,
          tertiaryColor: accentOrange,
          twinkleValue: _twinkleAnimation.value,
        ),
      ),
    );
  }
}

// Custom painter for modern Tidy star mascot
class _ModernTidyStarPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final Color tertiaryColor;
  final double twinkleValue;

  _ModernTidyStarPainter({
    required this.primaryColor,
    required this.secondaryColor,
    required this.tertiaryColor,
    required this.twinkleValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width * 0.38;

    // Draw star body with enhanced gradient
    final starPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          primaryColor.withValues(alpha: 0.95),
          secondaryColor.withValues(alpha: 0.85),
          tertiaryColor.withValues(alpha: 0.75),
        ],
        stops: [0.0, 0.7, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: radius));

    // Draw 5-pointed star
    final starPath = _createStarPath(center, radius, radius * 0.45);
    canvas.drawPath(starPath, starPaint);

    // Draw enhanced star outline
    final outlinePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawPath(starPath, outlinePaint);

    // Draw cute face
    _drawModernFace(canvas, center, radius);

    // Draw enhanced glow effect
    final glowPaint = Paint()
      ..color = primaryColor.withValues(alpha: 0.3)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);
    canvas.drawPath(starPath, glowPaint);
  }

  Path _createStarPath(Offset center, double outerRadius, double innerRadius) {
    final path = Path();
    const int points = 5;
    const double angleStep = (2 * pi) / points;
    const double startAngle = -pi / 2;

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

  void _drawModernFace(Canvas canvas, Offset center, double radius) {
    // Draw enhanced eyes with twinkle effect
    final eyePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95 + twinkleValue * 0.05);

    final leftEye = Offset(
      center.dx - radius * 0.28,
      center.dy - radius * 0.18,
    );
    final rightEye = Offset(
      center.dx + radius * 0.28,
      center.dy - radius * 0.18,
    );

    canvas.drawCircle(leftEye, radius * 0.14, eyePaint);
    canvas.drawCircle(rightEye, radius * 0.14, eyePaint);

    // Draw eye pupils with sparkle
    final pupilPaint = Paint()..color = primaryColor.withValues(alpha: 0.9);
    canvas.drawCircle(leftEye, radius * 0.08, pupilPaint);
    canvas.drawCircle(rightEye, radius * 0.08, pupilPaint);

    // Draw eye sparkles
    final sparklePaint = Paint()
      ..color = Colors.white.withValues(alpha: twinkleValue);
    canvas.drawCircle(
      Offset(leftEye.dx + radius * 0.04, leftEye.dy - radius * 0.04),
      radius * 0.02,
      sparklePaint,
    );
    canvas.drawCircle(
      Offset(rightEye.dx + radius * 0.04, rightEye.dy - radius * 0.04),
      radius * 0.02,
      sparklePaint,
    );

    // Draw enhanced smile
    final smilePaint = Paint()
      ..color = Colors.white.withValues(alpha: 0.95)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;

    final smilePath = Path();
    smilePath.addArc(
      Rect.fromCenter(
        center: Offset(center.dx, center.dy + radius * 0.12),
        width: radius * 0.7,
        height: radius * 0.45,
      ),
      0,
      pi,
    );
    canvas.drawPath(smilePath, smilePaint);

    // Draw enhanced cheek blush
    final blushPaint = Paint()..color = secondaryColor.withValues(alpha: 0.4);
    canvas.drawCircle(
      Offset(center.dx - radius * 0.5, center.dy + radius * 0.08),
      radius * 0.1,
      blushPaint,
    );
    canvas.drawCircle(
      Offset(center.dx + radius * 0.5, center.dy + radius * 0.08),
      radius * 0.1,
      blushPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _ModernTidyStarPainter oldDelegate) {
    return oldDelegate.twinkleValue != twinkleValue ||
        oldDelegate.primaryColor != primaryColor ||
        oldDelegate.secondaryColor != secondaryColor ||
        oldDelegate.tertiaryColor != tertiaryColor;
  }
}

// Custom painter for modern sparkle effects
class _ModernSparklePainter extends CustomPainter {
  final Color color;
  final Color glowColor;

  _ModernSparklePainter({required this.color, required this.glowColor});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()..color = color;
    final glowPaint = Paint()
      ..color = glowColor
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);

    // Draw enhanced 6-pointed sparkle
    final path = Path();
    path.moveTo(center.dx, center.dy - size.height * 0.45);
    path.lineTo(center.dx + size.width * 0.08, center.dy - size.height * 0.08);
    path.lineTo(center.dx + size.width * 0.45, center.dy);
    path.lineTo(center.dx + size.width * 0.08, center.dy + size.height * 0.08);
    path.lineTo(center.dx, center.dy + size.height * 0.45);
    path.lineTo(center.dx - size.width * 0.08, center.dy + size.height * 0.08);
    path.lineTo(center.dx - size.width * 0.45, center.dy);
    path.lineTo(center.dx - size.width * 0.08, center.dy - size.height * 0.08);
    path.close();

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ModernSparklePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.glowColor != glowColor;
  }
}
