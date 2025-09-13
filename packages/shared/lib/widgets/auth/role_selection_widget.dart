import 'package:domain/domain.dart';
import 'package:flutter/material.dart';

/// A widget for selecting user roles during registration
class RoleSelectionWidget extends StatefulWidget {
  const RoleSelectionWidget({
    super.key,
    required this.onRoleSelected,
    this.initialRole = PlatformUserRole.clientConsumer,
    this.enabled = true,
  });

  final ValueChanged<PlatformUserRole> onRoleSelected;
  final PlatformUserRole initialRole;
  final bool enabled;

  @override
  State<RoleSelectionWidget> createState() => _RoleSelectionWidgetState();
}

class _RoleSelectionWidgetState extends State<RoleSelectionWidget> {
  late PlatformUserRole _selectedRole;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  void _selectRole(PlatformUserRole role) {
    if (!widget.enabled) return;
    
    setState(() {
      _selectedRole = role;
    });
    widget.onRoleSelected(role);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.selectUserRole,
          style: theme.textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Text(
          l10n.selectUserRoleDescription,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 16),
        
        // Client Consumer Role
        _RoleOption(
          role: PlatformUserRole.clientConsumer,
          title: l10n.roleClientConsumer,
          subtitle: l10n.roleClientConsumerDescription,
          icon: Icons.person,
          isSelected: _selectedRole == PlatformUserRole.clientConsumer,
          enabled: widget.enabled,
          onTap: () => _selectRole(PlatformUserRole.clientConsumer),
        ),
        
        const SizedBox(height: 12),
        
        // Client Professional Role
        _RoleOption(
          role: PlatformUserRole.clientProfessional,
          title: l10n.roleClientProfessional,
          subtitle: l10n.roleClientProfessionalDescription,
          icon: Icons.work,
          isSelected: _selectedRole == PlatformUserRole.clientProfessional,
          enabled: widget.enabled,
          onTap: () => _selectRole(PlatformUserRole.clientProfessional),
        ),
      ],
    );
  }
}

class _RoleOption extends StatelessWidget {
  const _RoleOption({
    required this.role,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.enabled,
    required this.onTap,
  });

  final PlatformUserRole role;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return InkWell(
      onTap: enabled ? onTap : null,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outline.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          color: isSelected
              ? theme.colorScheme.primaryContainer.withOpacity(0.3)
              : theme.colorScheme.surface,
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? theme.colorScheme.primary
                    : theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? theme.colorScheme.onPrimary
                    : theme.colorScheme.onSurfaceVariant,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}