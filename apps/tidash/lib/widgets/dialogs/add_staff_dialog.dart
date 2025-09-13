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
  ProfessionalActivityStatus _selectedStatus =
      ProfessionalActivityStatus.offline;
  final List<PreBookingServiceCategory> _selectedCategories =
      <PreBookingServiceCategory>[];

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
                      const SectionHeader(
                        title: 'Personal Information',
                        icon: Icons.person,
                      ),
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
                      const SectionHeader(
                        title: 'Employment Details',
                        icon: Icons.work,
                      ),
                      const SizedBox(height: 16),

                      Row(
                        children: <Widget>[
                          Expanded(
                            child:
                                DropdownButtonFormField<
                                  ProfessionalActivityStatus
                                >(
                                  initialValue: _selectedStatus,
                                  decoration: const InputDecoration(
                                    labelText: 'Status',
                                    prefixIcon: Icon(Icons.assignment_ind),
                                    border: OutlineInputBorder(),
                                  ),
                                  items: ProfessionalActivityStatus.values.map((
                                    ProfessionalActivityStatus status,
                                  ) {
                                    return DropdownMenuItem<
                                      ProfessionalActivityStatus
                                    >(
                                      value: status,
                                      child: Text(_getStatusName(status)),
                                    );
                                  }).toList(),
                                  onChanged:
                                      (ProfessionalActivityStatus? value) {
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
                      const SectionHeader(
                        title: 'Specialties',
                        icon: Icons.star,
                      ),
                      const SizedBox(height: 16),

                      Text(
                        'Select service categories:',
                        style: theme.textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 8),

                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: PreBookingServiceCategory.values.map((
                          PreBookingServiceCategory category,
                        ) {
                          final bool isSelected = _selectedCategories.contains(
                            category,
                          );
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
                      const SectionHeader(
                        title: 'Address (Optional)',
                        icon: Icons.location_on,
                      ),
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

  String _getStatusName(ProfessionalActivityStatus status) {
    switch (status) {
      case ProfessionalActivityStatus.available:
        return 'Available';
      case ProfessionalActivityStatus.onJob:
        return 'Busy';
      case ProfessionalActivityStatus.offline:
        return 'Offline';
      case ProfessionalActivityStatus.onBreak:
        return 'On Break';
    }
  }

  String _getServiceCategoryName(PreBookingServiceCategory category) {
    return switch (category) {
      PreBookingServiceCategory.cleaning => 'Cleaning',
      PreBookingServiceCategory.standardCleaning => 'Standard Cleaning',
      PreBookingServiceCategory.regularCleaning => 'Regular Cleaning',
      PreBookingServiceCategory.laundry => 'Laundry',
      PreBookingServiceCategory.cooking => 'Cooking',
      PreBookingServiceCategory.babysitting => 'Babysitting',
      PreBookingServiceCategory.petCare => 'Pet Care',
      PreBookingServiceCategory.gardening => 'Gardening',
      PreBookingServiceCategory.maintenance => 'Maintenance',
      PreBookingServiceCategory.organization => 'Organization',
      PreBookingServiceCategory.deepCleaning => 'Deep Cleaning',
      PreBookingServiceCategory.moveInOut => 'Move In-Out',
      PreBookingServiceCategory.postConstruction => 'Post Construction',
      PreBookingServiceCategory.commercial => 'Commercial',
      PreBookingServiceCategory.residential => 'Residential',
      PreBookingServiceCategory.specialized => 'Specialized',
      PreBookingServiceCategory.other => 'Other',
    };
  }

  void _addStaff(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      '${_firstNameController.text.trim()} ${_lastNameController.text.trim()}'
          .trim();

      final ProfessionalProfile professional = ProfessionalProfile(
        id: DateTime.now().millisecondsSinceEpoch.toString(),

        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        hourlyRate: 350,
        defaultRateType: JobRateType.perService,
        email: EmailVO(_emailController.text.trim()),
      );

      // Dispatch action to create professional
      StoreProvider.of<AppState>(
        context,
        listen: false,
      ).dispatch(CreateProfessionalAction(professional: professional));

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
