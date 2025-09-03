// lib/shared/widgets/indicators/error_display.dart

import 'package:fluent_ui/fluent_ui.dart';

/// A standardized widget for displaying errors.
///
/// Shows an error icon, a message, and an optional retry button.
class ErrorDisplay extends StatelessWidget {
  final String errorMessage;
  final VoidCallback? onRetry;

  const ErrorDisplay({
    super.key,
    required this.errorMessage,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final theme = FluentTheme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(FluentIcons.error, size: 48, color: theme.resources.systemFillColorCritical),
          const SizedBox(height: 16),
          Text(
            'An Error Occurred',
            style: theme.typography.subtitle,
          ),
          const SizedBox(height: 8),
          Text(
            errorMessage,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 24),
            FilledButton(
              onPressed: onRetry,
              child: const Text('Retry'),
            ),
          ],
        ],
      ),
    );
  }
}
