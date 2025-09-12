import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:languist/languist.dart';
import 'package:ui_kit/ui_kit.dart' as ui;
import 'package:domain/domain.dart';
import 'package:domain/mappers/professional_status_mapper.dart';

/// Dialog for viewing staff member details
class StaffDetailsDialog extends StatelessWidget {
  const StaffDetailsDialog({super.key, required this.professional});

  final ProfessionalProfile professional;

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
            Row(children: createProfile(theme, context)),
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
                          value: professional.fullName!,
                        ),
                        ui.InfoRow(
                          label: l10n.userEmail,
                          value: professional.email.toString(),
                        ),
                        ui.InfoRow(
                          label: l10n.userPhone,
                          value: professional.phone.toString(),
                        ),

                        if (professional.createdAt != null)
                          ui.InfoRow(
                            label: l10n.userJoined,
                            value: _formatDate(professional.createdAt!),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Employment Details
                    ui.InfoCard(
                      title: 'Employment Details',
                      icon: Icons.work,
                      children: <Widget>[
                        const ui.InfoRow(label: 'Status', value: 'TBD'),
                        ui.InfoRow(
                          label: 'Total Jobs',
                          value: (professional.completedJobs).toString(),
                        ),
                        _buildRatingRow(professional.rating),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Specialties
                    if (professional.categories.isNotEmpty)
                      ui.InfoCard(
                        title: 'Specialties',
                        icon: Icons.star,
                        children: <Widget>[
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: professional.categories.map((
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
                    if (professional.categories.isNotEmpty)
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
                      // ignore: lines_longer_than_80_chars, unrelated_type_equality_checks
                      professional.status !=
                              ProfessionalActivityStatus.available
                          ? Icons.play_arrow
                          : Icons.pause,
                    ),
                    label: Text(
                      // ignore: unrelated_type_equality_checks
                      professional.status ==
                              ProfessionalActivityStatus.available
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

  List<Widget> createProfile(ThemeData theme, BuildContext context) {
    return <Widget>[
      CircleAvatar(
        radius: 24,
        backgroundColor: theme.colorScheme.primaryContainer,
        child: professional.avatarUrl != null
            ? ClipOval(
                child: Image.network(
                  professional.avatarUrl!,
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
            : Icon(Icons.person, size: 28, color: theme.colorScheme.primary),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              professional.businessName ?? professional.fullName!,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              _getStatusName(professional as ProfessionalActivityStatus),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: _getStatusColor(
                  professional.status as ProfessionalActivityStatus,
                  theme,
                ),
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
    ];
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

  String _getStatusName(ProfessionalActivityStatus status) {
    switch (status) {
      case ProfessionalActivityStatus.available:
        return 'Available';
      case ProfessionalActivityStatus.onJob:
        return 'On Job';
      case ProfessionalActivityStatus.offline:
        return 'Offline';
      case ProfessionalActivityStatus.onBreak:
        return 'On Break';
    }
  }

  Color _getStatusColor(ProfessionalActivityStatus status, ThemeData theme) {
    switch (status) {
      case ProfessionalActivityStatus.available:
        return Colors.green;
      case ProfessionalActivityStatus.onJob:
        return Colors.orange;
      case ProfessionalActivityStatus.offline:
        return Colors.grey;
      case ProfessionalActivityStatus.onBreak:
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
      case ServiceCategory.standardCleaning:
        return 'Standard Cleaning';
      case ServiceCategory.residential:
        return 'Residential';
      case ServiceCategory.cleaning:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.laundry:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.cooking:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.babysitting:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.petCare:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.gardening:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.maintenance:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.organization:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.other:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  void _toggleAvailability(BuildContext context) {
    // Determine the next activity status
    final ProfessionalActivityStatus currentActivityStatus = 
        ProfessionalStatusMapper.toActivityStatus(professional.status);
        
    final ProfessionalActivityStatus nextActivityStatus =
        currentActivityStatus == ProfessionalActivityStatus.available
        ? ProfessionalActivityStatus.offline
        : currentActivityStatus == ProfessionalActivityStatus.onJob
        ? ProfessionalActivityStatus.onBreak
        : ProfessionalActivityStatus.available;
    
    // Map to the appropriate ProfessionalStatus for the Redux action
    final ProfessionalStatus nextStatus = 
        ProfessionalStatusMapper.fromActivityStatus(nextActivityStatus);

    StoreProvider.of<AppState>(context, listen: false).dispatch(
      UpdateProfessionalStatusAction(
        professionalId: professional.id,
        status: nextStatus,
      ),
    );

    Navigator.of(context).pop();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Staff status updated to ${_getStatusName(nextActivityStatus)}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
