import 'package:flutter/material.dart';

import 'package:shared/shared.dart';
import 'package:ui_kit/ui_kit.dart';

/// Card component for displaying staff/cleaner information
class StaffCard extends StatelessWidget {
  const StaffCard({
    super.key,
    required this.cleaner,
    required this.onTap,
    required this.onStatusChanged,
  });

  final Cleaner cleaner;
  final VoidCallback onTap;
  final Function(CleanerStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: theme.colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile picture and status
              Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: theme.colorScheme.primary.withValues(
                      alpha: 0.1,
                    ),
                    backgroundImage: cleaner.profileImageUrl != null
                        ? NetworkImage(cleaner.profileImageUrl!)
                        : null,
                    child: cleaner.profileImageUrl == null
                        ? Icon(Icons.person, color: theme.colorScheme.primary)
                        : null,
                  ),
                  const Spacer(),
                  _buildStatusChip(context, cleaner.status),
                ],
              ),
              const SizedBox(height: 12),

              // Name and phone
              Text(
                cleaner.name,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),

              Text(
                cleaner.phone,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
              const SizedBox(height: 8),

              // Rating and experience
              Row(
                children: [
                  Icon(Icons.star, size: 16, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    cleaner.rating?.toStringAsFixed(1) ?? 'N/A',
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${cleaner.totalBookings ?? 0} jobs',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Specializations
              if (cleaner.serviceCategories.isNotEmpty) ...[
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: cleaner.serviceCategories.take(2).map((spec) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.secondary.withValues(
                          alpha: 0.1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        _getSpecializationName(spec as ServiceCategory),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.secondary,
                          fontSize: 10,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
              ],

              // Action buttons for status changes
              if (_shouldShowActionButtons(cleaner.status)) ...[
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: _buildActionButton(context, cleaner.status),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(BuildContext context, CleanerStatus status) {
    final theme = Theme.of(context);
    final statusInfo = _getStatusInfo(context, status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: statusInfo.color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: statusInfo.color.withValues(alpha: 0.3)),
      ),
      child: Text(
        statusInfo.label,
        style: theme.textTheme.bodySmall?.copyWith(
          color: statusInfo.color,
          fontWeight: FontWeight.w600,
          fontSize: 10,
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context, CleanerStatus status) {
    switch (status) {
      case CleanerStatus.available:
        return OutlinedButton(
          onPressed: () => onStatusChanged(CleanerStatus.onJob),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey,
            side: const BorderSide(color: Colors.grey),
          ),
          child: const Text('Set On Job'),
        );
      case CleanerStatus.onJob:
        return ElevatedButton(
          onPressed: () => onStatusChanged(CleanerStatus.available),
          child: const Text('Set Available'),
        );
      case CleanerStatus.offline:
        return ElevatedButton(
          onPressed: () => onStatusChanged(CleanerStatus.available),
          child: const Text('Go Online'),
        );
      case CleanerStatus.onBreak:
        return ElevatedButton(
          onPressed: () => onStatusChanged(CleanerStatus.available),
          child: const Text('End Break'),
        );
    }
  }

  ({String label, Color color}) _getStatusInfo(BuildContext context, CleanerStatus status) {
    switch (status) {
      case CleanerStatus.available:
        return (label: AppLocalizations.of(context).available, color: Colors.green);
      case CleanerStatus.onJob:
        return (label: AppLocalizations.of(context).busy, color: Colors.orange);
      case CleanerStatus.offline:
        return (label: AppLocalizations.of(context).offline, color: Colors.grey);
      case CleanerStatus.onBreak:
        return (label: AppLocalizations.of(context).away, color: Colors.blue);
    }
  }

  String _getSpecializationName(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.regularCleaning:
        return 'Regular';
      case ServiceCategory.standardCleaning:
        return 'Standard';
      case ServiceCategory.deepCleaning:
        return 'Deep Clean';
      case ServiceCategory.moveInOut:
        return 'Move In/Out';
      case ServiceCategory.postConstruction:
        return 'Post Construction';
      case ServiceCategory.commercial:
        return 'Commercial';
      case ServiceCategory.residential:
        return 'Residential';
      case ServiceCategory.specialized:
        return 'Specialized';
    }
  }

  bool _shouldShowActionButtons(CleanerStatus status) {
    return status == CleanerStatus.available ||
        status == CleanerStatus.onJob ||
        status == CleanerStatus.offline ||
        status == CleanerStatus.onBreak;
  }
}
