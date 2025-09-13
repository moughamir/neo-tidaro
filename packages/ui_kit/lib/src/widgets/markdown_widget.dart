import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';

/// Configuration class for markdown styling
class MarkdownConfig {

  const MarkdownConfig({
    this.headingStyle,
    this.bodyStyle,
    this.codeStyle,
    this.linkColor,
    this.padding,
    this.selectable = true,
    this.shrinkWrap = false,
    this.physics,
    this.customStyleSheet,
  });
  final TextStyle? headingStyle;
  final TextStyle? bodyStyle;
  final TextStyle? codeStyle;
  final Color? linkColor;
  final EdgeInsetsGeometry? padding;
  final bool selectable;
  final bool shrinkWrap;
  final ScrollPhysics? physics;
  final MarkdownStyleSheet? customStyleSheet;

  /// Creates a copy of this configuration with the given fields replaced with new values
  MarkdownConfig copyWith({
    TextStyle? headingStyle,
    TextStyle? bodyStyle,
    TextStyle? codeStyle,
    Color? linkColor,
    EdgeInsetsGeometry? padding,
    bool? selectable,
    bool? shrinkWrap,
    ScrollPhysics? physics,
    MarkdownStyleSheet? customStyleSheet,
  }) {
    return MarkdownConfig(
      headingStyle: headingStyle ?? this.headingStyle,
      bodyStyle: bodyStyle ?? this.bodyStyle,
      codeStyle: codeStyle ?? this.codeStyle,
      linkColor: linkColor ?? this.linkColor,
      padding: padding ?? this.padding,
      selectable: selectable ?? this.selectable,
      shrinkWrap: shrinkWrap ?? this.shrinkWrap,
      physics: physics ?? this.physics,
      customStyleSheet: customStyleSheet ?? this.customStyleSheet,
    );
  }

  /// Default configuration with Material Design 3 styling
  static MarkdownConfig defaultConfig(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MarkdownConfig(
      headingStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        color: colorScheme.onSurface,
      ),
      bodyStyle: GoogleFonts.inter(
        fontSize: 14,
        height: 1.5,
        color: colorScheme.onSurface.withOpacity(0.87),
      ),
      codeStyle: GoogleFonts.firaCode(
        fontSize: 13,
        backgroundColor: colorScheme.surfaceContainerHighest,
        color: colorScheme.onSurface,
      ),
      linkColor: colorScheme.primary,
      padding: const EdgeInsets.all(16),
      selectable: true,
      shrinkWrap: false,
    );
  }

  /// Compact configuration for smaller spaces
  static MarkdownConfig compactConfig(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return MarkdownConfig(
      headingStyle: GoogleFonts.inter(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: colorScheme.onSurface,
      ),
      bodyStyle: GoogleFonts.inter(
        fontSize: 12,
        height: 1.4,
        color: colorScheme.onSurface.withOpacity(0.87),
      ),
      codeStyle: GoogleFonts.firaCode(
        fontSize: 11,
        backgroundColor: colorScheme.surfaceContainerHighest,
        color: colorScheme.onSurface,
      ),
      linkColor: colorScheme.primary,
      padding: const EdgeInsets.all(8),
      selectable: true,
      shrinkWrap: true,
    );
  }
}

/// A functional, DRY markdown widget wrapper that provides consistent styling
/// and behavior across the application.
class MarkdownWidget extends StatelessWidget {

  const MarkdownWidget({
    super.key,
    required this.data,
    required this.config,
    this.onTapLink,
    this.sizedImageBuilder,
    this.controller,
    this.errorBuilder,
    this.loadingWidget,
    this.isLoading = false,
    this.maxHeight,
    this.minHeight,
  });

  /// Factory constructor for default styling
  factory MarkdownWidget.defaultStyle({
    Key? key,
    required String data,
    required BuildContext context,
    MarkdownTapLinkCallback? onTapLink,
    MarkdownSizedImageBuilder? sizedImageBuilder,
    ScrollController? controller,
    double? maxHeight,
    double? minHeight,
  }) {
    return MarkdownWidget(
      key: key,
      data: data,
      config: MarkdownConfig.defaultConfig(context),
      onTapLink: onTapLink,
      sizedImageBuilder: sizedImageBuilder,
      controller: controller,
      maxHeight: maxHeight,
      minHeight: minHeight,
    );
  }

  /// Factory constructor for dark theme styling
  factory MarkdownWidget.dark({
    Key? key,
    required String data,
    required BuildContext context,
    MarkdownTapLinkCallback? onTapLink,
    MarkdownSizedImageBuilder? sizedImageBuilder,
    ScrollController? controller,
    double? maxHeight,
    double? minHeight,
  }) {
    return MarkdownWidget(
      key: key,
      data: data,
      config: MarkdownConfig.defaultConfig(context),
      onTapLink: onTapLink,
      sizedImageBuilder: sizedImageBuilder,
      controller: controller,
      maxHeight: maxHeight,
      minHeight: minHeight,
    );
  }

  /// Factory constructor for compact styling
  factory MarkdownWidget.compact({
    Key? key,
    required String data,
    required BuildContext context,
    MarkdownTapLinkCallback? onTapLink,
    MarkdownSizedImageBuilder? sizedImageBuilder,
    ScrollController? controller,
    double? maxHeight,
    double? minHeight,
  }) {
    return MarkdownWidget(
      key: key,
      data: data,
      config: MarkdownConfig.compactConfig(context),
      onTapLink: onTapLink,
      sizedImageBuilder: sizedImageBuilder,
      controller: controller,
      maxHeight: maxHeight,
      minHeight: minHeight,
    );
  }

  /// Factory constructor for loading state
  factory MarkdownWidget.loading({
    Key? key,
    required BuildContext context,
    Widget? loadingWidget,
    MarkdownConfig? config,
  }) {
    return MarkdownWidget(
      key: key,
      data: '',
      config: config ?? MarkdownConfig.defaultConfig(context),
      isLoading: true,
      loadingWidget: loadingWidget,
    );
  }
  /// The markdown content to display
  final String data;

  /// Configuration for styling and behavior
  final MarkdownConfig config;

  /// Optional callback for link taps
  final MarkdownTapLinkCallback? onTapLink;

  /// Optional callback for image building with size information
  final MarkdownSizedImageBuilder? sizedImageBuilder;

  /// Optional controller for scrolling
  final ScrollController? controller;

  /// Optional error widget builder
  final Widget Function(String error)? errorBuilder;

  /// Optional loading widget
  final Widget? loadingWidget;

  /// Whether to show a loading state
  final bool isLoading;

  /// Optional maximum height constraint
  final double? maxHeight;

  /// Optional minimum height constraint
  final double? minHeight;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingWidget();
    }

    if (data.isEmpty) {
      return _buildEmptyWidget();
    }

    try {
      final markdownWidget = _buildMarkdownWidget(context);

      if (maxHeight != null || minHeight != null) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxHeight ?? double.infinity,
            minHeight: minHeight ?? 0,
          ),
          child: markdownWidget,
        );
      }

      return markdownWidget;
    } catch (error) {
      return _buildErrorWidget(error.toString());
    }
  }

  Widget _buildMarkdownWidget(BuildContext context) {
    final styleSheet = _buildStyleSheet(context);

    return Padding(
      padding: config.padding ?? EdgeInsets.zero,
      child: Markdown(
        data: data,
        styleSheet: styleSheet,
        onTapLink: onTapLink,
        sizedImageBuilder: sizedImageBuilder,
        shrinkWrap: config.shrinkWrap,
        physics: config.physics ?? const AlwaysScrollableScrollPhysics(),
        controller: controller,
        selectable: config.selectable,
      ),
    );
  }

  MarkdownStyleSheet _buildStyleSheet(BuildContext context) {
    if (config.customStyleSheet != null) {
      return config.customStyleSheet!;
    }

    final theme = Theme.of(context);

    return MarkdownStyleSheet(
      h1:
          config.headingStyle?.copyWith(fontSize: 24) ??
          theme.textTheme.headlineMedium,
      h2:
          config.headingStyle?.copyWith(fontSize: 20) ??
          theme.textTheme.headlineSmall,
      h3:
          config.headingStyle?.copyWith(fontSize: 18) ??
          theme.textTheme.titleLarge,
      h4:
          config.headingStyle?.copyWith(fontSize: 16) ??
          theme.textTheme.titleMedium,
      h5:
          config.headingStyle?.copyWith(fontSize: 14) ??
          theme.textTheme.titleSmall,
      h6:
          config.headingStyle?.copyWith(fontSize: 12) ??
          theme.textTheme.labelLarge,
      p: config.bodyStyle ?? theme.textTheme.bodyMedium,
      code:
          config.codeStyle ??
          GoogleFonts.firaCode(
            fontSize: 13,
            backgroundColor: theme.colorScheme.surfaceContainerHighest,
          ),
      codeblockDecoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      a: TextStyle(
        color: config.linkColor ?? theme.colorScheme.primary,
        decoration: TextDecoration.underline,
      ),
      blockquote: TextStyle(
        color: theme.colorScheme.onSurfaceVariant,
        fontStyle: FontStyle.italic,
      ),
      blockquoteDecoration: BoxDecoration(
        border: Border(
          left: BorderSide(color: theme.colorScheme.outline, width: 4),
        ),
      ),
    );
  }

  Widget _buildLoadingWidget() {
    return loadingWidget ??
        const Center(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: CircularProgressIndicator(),
          ),
        );
  }

  Widget _buildEmptyWidget() {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'No content available',
          style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    if (errorBuilder != null) {
      return errorBuilder!(error);
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red[50],
        border: Border.all(color: Colors.red[200]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: Colors.red[600]),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Error rendering markdown: $error',
              style: TextStyle(color: Colors.red[700]),
            ),
          ),
        ],
      ),
    );
  }
}

/// Extension methods for common markdown operations
extension MarkdownExtensions on String {
  /// Converts this string to a MarkdownWidget with default styling
  Widget toMarkdown({
    required BuildContext context,
    MarkdownConfig? config,
    MarkdownTapLinkCallback? onTapLink,
    MarkdownSizedImageBuilder? sizedImageBuilder,
  }) {
    return MarkdownWidget(
      data: this,
      config: config ?? MarkdownConfig.defaultConfig(context),
      onTapLink: onTapLink,
      sizedImageBuilder: sizedImageBuilder,
    );
  }

  /// Converts this string to a compact MarkdownWidget
  Widget toCompactMarkdown({
    required BuildContext context,
    MarkdownTapLinkCallback? onTapLink,
    MarkdownSizedImageBuilder? sizedImageBuilder,
  }) {
    return MarkdownWidget.compact(
      data: this,
      context: context,
      onTapLink: onTapLink,
      sizedImageBuilder: sizedImageBuilder,
    );
  }

  /// Converts this string to a dark theme MarkdownWidget
  Widget toDarkMarkdown({
    required BuildContext context,
    MarkdownTapLinkCallback? onTapLink,
    MarkdownSizedImageBuilder? sizedImageBuilder,
  }) {
    return MarkdownWidget.dark(
      data: this,
      context: context,
      onTapLink: onTapLink,
      sizedImageBuilder: sizedImageBuilder,
    );
  }
}
