import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/localization/localization_extensions.dart';

({String label, Color color}) getStatusInfo(BookingStatus status) {
  // Use humanized, localized labels via extensions to avoid hardcoded strings
  final ctx = WidgetsBinding.instance.focusManager.primaryFocus?.context;
  final label = ctx != null ? status.label(ctx) : status.name;
  switch (status) {
    case BookingStatus.pending:
      return (label: label, color: Colors.orange);
    case BookingStatus.confirmed:
      return (label: label, color: Colors.blue);
    case BookingStatus.assigned:
      return (label: label, color: Colors.teal);
    case BookingStatus.inProgress:
      return (label: label, color: Colors.purple);
    case BookingStatus.completed:
      return (label: label, color: Colors.green);
    case BookingStatus.cancelled:
      return (label: label, color: Colors.red);
    case BookingStatus.rescheduled:
      return (label: label, color: Colors.amber);
    case BookingStatus.noShow:
      return (label: label, color: Colors.grey);
  }
}
