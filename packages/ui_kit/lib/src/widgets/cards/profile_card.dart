import 'package:flutter/material.dart';
import 'package:ui_kit/src/widgets/card.dart';

/// A generic card component for displaying profile information
/// Can be used for any type of person profile, staff, user, etc.
class ProfileCard<T, S> extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.profile,
    required this.name,
    required this.status,
    this.profileImageUrl,
    this.phone,
    this.email,
    this.rating,
    this.totalItems,
    this.itemsLabel,
    this.categories,
    this.categoryLabelBuilder,
    this.onTap,
    this.onStatusChanged,
    this.getStatusInfo,
    this.shouldShowActionButtons,
    this.buildActionButton,
  });

  /// The profile object
  final T profile;

  /// The name of the person
  final String name;

  /// The status of the person (enum or string)
  final S status;

  /// Optional profile image URL
  final String? profileImageUrl;

  /// Optional phone number
  final String? phone;

  /// Optional email address
  final String? email;

  /// Optional rating (e.g., 4.5)
  final double? rating;

  /// Optional total items count (e.g., total jobs, orders, etc.)
  final int? totalItems;

  /// Optional label for the items (e.g., "jobs", "orders", etc.)
  final String? itemsLabel;

  /// Optional list of categories/specializations
  final List<String>? categories;

  /// Optional builder for category labels
  final String Function(String category)? categoryLabelBuilder;

  /// Callback for when the card is tapped
  final VoidCallback? onTap;

  /// Callback for when the status is changed
  final Function(S)? onStatusChanged;

  /// Function to get status label and color
  final ({String label, Color color})? Function(BuildContext context, S status)?
  getStatusInfo;

  /// Function to determine if action buttons should be shown
  final bool Function(S status)? shouldShowActionButtons;

  /// Function to build custom action button
  final Widget Function(BuildContext context, S status)? buildActionButton;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return KuiCard(
      elevation: 0,
      onTap: onTap,
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
                  backgroundImage: profileImageUrl != null
                      ? NetworkImage(profileImageUrl!)
                      : null,
                  child: profileImageUrl == null
                      ? Icon(Icons.person, color: theme.colorScheme.primary)
                      : null,
                ),
                const Spacer(),
                if (getStatusInfo != null) _buildStatusChip(context, status),
              ],
            ),
            const SizedBox(height: 12),

            // Name and contact info
            Text(
              name,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),

            if (phone != null) ...[
              Text(
                phone!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],

            if (email != null && phone == null) ...[
              Text(
                email!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                ),
              ),
            ],

            const SizedBox(height: 8),

            // Rating and total items
            if (rating != null || totalItems != null) ...[
              Row(
                children: [
                  if (rating != null) ...[
                    Icon(Icons.star, size: 16, color: Colors.amber),
                    const SizedBox(width: 4),
                    Text(
                      rating!.toStringAsFixed(1),
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                  const Spacer(),
                  if (totalItems != null) ...[
                    Text(
                      '$totalItems ${itemsLabel ?? ''}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.7,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 8),
            ],

            // Categories/Specializations
            if (categories != null && categories!.isNotEmpty) ...[
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: categories!.take(3).map((category) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      categoryLabelBuilder?.call(category) ?? category,
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
            if (shouldShowActionButtons?.call(status) == true &&
                buildActionButton != null) ...[
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: buildActionButton!(context, status),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // TODO(refactor): Extract to a shared widget/helper.
  Widget _buildStatusChip(BuildContext context, S status) {
    final theme = Theme.of(context);
    final statusInfo =
        getStatusInfo?.call(context, status) ??
        (label: status.toString(), color: Colors.grey);

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
}
