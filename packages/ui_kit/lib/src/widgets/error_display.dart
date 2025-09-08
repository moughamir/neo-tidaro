import 'package:flutter/material.dart';
import 'package:ui_kit/src/theme/neumorphic_theme.dart';

import 'package:shared/utils/failures/failure.dart' show Failure;

/// A standardized error display component using Material UI
/// with Neumorphic styling error messages
///
/// Provides consistent error presentation across the application
class ErrorDisplay extends StatelessWidget {
  /// The failure to display
  final Failure failure;

  /// Optional retry callback
  final VoidCallback? onRetry;

  /// Optional additional details to display
  final String? details;

  /// Icon to display with the error
  final IconData icon;

  const ErrorDisplay({
    super.key,
    required this.failure,
    this.onRetry,
    this.details,
    this.icon = Icons.error_outline,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: NeumorphicTheme.neumorphicInsetBoxDecoration(
        isDark: isDark,
        color: isDark
            ? Colors.red[900]!.withValues(alpha: 0.2)
            : Colors.red[50]!,
        radius: 12.0,
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
                  borderRadius: BorderRadius.circular(
                    NeumorphicTheme.borderRadius,
                  ),
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
