import 'dart:ui';
import 'package:languist/languist.dart';
import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

/// Modern base authentication page with enhanced UX and animations
abstract class BaseAuthPage extends StatefulWidget {
  const BaseAuthPage({super.key});

  /// Build the auth form content (login fields, signup fields, etc.)
  Widget buildAuthContent(BuildContext context, IntlLocalizations l10n);

  @override
  State<BaseAuthPage> createState() => _BaseAuthPageState();
}

class _BaseAuthPageState extends State<BaseAuthPage>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _fadeController;
  late AnimationController _geometricController;
  late AnimationController _pulseController;
  late AnimationController _floatController;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;
  late Animation<double> _rotationAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _floatAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _geometricController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    );

    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _floatController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    );

    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _rotationAnimation = Tween<double>(begin: 0, end: 2 * 3.14159).animate(
      CurvedAnimation(parent: _geometricController, curve: Curves.linear),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _floatAnimation = Tween<double>(begin: -10, end: 10).animate(
      CurvedAnimation(parent: _floatController, curve: Curves.easeInOut),
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _fadeController, curve: Curves.easeOut));

    // Start animations
    _fadeController.forward();
    _slideController.forward();
    _geometricController.repeat();
    _pulseController.repeat(reverse: true);
    _floatController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _slideController.dispose();
    _fadeController.dispose();
    _geometricController.dispose();
    _pulseController.dispose();
    _floatController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return StoreConnector<AppState, UiState>(
      converter: (Store<AppState> store) => store.state.uiState,
      builder: (BuildContext context, UiState uiState) {
        return Scaffold(
          backgroundColor: const Color(0xFFFF6B35), // Flat orange background
          body: Stack(
            children: [
              // Background with geometric patterns
              _buildBackgroundWithPatterns(),

              // Main content
              SafeArea(
                child: Column(
                  children: [
                    // Modern header with glassmorphism
                    _buildGlassmorphicHeader(context, uiState, theme),

                    // Main content with animations
                    Expanded(
                      child: Center(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(
                                  maxWidth: 400,
                                ),
                                child: _buildGlassmorphicCard(
                                  context,
                                  l10n,
                                  theme,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBackgroundWithPatterns() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/orange.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Color overlay to maintain the orange theme and ensure readability
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFF6B35).withValues(alpha: 0.07),
                  const Color(0xFFFF8C42).withValues(alpha: 0.6),
                  const Color(0xFFFFB366).withValues(alpha: 0.05),
                ],
              ),
            ),
          ),

          // Animated geometric patterns overlay
          AnimatedBuilder(
            animation: Listenable.merge([_pulseController, _floatController]),
            builder: (context, child) {
              return Positioned(
                top: -100 + _floatAnimation.value,
                right: -100,
                child: Transform.scale(
                  scale: _pulseAnimation.value,
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white.withValues(alpha: (0.1 * _pulseAnimation.value).clamp(0.0, 1.0)),
                          Colors.deepOrangeAccent.withValues(alpha: (0.3 * _pulseAnimation.value).clamp(0.0, 1.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: Listenable.merge([_pulseController, _floatController]),
            builder: (context, child) {
              return Positioned(
                bottom: -150 + (_floatAnimation.value * 0.5),
                left: -150,
                child: Transform.scale(
                  scale: 1.0 + (_pulseAnimation.value - 1.0) * 0.3,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFFFF8C42).withValues(alpha: (0.15 * _pulseAnimation.value).clamp(0.0, 1.0)),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Animated floating geometric shapes
          AnimatedBuilder(
            animation: Listenable.merge([_geometricController, _floatController, _pulseController]),
            builder: (context, child) {
              return Positioned(
                top: 150 + _floatAnimation.value * 0.8,
                left: 50 + _floatAnimation.value * 0.3,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 0.5,
                  child: Transform.scale(
                    scale: 0.9 + (_pulseAnimation.value - 1.0) * 0.2,
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: (0.08 * _pulseAnimation.value).clamp(0.0, 1.0)),
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.white.withValues(alpha: (0.1 * _pulseAnimation.value).clamp(0.0, 1.0)),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: Listenable.merge([_geometricController, _floatController, _pulseController]),
            builder: (context, child) {
              return Positioned(
                bottom: 200 + _floatAnimation.value * -0.6,
                right: 80 + _floatAnimation.value * 0.4,
                child: Transform.rotate(
                  angle: -_rotationAnimation.value * 0.3,
                  child: Transform.scale(
                    scale: 1.0 + (_pulseAnimation.value - 1.0) * 0.15,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withValues(alpha: (0.12 * _pulseAnimation.value).clamp(0.0, 1.0)),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF8C42).withValues(alpha: (0.2 * _pulseAnimation.value).clamp(0.0, 1.0)),
                            blurRadius: 6,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          // Additional animated geometric elements
          AnimatedBuilder(
            animation: Listenable.merge([_geometricController, _pulseController]),
            builder: (context, child) {
              return Positioned(
                top: 300,
                right: 30,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * 0.8,
                  child: Transform.scale(
                    scale: 0.8 + (_pulseAnimation.value - 1.0) * 0.3,
                    child: Container(
                      width: 25,
                      height: 25,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFB366).withValues(alpha: (0.15 * _pulseAnimation.value).clamp(0.0, 1.0)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: Listenable.merge([_geometricController, _floatController]),
            builder: (context, child) {
              return Positioned(
                bottom: 100,
                left: 30,
                child: Transform.rotate(
                  angle: _rotationAnimation.value * -0.4,
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.1),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildGlassmorphicHeader(
    BuildContext context,
    UiState uiState,
    ThemeData theme,
  ) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Brand logo with neumorphic effect
                Row(
                  children: [
                    KuiCard.neumorphic(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.dashboard_rounded,
                        color: const Color(0xFFFF6B35),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      'TiDash',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // Controls with glassmorphism
                Row(
                  children: [
                    // Theme toggle with neumorphic effect
                    KuiButton(
                      variant: ButtonVariant.neumorphic,
                      size: ButtonSize.small,
                      onPressed: () {
                        StoreProvider.of<AppState>(
                          context,
                          listen: false,
                        ).dispatch(const ToggleThemeModeAction());
                      },
                      child: Icon(
                        uiState.themeMode == ThemeMode.dark ||
                                (uiState.themeMode == ThemeMode.system &&
                                    theme.brightness == Brightness.dark)
                            ? Icons.light_mode_outlined
                            : Icons.dark_mode_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Language selector with glassmorphism
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: PopupMenuButton<String>(
                          onSelected: (String language) {
                            StoreProvider.of<AppState>(
                              context,
                              listen: false,
                            ).dispatch(ChangeLanguageAction(language));
                          },
                          itemBuilder: (context) => [
                            const PopupMenuItem(
                              value: 'en',
                              child: Text('🇺🇸 English'),
                            ),
                            const PopupMenuItem(
                              value: 'ar',
                              child: Text('🇲🇦 العربية'),
                            ),
                            const PopupMenuItem(
                              value: 'fr',
                              child: Text('🇫🇷 Français'),
                            ),
                            const PopupMenuItem(
                              value: 'es',
                              child: Text('🇪🇸 Español'),
                            ),
                            const PopupMenuItem(
                              value: 'zgh',
                              child: Text('🏔️ ⵜⴰⵎⴰⵣⵉⵖⵜ'),
                            ),
                          ],
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  _getLanguageFlag(uiState.locale.languageCode),
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  size: 16,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGlassmorphicCard(
    BuildContext context,
    IntlLocalizations l10n,
    ThemeData theme,
  ) {
    return KuiCard.glass(
      padding: const EdgeInsets.all(8),
      child: widget.buildAuthContent(context, l10n),
    );
  }

  String _getLanguageFlag(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return '🇲🇦';
      case 'fr':
        return '🇫🇷';
      case 'es':
        return '🇪🇸';
      case 'zgh':
        return '🏔️';
      default:
        return '🇺🇸';
    }
  }
}
