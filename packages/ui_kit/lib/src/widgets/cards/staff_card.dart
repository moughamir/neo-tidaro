import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:languist/languist.dart';
import 'package:ui_kit/src/widgets/cards/profile_card.dart';

/// Card component for displaying staff/professional information
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
  final Function(ProfessionalKycStatus) onStatusChanged;

  @override
  Widget build(BuildContext context) {
    return ProfileCard<ProfessionalProfile, ProfessionalKycStatus>(
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

  Widget _buildActionButton(
    BuildContext context,
    ProfessionalKycStatus status,
  ) {
    switch (status) {
      case ProfessionalKycStatus.active:
        return OutlinedButton(
          onPressed: () => onStatusChanged(ProfessionalKycStatus.inactive),
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.grey,
            side: const BorderSide(color: Colors.grey),
          ),
          child: const Text('Set Inactive'),
        );
      case ProfessionalKycStatus.inactive:
        return ElevatedButton(
          onPressed: () => onStatusChanged(ProfessionalKycStatus.active),
          child: const Text('Set Active'),
        );
      case ProfessionalKycStatus.suspended:
        return ElevatedButton(
          onPressed: () => onStatusChanged(ProfessionalKycStatus.underReview),
          child: const Text('Request Review'),
        );
      default:
        return ElevatedButton(
          onPressed: () => onStatusChanged(ProfessionalKycStatus.active),
          child: const Text('Activate'),
        );
    }
  }

  ({String label, Color color}) _getStatusInfo(
    BuildContext context,
    ProfessionalKycStatus status,
  ) {
    switch (status) {
      case ProfessionalKycStatus.active:
        return (label: 'l10n.available', color: Colors.green);
      case ProfessionalKycStatus.pending:
        return (label: 'l10n.verificationPending', color: Colors.orange);
      case ProfessionalKycStatus.inactive:
        return (label: 'l10n.offline', color: Colors.grey);
      case ProfessionalKycStatus.suspended:
        return (label: 'l10n.dishWashing', color: Colors.red);
      case ProfessionalKycStatus.rejected:
        return (label: 'Rejected', color: Colors.red);
      case ProfessionalKycStatus.underReview:
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

  bool _shouldShowActionButtons(ProfessionalKycStatus status) {
    return status == ProfessionalKycStatus.active ||
        status == ProfessionalKycStatus.inactive ||
        status == ProfessionalKycStatus.suspended ||
        status == ProfessionalKycStatus.pending ||
        status == ProfessionalKycStatus.underReview;
  }
}
