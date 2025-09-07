import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:languist/languist.dart';

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
                        cleaner.fullName,
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
                    _buildInfoCard(
                      theme,
                      l10n.personalInformation,
                      Icons.person,
                      <Widget>[
                        _buildInfoRow(l10n.userfullName, cleaner.fullName),
                        _buildInfoRow(l10n.userEmail, cleaner.email),
                        _buildInfoRow(l10n.userPhone, cleaner.phone),
                        _buildInfoRow(
                          l10n.userJoined,
                          _formatDate(cleaner.joinedAt),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Employment Details
                    _buildInfoCard(theme, 'Employment Details', Icons.work, <
                      Widget
                    >[
                      _buildInfoRow('Status', _getStatusName(cleaner.status)),
                      _buildInfoRow(
                        'Availability',
                        cleaner.isAvailable ? 'Available' : 'Unavailable',
                      ),
                      if (cleaner.hourlyRate != null)
                        _buildInfoRow(
                          'Hourly Rate',
                          '\$${cleaner.hourlyRate!.toStringAsFixed(2)}',
                        ),
                      _buildInfoRow('Total Jobs', cleaner.totalJobs.toString()),
                      _buildRatingRow(cleaner.rating),
                    ]),
                    const SizedBox(height: 16),

                    // Specialties
                    if (cleaner.specialties.isNotEmpty)
                      _buildInfoCard(theme, 'Specialties', Icons.star, <Widget>[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: cleaner.specialties.map((
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
                      ]),
                    if (cleaner.specialties.isNotEmpty)
                      const SizedBox(height: 16),

                    // Address Information
                    if (cleaner.address != null)
                      _buildInfoCard(
                        theme,
                        'Address',
                        Icons.location_on,
                        <Widget>[
                          _buildInfoRow('Street', cleaner.address!.street),
                          if (cleaner.address!.apartment != null)
                            _buildInfoRow(
                              'Apartment',
                              cleaner.address!.apartment!,
                            ),
                          _buildInfoRow('City', cleaner.address!.city),
                          _buildInfoRow('State', cleaner.address!.state),
                          _buildInfoRow('ZIP Code', cleaner.address!.zipCode),
                        ],
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: <Widget>[
                if (cleaner.status != CleanerStatus.suspended)
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _updateCleanerStatus(
                        context,
                        CleanerStatus.suspended,
                      ),
                      icon: const Icon(Icons.block),
                      label: const Text('Suspend'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: theme.colorScheme.error,
                      ),
                    ),
                  ),
                if (cleaner.status != CleanerStatus.suspended)
                  const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _toggleAvailability(context),
                    icon: Icon(
                      cleaner.isAvailable ? Icons.pause : Icons.play_arrow,
                    ),
                    label: Text(
                      cleaner.isAvailable
                          ? 'Make Unavailable'
                          : 'Make Available',
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

  Widget _buildInfoCard(
    ThemeData theme,
    String title,
    IconData icon,
    List<Widget> children,
  ) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(icon, size: 20, color: theme.colorScheme.primary),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(child: Text(value)),
        ],
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
      case CleanerStatus.active:
        return 'Active';
      case CleanerStatus.inactive:
        return 'Inactive';
      case CleanerStatus.suspended:
        return 'Suspended';
      case CleanerStatus.pending:
        return 'Pending';
    }
  }

  Color _getStatusColor(CleanerStatus status, ThemeData theme) {
    switch (status) {
      case CleanerStatus.active:
        return Colors.green;
      case CleanerStatus.inactive:
        return Colors.grey;
      case CleanerStatus.suspended:
        return theme.colorScheme.error;
      case CleanerStatus.pending:
        return Colors.orange;
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

  void _updateCleanerStatus(BuildContext context, CleanerStatus newStatus) {
    StoreProvider.of<AppState>(context, listen: false).dispatch(
      UpdateCleanerStatusAction(cleanerId: cleaner.id, status: newStatus),
    );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Staff status updated to ${_getStatusName(newStatus)}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }

  void _toggleAvailability(BuildContext context) {
    StoreProvider.of<AppState>(context, listen: false).dispatch(
      UpdateCleanerAvailabilityAction(
        cleanerId: cleaner.id,
        isAvailable: !cleaner.isAvailable,
      ),
    );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Staff availability updated'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
