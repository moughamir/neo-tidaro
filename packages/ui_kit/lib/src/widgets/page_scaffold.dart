import 'package:flutter/material.dart';
import 'package:ui_kit/src/design_system/design_system.dart';

/// A standardized page scaffold using Material UI with Neumorphism styling
///
/// Provides consistent page layout across the application
class PageScaffold extends StatelessWidget {
  /// Page title displayed in the header
  final String? title;

  /// Main page content
  final Widget content;

  /// Optional header actions
  final List<Widget>? actions;

  /// Optional navigation drawer
  final Widget? drawer;

  /// Whether to automatically imply leading widget (back button)
  final bool automaticallyImplyLeading;

  /// Optional padding for the content
  final EdgeInsets? contentPadding;

  const PageScaffold({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.drawer,
    this.automaticallyImplyLeading = true,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = DesignTokens.colorsFor(theme.brightness);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: title != null ? Text(title!) : null,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: actions,
        elevation: 0,
        backgroundColor: colors.surface,
        foregroundColor: colors.onSurface,
      ),
      drawer: drawer,
      body: Container(
        decoration: BoxDecoration(color: theme.scaffoldBackgroundColor),
        child: Padding(
          padding: contentPadding ?? const EdgeInsets.all(16.0),
          child: content,
        ),
      ),
    );
  }
}
