import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

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
                cleaner.fullName,
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
                    cleaner.rating.toStringAsFixed(1),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${cleaner.totalJobs} jobs',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Specializations
              if (cleaner.specialties.isNotEmpty) ...[
                Wrap(
                  spacing: 4,
                  runSpacing: 4,
                  children: cleaner.specialties.take(2).map((spec) {
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
                        _getSpecializationName(spec),
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
    final statusInfo = _getStatusInfo(status);

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
      case CleanerStatus.active:
        return OutlinedButton(
          onPressed: () => onStatusChanged(CleanerStatus.inactive),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey,
            side: const BorderSide(color: Colors.grey),
          ),
          child: const Text('Set Inactive'),
        );
      case CleanerStatus.inactive:
        return ElevatedButton(
          onPressed: () => onStatusChanged(CleanerStatus.active),
          child: const Text('Set Active'),
        );
      case CleanerStatus.pending:
        return ElevatedButton(
          onPressed: () => onStatusChanged(CleanerStatus.active),
          child: const Text('Approve'),
        );
      case CleanerStatus.suspended:
        return ElevatedButton(
          onPressed: () => onStatusChanged(CleanerStatus.active),
          child: const Text('Reactivate'),
        );
    }
  }

  ({String label, Color color}) _getStatusInfo(CleanerStatus status) {
    switch (status) {
      case CleanerStatus.active:
        return (label: 'Active', color: Colors.green);
      case CleanerStatus.inactive:
        return (label: 'Inactive', color: Colors.grey);
      case CleanerStatus.pending:
        return (label: 'Pending', color: Colors.orange);
      case CleanerStatus.suspended:
        return (label: 'Suspended', color: Colors.red);
    }
  }

  String _getSpecializationName(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.regularCleaning:
        return 'Regular';
      case ServiceCategory.deepCleaning:
        return 'Deep Clean';
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

  bool _shouldShowActionButtons(CleanerStatus status) {
    return status == CleanerStatus.active ||
        status == CleanerStatus.inactive ||
        status == CleanerStatus.pending ||
        status == CleanerStatus.suspended;
  }
}
