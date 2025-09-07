import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:languist/languist.dart';
import 'package:ui_kit/ui_kit.dart' as ui;

/// Dialog for viewing staff member details
class StaffDetailsDialog extends StatelessWidget {
  const StaffDetailsDialog({super.key, required this.cleaner});

  final Cleaner cleaner;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final IntlLocalizations l10n = Languist.of(context);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        constraints: const BoxConstraints(maxWidth: 600, maxHeight: 700),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Header
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 24,
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: cleaner.profileImageUrl != null
                      ? ClipOval(
                          child: Image.network(
                            cleaner.profileImageUrl!,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder:
                                (
                                  BuildContext context,
                                  Object error,
                                  StackTrace? stackTrace,
                                ) => Icon(
                                  Icons.person,
                                  size: 28,
                                  color: theme.colorScheme.primary,
                                ),
                          ),
                        )
                      : Icon(
                          Icons.person,
                          size: 28,
                          color: theme.colorScheme.primary,
                        ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        cleaner.name,
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _getStatusName(cleaner.status),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: _getStatusColor(cleaner.status, theme),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    ui.InfoCard(
                      title: l10n.personalInformation,
                      icon: Icons.person,
                      children: <Widget>[
                        ui.InfoRow(
                          label: l10n.userfullName,
                          value: cleaner.name,
                        ),
                        ui.InfoRow(label: l10n.userEmail, value: cleaner.email),
                        ui.InfoRow(label: l10n.userPhone, value: cleaner.phone),
                        if (cleaner.joinedDate != null)
                          ui.InfoRow(
                            label: l10n.userJoined,
                            value: _formatDate(cleaner.joinedDate!),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Employment Details
                    ui.InfoCard(
                      title: 'Employment Details',
                      icon: Icons.work,
                      children: <Widget>[
                        ui.InfoRow(
                          label: 'Status',
                          value: _getStatusName(cleaner.status),
                        ),
                        ui.InfoRow(
                          label: 'Total Jobs',
                          value: (cleaner.totalBookings ?? 0).toString(),
                        ),
                        if (cleaner.rating != null)
                          _buildRatingRow(cleaner.rating!),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Specialties
                    if (cleaner.serviceCategories.isNotEmpty)
                      ui.InfoCard(
                        title: 'Specialties',
                        icon: Icons.star,
                        children: <Widget>[
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: cleaner.serviceCategories.map((
                              ServiceCategory category,
                            ) {
                              return Chip(
                                label: Text(_getServiceCategoryName(category)),
                                backgroundColor: theme
                                    .colorScheme
                                    .primaryContainer
                                    .withValues(alpha: 0.3),
                                labelStyle: TextStyle(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    if (cleaner.serviceCategories.isNotEmpty)
                      const SizedBox(height: 16),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: <Widget>[
                // Toggle status button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _toggleAvailability(context),
                    icon: Icon(
                      cleaner.status == CleanerStatus.available
                          ? Icons.pause
                          : Icons.play_arrow,
                    ),
                    label: Text(
                      cleaner.status == CleanerStatus.available
                          ? l10n.makeUnavailableButtonLabel
                          : l10n.makeAvailableButtonLabel,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingRow(double rating) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          const SizedBox(
            width: 120,
            child: Text(
              'Rating:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Row(
            children: List<Widget>.generate(5, (int index) {
              return Icon(
                index < rating.floor() ? Icons.star : Icons.star_border,
                color: Colors.amber,
                size: 20,
              );
            }),
          ),
          const SizedBox(width: 8),
          Text('(${rating.toStringAsFixed(1)}/5.0)'),
        ],
      ),
    );
  }

  String _getStatusName(CleanerStatus status) {
    switch (status) {
      case CleanerStatus.available:
        return 'Available';
      case CleanerStatus.onJob:
        return 'On Job';
      case CleanerStatus.offline:
        return 'Offline';
      case CleanerStatus.onBreak:
        return 'On Break';
    }
  }

  Color _getStatusColor(CleanerStatus status, ThemeData theme) {
    switch (status) {
      case CleanerStatus.available:
        return Colors.green;
      case CleanerStatus.onJob:
        return Colors.orange;
      case CleanerStatus.offline:
        return Colors.grey;
      case CleanerStatus.onBreak:
        return theme.colorScheme.tertiary;
    }
  }

  String _getServiceCategoryName(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.regularCleaning:
        return 'Regular Cleaning';
      case ServiceCategory.deepCleaning:
        return 'Deep Cleaning';
      case ServiceCategory.moveInOut:
        return 'Move In/Out';
      case ServiceCategory.postConstruction:
        return 'Post Construction';
      case ServiceCategory.commercial:
        return 'Commercial';
      case ServiceCategory.specialized:
        return 'Specialized';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _toggleAvailability(BuildContext context) {
    final nextStatus = cleaner.status == CleanerStatus.available
        ? CleanerStatus.offline
        : CleanerStatus.available;

    StoreProvider.of<AppState>(context, listen: false).dispatch(
      UpdateCleanerStatusAction(cleanerId: cleaner.id, status: nextStatus),
    );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Staff status updated to ${_getStatusName(nextStatus)}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
