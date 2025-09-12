import 'package:flutter/material.dart';
import 'package:shared/shared.dart' hide TimeOfDay;
import 'package:languist/languist.dart';
import 'package:ui_kit/ui_kit.dart' hide TimeOfDay;

/// Dialog for creating a new booking
class CreateBookingDialog extends StatefulWidget {
  const CreateBookingDialog({super.key});

  @override
  State<CreateBookingDialog> createState() => _CreateBookingDialogState();
}

class _CreateBookingDialogState extends State<CreateBookingDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _customerNameController = TextEditingController();
  final TextEditingController _customerEmailController =
      TextEditingController();
  final TextEditingController _customerPhoneController =
      TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _zipCodeController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  ServiceCategory _selectedService = ServiceCategory.standardCleaning;
  double _estimatedPrice = 120.0;

  @override
  void dispose() {
    _customerNameController.dispose();
    _customerEmailController.dispose();
    _customerPhoneController.dispose();
    _streetController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _notesController.dispose();
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
                  Icons.event_note,
                  color: theme.colorScheme.primary,
                  size: 28,
                ),
                const SizedBox(width: 12),
                Text(
                  'Create Booking',
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
                      // Customer Information Section
                      const SectionHeader(
                        title: 'Customer Information',
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _customerNameController,
                        decoration: InputDecoration(
                          labelText: l10n.name,
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
                      const SizedBox(height: 16),

                      TextFormField(
                        controller: _customerEmailController,
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
                        controller: _customerPhoneController,
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

                      // Service Information Section
                      const SectionHeader(
                        title: 'Service Details',
                        icon: Icons.cleaning_services,
                      ),
                      const SizedBox(height: 16),

                      DropdownButtonFormField<ServiceCategory>(
                        initialValue: _selectedService,
                        decoration: const InputDecoration(
                          labelText: 'Service Type',
                          prefixIcon: Icon(Icons.home_work_outlined),
                          border: OutlineInputBorder(),
                        ),
                        items: ServiceCategory.values.map((
                          ServiceCategory category,
                        ) {
                          return DropdownMenuItem<ServiceCategory>(
                            value: category,
                            child: Text(_getServiceCategoryName(category)),
                          );
                        }).toList(),
                        onChanged: (ServiceCategory? value) {
                          if (value != null) {
                            setState(() {
                              _selectedService = value;
                              _estimatedPrice = _calculatePrice(value);
                            });
                          }
                        },
                      ),
                      const SizedBox(height: 16),

                      // Date and Time Selection
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Date',
                                  prefixIcon: Icon(Icons.calendar_today),
                                  border: OutlineInputBorder(),
                                ),
                                child: Text(
                                  _selectedDate != null
                                      ? '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}'
                                      : 'Select Date',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectTime(context),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Time',
                                  prefixIcon: Icon(Icons.access_time),
                                  border: OutlineInputBorder(),
                                ),
                                child: Text(
                                  _selectedTime != null
                                      ? _selectedTime!.format(context)
                                      : 'Select Time',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Address Section
                      const SectionHeader(
                        title: 'Service Address',
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
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return l10n.fieldRequired;
                          }
                          return null;
                        },
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
                              controller: _stateController,
                              decoration: const InputDecoration(
                                labelText: 'State',
                                border: OutlineInputBorder(),
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
                              controller: _zipCodeController,
                              decoration: const InputDecoration(
                                labelText: 'ZIP',
                                border: OutlineInputBorder(),
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
                        controller: _notesController,
                        decoration: const InputDecoration(
                          labelText: 'Special Instructions',
                          prefixIcon: Icon(Icons.note_outlined),
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 3,
                      ),
                      const SizedBox(height: 24),

                      // Price Display
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withValues(
                            alpha: 0.3,
                          ),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: theme.colorScheme.primary.withValues(
                              alpha: 0.3,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              'Estimated Price:',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              '\$${_estimatedPrice.toStringAsFixed(2)}',
                              style: theme.textTheme.titleLarge?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                    onPressed: () => _createBooking(context),
                    child: Text(l10n.create),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getServiceCategoryName(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.cleaning:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.standardCleaning:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.regularCleaning:
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
      case ServiceCategory.deepCleaning:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.moveInOut:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.postConstruction:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.commercial:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.residential:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.specialized:
        // TODO: Handle this case.
        throw UnimplementedError();
      case ServiceCategory.other:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
  }

  double _calculatePrice(ServiceCategory category) {
    switch (category) {
      case ServiceCategory.standardCleaning:
        return 120.0;
      case ServiceCategory.regularCleaning:
        return 100.0;
      case ServiceCategory.deepCleaning:
        return 200.0;
      case ServiceCategory.moveInOut:
        return 250.0;
      case ServiceCategory.postConstruction:
        return 300.0;
      case ServiceCategory.commercial:
        return 180.0;
      case ServiceCategory.residential:
        return 220.0;
      case ServiceCategory.specialized:
        return 350.0;
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

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: const TimeOfDay(hour: 9, minute: 0),
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  void _createBooking(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_selectedDate == null || _selectedTime == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select date and time')),
        );
        return;
      }

      final DateTime scheduledDateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final Address address = Address(
        street: _streetController.text.trim(),
        city: _cityController.text.trim(),
        state: _stateController.text.trim(),
        postalCode: _zipCodeController.text.trim(),
        instructions: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        id: '',
        createdAt: null,
        updatedAt: null,
        type: AddressType.work,
        country: '',
      );

      final Booking booking = Booking(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        clientId: DateTime.now().millisecondsSinceEpoch.toString(),
        addressId: address.id,
        scheduledStartTime: scheduledDateTime,
        status: BookingStatus.pending,
        totalAmount: _estimatedPrice,
        specialInstructions: _notesController.text.trim().isEmpty
            ? null
            : _notesController.text.trim(),
        createdAt: DateTime.now(),
        updatedAt: null,
        professionalId: '',
        serviceId: '',
        scheduledEndTime: scheduledDateTime.endOfDay,
      );

      // Dispatch action to create booking
      StoreProvider.of<AppState>(
        context,
        listen: false,
      ).dispatch(CreateBookingAction(booking));

      Navigator.of(context).pop();

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Booking created successfully'),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
      );
    }
  }
}
