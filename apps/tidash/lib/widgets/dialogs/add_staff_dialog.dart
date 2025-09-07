import 'package:flutter/material.dart';
import 'package:shared/shared.dart';
import 'package:languist/languist.dart';
import 'package:ui_kit/ui_kit.dart';

/// Dialog for adding a new staff member
class AddStaffDialog extends StatefulWidget {
  const AddStaffDialog({super.key});

  @override
  State<AddStaffDialog> createState() => _AddStaffDialogState();
}

class _AddStaffDialogState extends State<AddStaffDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  CleanerStatus _selectedStatus = CleanerStatus.offline;
  final List<ServiceCategory> _selectedCategories = <ServiceCategory>[];

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    super.dispose();
  }

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
                Icon(
                  Icons.person_add,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Add Staff Member',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Form
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Personal Information Section
                      const SectionHeader(title: 'Personal Information', icon: Icons.person),
                      const SizedBox(height: 16),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _firstNameController,
                              decoration: InputDecoration(
                                labelText: l10n.firstName,
                                prefixIcon: const Icon(Icons.person_outline),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.fieldRequired;
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _lastNameController,
                              decoration: InputDecoration(
                                labelText: l10n.lastName,
                                prefixIcon: const Icon(Icons.person_outline),
                                border: const OutlineInputBorder(),
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return l10n.fieldRequired;
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: l10n.email,
                          prefixIcon: const Icon(Icons.email_outlined),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return l10n.fieldRequired;
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return l10n.invalidEmail;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _phoneController,
                        decoration: InputDecoration(
                          labelText: l10n.phone,
                          prefixIcon: const Icon(Icons.phone_outlined),
                          border: const OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return l10n.fieldRequired;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Employment Information Section
                      const SectionHeader(title: 'Employment Details', icon: Icons.work),
                      const SizedBox(height: 16),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child: DropdownButtonFormField<CleanerStatus>(
                              initialValue: _selectedStatus,
                              decoration: const InputDecoration(
                                labelText: 'Status',
                                prefixIcon: Icon(Icons.assignment_ind),
                                border: OutlineInputBorder(),
                              ),
                              items: CleanerStatus.values.map((CleanerStatus status) {
                                return DropdownMenuItem<CleanerStatus>(
                                  value: status,
                                  child: Text(_getStatusName(status)),
                                );
                              }).toList(),
                              onChanged: (CleanerStatus? value) {
                                if (value != null) {
                                  setState(() {
                                    _selectedStatus = value;
                                  });
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Specialties Section
                      const SectionHeader(title: 'Specialties', icon: Icons.star),
                      const SizedBox(height: 16),

                      Text(
                        'Select service categories:',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: ServiceCategory.values.map((ServiceCategory category) {
                          final bool isSelected = _selectedCategories.contains(category);
                          return FilterChip(
                            label: Text(_getServiceCategoryName(category)),
                            selected: isSelected,
                            onSelected: (bool selected) {
                              setState(() {
                                if (selected) {
                                  _selectedCategories.add(category);
                                } else {
                                  _selectedCategories.remove(category);
                                }
                              });
                            },
                            backgroundColor: theme.colorScheme.surface,
                            selectedColor: theme.colorScheme.primaryContainer,
                            checkmarkColor: theme.colorScheme.primary,
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 24),

                      // Address Section
                      const SectionHeader(title: 'Address (Optional)', icon: Icons.location_on),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _streetController,
                        decoration: const InputDecoration(
                          labelText: 'Street Address',
                          prefixIcon: Icon(Icons.home_outlined),
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: TextFormField(
                              controller: _cityController,
                              decoration: const InputDecoration(
                                labelText: 'City',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _stateController,
                              decoration: const InputDecoration(
                                labelText: 'State',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _zipCodeController,
                              decoration: const InputDecoration(
                                labelText: 'ZIP',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Action Buttons
            Row(
              children: <Widget>[
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(l10n.cancel),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _addStaff(context),
                    child: Text(l10n.add),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  

  String _getStatusName(CleanerStatus status) {
    switch (status) {
      case CleanerStatus.available:
        return 'Available';
      case CleanerStatus.busy:
        return 'Busy';
      case CleanerStatus.offline:
        return 'Offline';
      case CleanerStatus.onBreak:
        return 'On Break';
    }
  }

  String _getServiceCategoryName(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.standardCleaning:
        return 'Standard Cleaning';
      case ServiceCategory.deepCleaning:
        return 'Deep Cleaning';
      case ServiceCategory.moveInOut:
        return 'Move In/Out';
      case ServiceCategory.postConstruction:
        return 'Post Construction';
      case ServiceCategory.commercial:
        return 'Commercial';
      case ServiceCategory.residential:
        return 'Residential';
    }
  }

  void _addStaff(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final String name = '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'.trim();

      final Cleaner cleaner = Cleaner(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: name,
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        status: _selectedStatus,
        serviceCategories: _selectedCategories,
        joinedDate: DateTime.now(),
      );

      // Dispatch action to create cleaner
      StoreProvider.of<AppState>(
        context,
        listen: false,
      ).dispatch(CreateCleanerAction(cleaner));

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Staff member added successfully'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }
}
