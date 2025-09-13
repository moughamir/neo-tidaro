import 'package:flutter/material.dart';
import 'package:ui_kit/ui_kit.dart';

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
    final isDesktop = MediaQuery.of(context).size.width >= 768;

    if (isDesktop) {
      return _buildDesktopLayout(context, theme);
    } else {
      return _buildMobileLayout(context, theme);
    }
  }

  // DRY helper: top controls row used in both mobile header and desktop right column
  Widget _buildControlsRow(
    ThemeData theme,
    {
      bool compactBrand = false,
    }
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildBrandSection(theme, compact: compactBrand),
        Row(
          children: [
            _buildLanguageSelector(theme),
            const SizedBox(width: 8),
            _buildThemeToggle(theme),
          ],
        ),
      ],
    );
  }

  Widget _buildDesktopLayout(
    BuildContext context,
    ThemeData theme,
  ) {
    return Scaffold(
      body: Row(
        children: [
          Flexible(flex: 1, child: _buildLeftColumn(context, theme)),
          Flexible(flex: 1, child: _buildRightColumn(context, theme)),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(
    BuildContext context,
    ThemeData theme,
  ) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              image: backgroundImage != null
                  ? DecorationImage(
                      image: AssetImage(backgroundImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
              gradient: backgroundImage == null
                  ? _buildTiDashGradient(theme)
                  : null,
            ),
            child: _GradientOverlay(
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      _buildControlsRow(theme, compactBrand: true),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
      child: _GradientOverlay(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBrandSection(theme),
              const Spacer(),
              _buildQuoteSection(theme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRightColumn(
    BuildContext context,
    ThemeData theme,
  ) {
    return Container(
      color: theme.colorScheme.surface,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            child: _buildControlsRow(theme),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBrandSection(ThemeData theme, {bool compact = true}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: compact ? 32 : 48,
          height: compact ? 32 : 48,
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: theme.colorScheme.onPrimaryContainer.withValues(
                alpha: 0.3,
              ),
              width: 1,
            ),
          ),
          child: Icon(
            Icons.dashboard_rounded,
            color: theme.colorScheme.primary,
            size: compact ? 20 : 28,
          ),
        ),
        const SizedBox(width: 12),
        Text(
          'TiDash',
          style: theme.textTheme.headlineSmall?.copyWith(
            color: theme.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
            fontSize: compact ? 20 : 24,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildQuoteSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.onPrimaryContainer,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.colorScheme.primary, width: 1),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.format_quote,
                color: theme.colorScheme.primary,
                size: 32,
              ),
              const SizedBox(height: 12),
              Text(
                'Transform your workflow with powerful analytics and intuitive design. Built for modern teams.',
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onPrimaryContainer,
                  height: 1.6,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '— TiDash Team',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  LinearGradient _buildTiDashGradient(ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: isDark
          ? const [
              Color(0xFF1A1A1A),
              Color(0xFF2D1B1B),
              Color(0xFF3D2914),
              Color(0xFF1A1A1A),
            ]
          : const [
              Color(0xFFFF8C00),
              Color(0xFFFF7F00),
              Color(0xFFFF6B35),
              Color(0xFFE55D00),
            ],
      stops: const [0.0, 0.3, 0.7, 1.0],
    );
  }

  Widget _buildThemeToggle(ThemeData theme) {
    return _ControlContainer(
      child: IconButton(
        onPressed: onThemeToggle,
        icon: Icon(
          isDarkMode ? Icons.light_mode : Icons.dark_mode,
          color: isDarkMode
              ? theme.colorScheme.primary
              : theme.colorScheme.onPrimaryContainer,
          size: 20,
        ),
        tooltip: isDarkMode ? 'Light Mode' : 'Dark Mode',
      ),
    );
  }

  Widget _buildLanguageSelector(ThemeData theme) {
    final languages = {
      'en': 'English',
      'ar': 'العربية',
      'es': 'Español',
      'fr': 'Français',
    };

    return _ControlContainer(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentLanguage,
          onChanged: (String? value) => onLanguageChanged?.call(value!),
          icon: Icon(
            Icons.language,
            color: theme.colorScheme.primary,
            size: 16,
          ),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.primary,
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

/// A container that applies a dark gradient overlay.
class _GradientOverlay extends StatelessWidget {
  const _GradientOverlay({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            // TODO: Add Gradient color constants from designSystem (Glitchy//Synthwavee style red/blue)
            Color(0xFF07D4E7),
            Color(0xFFEA0559),
          ],
        ),
      ),
      child: child,
    );
  }
}

/// A container for the theme and language controls with a consistent style.
class _ControlContainer extends StatelessWidget {
  const _ControlContainer({required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: const Color(0xFF07D4E7),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1),
      ),
      child: child,
    );
  }
}
