import 'package:flutter/material.dart';
import 'package:shared/utils/failures/failure.dart' show Failure;
import 'package:ui_kit/src/design_system/design_system.dart';

/// A standardized error display component using Material UI
/// with Neumorphic styling error messages
///
/// Provides consistent error presentation across the application
class ErrorDisplay extends StatelessWidget {

  const ErrorDisplay({
    super.key,
    required this.failure,
    this.onRetry,
    this.details,
    this.icon = Icons.error_outline,
  });
  /// The failure to display
  final Failure failure;

  /// Optional retry callback
  final VoidCallback? onRetry;

  /// Optional additional details to display
  final String? details;

  /// Icon to display with the error
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = DesignTokens.colorsFor(theme.brightness);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: DesignEffects.neumorphicInset(
        colors: colors,
        radius: DesignTokens.radiusLg,
        backgroundColor:
            theme.brightness == Brightness.dark
                ? Colors.red[900]!.withValues(alpha: 0.2)
                : Colors.red[50]!,
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.red[600], size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  failure.message,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.red[800],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(details ?? '', style: theme.textTheme.bodyMedium),
              ],
            ),
          ),
          if (onRetry != null) ...[
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.colorScheme.primary,
                foregroundColor: theme.colorScheme.onPrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(DesignTokens.radiusLg),
                ),
              ),
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
