import 'package:domain/domain.dart';
import 'package:flutter/material.dart';
import 'package:languist/languist.dart';

Color getActivityColor(HousekeepingActivityType type) {
  switch (type) {
    case HousekeepingActivityType.bookingCreated:
      return Colors.blue;
    case HousekeepingActivityType.bookingConfirmed:
      return Colors.green;
    case HousekeepingActivityType.bookingStarted:
      return Colors.lightGreen;
    case HousekeepingActivityType.bookingCompleted:
      return Colors.lightGreen;
    case HousekeepingActivityType.bookingCancelled:
      return Colors.red;
    case HousekeepingActivityType.bookingRescheduled:
      return Colors.orange;
    case HousekeepingActivityType.professionalAssigned:
      return Colors.purple;
    case HousekeepingActivityType.professionalUnassigned:
      return Colors.grey;
    case HousekeepingActivityType.paymentReceived:
      return Colors.green;
    case HousekeepingActivityType.reviewSubmitted:
      return Colors.amber;
    case HousekeepingActivityType.customerRegistered:
      return Colors.indigo;
    case HousekeepingActivityType.professionalRegistered:
      return Colors.cyan;
  }
}

IconData getActivityIcon(HousekeepingActivityType type) {
  switch (type) {
    case HousekeepingActivityType.bookingCreated:
      return Icons.add_circle_outline;
    case HousekeepingActivityType.bookingConfirmed:
      return Icons.check_circle_outline;
    case HousekeepingActivityType.bookingStarted:
      return Icons.play_circle_outline;
    case HousekeepingActivityType.bookingCompleted:
      return Icons.task_alt;
    case HousekeepingActivityType.bookingCancelled:
      return Icons.cancel_outlined;
    case HousekeepingActivityType.bookingRescheduled:
      return Icons.schedule;
    case HousekeepingActivityType.professionalAssigned:
      return Icons.person_add_outlined;
    case HousekeepingActivityType.professionalUnassigned:
      return Icons.person_remove_outlined;
    case HousekeepingActivityType.paymentReceived:
      return Icons.payment;
    case HousekeepingActivityType.reviewSubmitted:
      return Icons.star_outline;
    case HousekeepingActivityType.customerRegistered:
      return Icons.person_outline;
    case HousekeepingActivityType.professionalRegistered:
      return Icons.cleaning_services_outlined;
  }
}

String getActivityTypeName(
  BuildContext context,
  HousekeepingActivityType type,
) {
  switch (type) {
    case HousekeepingActivityType.bookingCreated:
      return 'l10n.bookingCreated';
    case HousekeepingActivityType.bookingConfirmed:
      return 'l10n.bookingConfirmed';
    case HousekeepingActivityType.bookingStarted:
      return 'l10n.bookingStarted';
    case HousekeepingActivityType.bookingCompleted:
      return 'l10n.bookingCompleted';
    case HousekeepingActivityType.bookingCancelled:
      return 'l10n.bookingCancelled';
    case HousekeepingActivityType.bookingRescheduled:
      return 'l10n.bookingRescheduled';
    case HousekeepingActivityType.professionalAssigned:
      return 'l10n.professionalAssigned';
    case HousekeepingActivityType.professionalUnassigned:
      return 'l10n.professionalUnassigned';
    case HousekeepingActivityType.paymentReceived:
      return 'l10n.paymentReceived';
    case HousekeepingActivityType.reviewSubmitted:
      return 'l10n.reviewSubmitted';
    case HousekeepingActivityType.customerRegistered:
      return 'l10n.customerRegistered';
    case HousekeepingActivityType.professionalRegistered:
      return 'l10n.professionalRegistered';
  }
}
