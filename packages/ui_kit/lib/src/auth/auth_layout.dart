import 'package:flutter/material.dart';
import 'package:languist/languist.dart';

/// Responsive two-column authentication layout
/// Left column: Themed gradient background with brand and quote
/// Right column: Authentication form with theme controls
class AuthLayout extends StatelessWidget {
  const AuthLayout({
    super.key,
    required this.child,
    this.backgroundImage,
    this.onThemeToggle,
    this.onLanguageChanged,
    this.isDarkMode = false,
    this.currentLanguage = 'en',
  });

  final Widget child;
  final String? backgroundImage;
  final VoidCallback? onThemeToggle;
  final ValueChanged<String>? onLanguageChanged;
  final bool isDarkMode;
  final String currentLanguage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = Languist.of(context);
    final screenSize = MediaQuery.of(context).size;
    final isDesktop = screenSize.width >= 768;

    if (isDesktop) {
      return _buildDesktopLayout(context, theme, l10n);
    } else {
      return _buildMobileLayout(context, theme, l10n);
    }
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ThemeData theme,
    IntlLocalizations l10n,
  ) {
    return Scaffold(
      body: Row(
        children: [
          // Left column - Themed gradient background with brand and quote
          Expanded(flex: 1, child: _buildLeftColumn(context, theme, l10n)),
          // Right column - Authentication form with controls
          Expanded(flex: 1, child: _buildRightColumn(context, theme, l10n)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    ThemeData theme,
    IntlLocalizations l10n,
  ) {
    return Scaffold(
      body: Column(
        children: [
          // Top section - Compact brand with controls
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              image: backgroundImage != null
                  ? DecorationImage(
                      image: AssetImage(backgroundImage!),
                      fit: BoxFit.fill,
                    )
                  : null,
              gradient: backgroundImage == null
                  ? _buildTiDashGradient(theme)
                  : null,
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black.withValues(alpha: 0.3),
                    Colors.black.withValues(alpha: 0.1),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      // Controls row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _buildBrandSection(theme, compact: true),
                          Row(
                            children: [
                              _buildLanguageSelector(theme, l10n),
                              const SizedBox(width: 8),
                              _buildThemeToggle(theme),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Bottom section - Authentication form
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLeftColumn(
    BuildContext context,
    ThemeData theme,
    IntlLocalizations l10n,
  ) {
    return Container(
      decoration: BoxDecoration(
        image: backgroundImage != null
            ? DecorationImage(
                image: AssetImage(backgroundImage!),
                fit: BoxFit.cover,
              )
            : null,
        gradient: backgroundImage == null ? _buildTiDashGradient(theme) : null,
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.black.withValues(alpha: 0.4),
              Colors.black.withValues(alpha: 0.2),
            ],
          ),
        ),
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Brand section at top-left
            _buildBrandSection(theme),

            const Spacer(),

            // Today's quote at bottom-left
            _buildQuoteSection(theme, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildRightColumn(
    BuildContext context,
    ThemeData theme,
    IntlLocalizations l10n,
  ) {
    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          // Controls bar at top
          Container(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildLanguageSelector(theme, l10n),
                const SizedBox(width: 12),
                _buildThemeToggle(theme),
              ],
            ),
          ),
          // Auth form content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 400),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection(ThemeData theme, {bool compact = false}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // TiDash logo with orange accent
        Container(
          width: compact ? 32 : 48,
          height: compact ? 32 : 48,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: Icon(
            Icons.dashboard_rounded,
            color: Colors.white,
            size: compact ? 20 : 28,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'TiDash',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: compact ? 20 : 24,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteSection(ThemeData theme, IntlLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.format_quote,
                color: Colors.white.withValues(alpha: 0.7),
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                'Transform your workflow with powerful analytics and intuitive design. Built for modern teams.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.6,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '— TiDash Team',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  /// Creates TiDash-themed gradient with orange accent
  LinearGradient _buildTiDashGradient(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;

    if (isDark) {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF1A1A1A), // Dark base
          Color(0xFF2D1B1B), // Dark with orange tint
          Color(0xFF3D2914), // Darker orange
          Color(0xFF1A1A1A), // Back to dark
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      );
    } else {
      return const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFF8C00), // Orange accent
          Color(0xFFFF7F00), // Bright orange
          Color(0xFFFF6B35), // Orange-red
          Color(0xFFE55D00), // Deeper orange
        ],
        stops: [0.0, 0.3, 0.7, 1.0],
      );
    }
  }

  /// Builds theme toggle button
  Widget _buildThemeToggle(ThemeData theme) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: onThemeToggle,
        icon: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: Colors.white,
          size: 20,
        ),
        tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
      ),
    );
  }

  /// Builds language selector dropdown
  Widget _buildLanguageSelector(ThemeData theme, IntlLocalizations l10n) {
    final languages = {
      'en': 'English',
      'ar': 'العربية',
      'es': 'Español',
      'fr': 'Français',
      'zgh': 'ⵜⴰⵎⴰⵣⵉⵖⵜ',
    };

    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLanguage,
          onChanged: (String? value) => onLanguageChanged?.call(value!),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: Colors.white.withValues(alpha: 0.7),
            size: 16,
          ),
          style: theme.textTheme.bodySmall?.copyWith(
            color: Colors.white,
            fontSize: 12,
          ),
          dropdownColor: theme.colorScheme.surface,
          items: languages.entries.map((entry) {
            return DropdownMenuItem<String>(
              value: entry.key,
              child: Text(
                entry.value,
                style: TextStyle(
                  color: theme.colorScheme.onSurface,
                  fontSize: 12,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
