import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit/src/localization/localization_extensions.dart';

({String label, Color color}) getStatusInfo(
  BuildContext context,
  BookingActivityStatus status,
) {
  final label = status.label(context);
  switch (status) {
    case BookingActivityStatus.pending:
      return (label: label, color: Colors.orange);
    case BookingActivityStatus.confirmed:
      return (label: label, color: Colors.blue);
    case BookingActivityStatus.assigned:
      return (label: label, color: Colors.teal);
    case BookingActivityStatus.inProgress:
      return (label: label, color: Colors.purple);
    case BookingActivityStatus.completed:
      return (label: label, color: Colors.green);
    case BookingActivityStatus.cancelled:
      return (label: label, color: Colors.red);
    case BookingActivityStatus.rescheduled:
      return (label: label, color: Colors.amber);
    case BookingActivityStatus.noShow:
      return (label: label, color: Colors.grey);
  }
}
