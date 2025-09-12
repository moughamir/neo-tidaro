import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/localization/app_localizations.dart';
import 'package:ui_kit/src/widgets/cards/profile_card.dart';

/// Card component for displaying staff/cleaner information
/// Now implemented using the generic ProfileCard component
class StaffCard extends StatelessWidget {
  const StaffCard({
    super.key,
    required this.professional,
    required this.onTap,
    required this.onStatusChanged,
  });

  final ProfessionalProfile professional;
  final VoidCallback onTap;
  final Function(ProfessionalStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return ProfileCard<ProfessionalProfile, ProfessionalStatus>(
      profile: professional,
      name: professional.fullName ?? 'Professional',
      status: professional.status,
      profileImageUrl: professional.avatarUrl,
      phone: professional.phone?.value,
      email: professional.email.value,
      rating: professional.rating,
      totalItems: professional.completedJobs,
      itemsLabel: 'jobs',
      categories: professional.categories.map((cat) => cat.toString()).toList(),
      categoryLabelBuilder: _getSpecializationName,
      onTap: onTap,
      onStatusChanged: onStatusChanged,
      getStatusInfo: _getStatusInfo,
      shouldShowActionButtons: _shouldShowActionButtons,
      buildActionButton: _buildActionButton,
    );
  }

  Widget _buildActionButton(BuildContext context, ProfessionalStatus status) {
    switch (status) {
      case ProfessionalStatus.active:
        return OutlinedButton(
          onPressed: () => onStatusChanged(ProfessionalStatus.inactive),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey,
            side: const BorderSide(color: Colors.grey),
          ),
          child: const Text('Set Inactive'),
        );
      case ProfessionalStatus.inactive:
        return ElevatedButton(
          onPressed: () => onStatusChanged(ProfessionalStatus.active),
          child: const Text('Set Active'),
        );
      case ProfessionalStatus.suspended:
        return ElevatedButton(
          onPressed: () => onStatusChanged(ProfessionalStatus.underReview),
          child: const Text('Request Review'),
        );
      default:
        return ElevatedButton(
          onPressed: () => onStatusChanged(ProfessionalStatus.active),
          child: const Text('Activate'),
        );
    }
  }

  ({String label, Color color}) _getStatusInfo(
    BuildContext context,
    ProfessionalStatus status,
  ) {
    switch (status) {
      case ProfessionalStatus.active:
        return (
          label: AppLocalizations.of(context).available,
          color: Colors.green,
        );
      case ProfessionalStatus.pending:
        return (label: 'Pending', color: Colors.orange);
      case ProfessionalStatus.inactive:
        return (
          label: AppLocalizations.of(context).offline,
          color: Colors.grey,
        );
      case ProfessionalStatus.suspended:
        return (label: 'Suspended', color: Colors.red);
      case ProfessionalStatus.rejected:
        return (label: 'Rejected', color: Colors.red);
      case ProfessionalStatus.underReview:
        return (label: 'Under Review', color: Colors.blue);
    }
  }

  String _getSpecializationName(String category) {
    // Extract enum name from the toString() value
    final parts = category.split('.');
    if (parts.length > 1) {
      final enumValue = parts[1];
      // Convert from camelCase to Title Case with spaces
      final result = enumValue.replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'),
        (match) => '${match.group(1)} ${match.group(2)}',
      );
      return result[0].toUpperCase() + result.substring(1);
    }
    return category;
  }

  bool _shouldShowActionButtons(ProfessionalStatus status) {
    return status == ProfessionalStatus.active ||
        status == ProfessionalStatus.inactive ||
        status == ProfessionalStatus.suspended ||
        status == ProfessionalStatus.pending ||
        status == ProfessionalStatus.underReview;
  }
}
