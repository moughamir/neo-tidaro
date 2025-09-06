import 'package:flutter/material.dart';
import 'package:languist/languist.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({
    super.key,
    this.onRefresh,
    this.isRefreshing = false,
    this.lastUpdated,
  });

  final VoidCallback? onRefresh;
  final bool isRefreshing;
  final DateTime? lastUpdated;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  l10n.dashboard,
                  style: theme.textTheme.headlineLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _getGreeting(l10n),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
                if (lastUpdated != null) ...<Widget>[
                  const SizedBox(height: 4),
                  Text(
                    'Last updated: ${_formatLastUpdated(lastUpdated!)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (onRefresh != null)
            IconButton.filled(
              onPressed: isRefreshing ? null : onRefresh,
              icon: isRefreshing
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          theme.colorScheme.onPrimary,
                        ),
                      ),
                    )
                  : const Icon(Icons.refresh),
              tooltip: l10n.refresh,
            ),
        ],
      ),
    );
  }

  String _getGreeting(IntlLocalizations l10n) {
    final int hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning! Here\'s your overview.';
    } else if (hour < 17) {
      return 'Good afternoon! Here\'s your overview.';
    } else {
      return 'Good evening! Here\'s your overview.';
    }
  }

  String _formatLastUpdated(DateTime dateTime) {
    final DateTime now = DateTime.now();
    final Duration difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours} hours ago';
    } else {
      return '${difference.inDays} days ago';
    }
  }
}
