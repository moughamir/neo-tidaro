import 'package:flutter/material.dart';
import 'package:ui_kit/src/design_system/design_system.dart';

/// A standardized dialog component using Material UI with Neumorphic styling
///
/// Provides consistent dialog presentation across the app
class GenericDialog extends StatelessWidget {
  /// Dialog title
  final String title;

  /// Main dialog content
  final Widget content;

  /// Primary action button text
  final String primaryButtonText;

  /// Callback when primary button is tapped
  final VoidCallback? onPrimaryButtonPressed;

  /// Optional secondary action button text
  final String? secondaryButtonText;

  /// Callback when secondary button is tapped
  final VoidCallback? onSecondaryButtonPressed;

  /// Optional close button visibility
  final bool showCloseButton;

  const GenericDialog({
    super.key,
    required this.title,
    required this.content,
    required this.primaryButtonText,
    this.onPrimaryButtonPressed,
    this.secondaryButtonText,
    this.onSecondaryButtonPressed,
    this.showCloseButton = true,
  });

  /// Shows a generic dialog with the provided configuration
  static Future<T?> show<T>({
    required BuildContext context,
    required String title,
    required Widget content,
    required String primaryButtonText,
    VoidCallback? onPrimaryButtonPressed,
    String? secondaryButtonText,
    VoidCallback? onSecondaryButtonPressed,
    bool barrierDismissible = true,
  }) {
    return showDialog<T>(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: GenericDialog(
          title: title,
          content: content,
          primaryButtonText: primaryButtonText,
          onPrimaryButtonPressed: onPrimaryButtonPressed,
          secondaryButtonText: secondaryButtonText,
          onSecondaryButtonPressed: onSecondaryButtonPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = DesignTokens.colorsFor(theme.brightness);

    return Container(
      decoration: DesignEffects.neumorphicElevated(
        colors: colors,
        radius: DesignTokens.radius2xl,
        backgroundColor: theme.scaffoldBackgroundColor,
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Flexible(child: SingleChildScrollView(child: content)),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (secondaryButtonText != null) ...[
                TextButton(
                  onPressed:
                      onSecondaryButtonPressed ??
                      () => Navigator.of(context).pop(),
                  child: Text(secondaryButtonText!),
                ),
                const SizedBox(width: 16),
              ],
              ElevatedButton(
                onPressed:
                    onPrimaryButtonPressed ?? () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                  ),
                ),
                child: Text(primaryButtonText),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
