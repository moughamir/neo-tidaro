import 'package:domain/enums/enums.dart';

import 'time_slot_dto.dart';

/// Data transfer object for creating a booking.
class CreateBookingDto {
  /// Creates a new instance of [CreateBookingDto].
  const CreateBookingDto({
    required this.clientId,
    required this.professionalId,
    required this.serviceId,
    required this.scheduledDate,
    required this.timeSlot,
    required this.addressId,
    required this.paymentMethod,
    this.specialInstructions,
    this.recurrence = JobRecurrenceType.none,
    this.attachments,

    required this.durationMinutes,
    required this.totalPrice,
  });
  /// The ID of the client making the booking.
  final String clientId;
  /// The ID of the professional being booked.
  final String professionalId;
  /// The ID of the service being booked.
  final String serviceId;
  /// The scheduled date of the booking.
  final DateTime scheduledDate;
  /// The time slot of the booking.
  final TimeSlotDto timeSlot;
  /// The ID of the address for the booking.
  final String addressId;
  /// The payment method for the booking.
  final PaymentMethod paymentMethod;
  /// Any special instructions for the booking.
  final String? specialInstructions;
  /// The recurrence type of the booking.
  final JobRecurrenceType recurrence;
  /// A list of attachment URLs for the booking.
  final List<String>? attachments;

  /// The duration of the booking in minutes.
  final int durationMinutes;
  /// The total price of the booking.
  final double totalPrice;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'client_id': clientId,
    'professional_id': professionalId,
    'service_id': serviceId,
    'scheduled_date': scheduledDate.toIso8601String(),
    'time_slot': timeSlot.toJson(),
    'address_id': addressId,
    'payment_method': paymentMethod.name,
    'special_instructions': specialInstructions,
    'recurrence': recurrence.name,
    'attachments': attachments,
    'duration_minutes': durationMinutes,
    'total_price': totalPrice,
    'status': 'pending',
  };
}

/// Data transfer object for updating a booking's status.
class UpdateBookingStatusDto {
  /// Creates a new instance of [UpdateBookingStatusDto].
  const UpdateBookingStatusDto({
    required this.bookingId,
    required this.status,
    this.reason,
    this.metadata,
  });
  /// The ID of the booking to update.
  final String bookingId;
  /// The new status of the booking.
  final BookingActivityStatus status;
  /// The reason for the status update.
  final String? reason;
  /// Additional metadata for the status update.
  final Map<String, dynamic>? metadata;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'booking_id': bookingId,
    'status': status.name,
    'reason': reason,
    'metadata': metadata,
  };
}

/// Data transfer object for setting a professional's availability.
class SetAvailabilityDto {
  /// Creates a new instance of [SetAvailabilityDto].
  const SetAvailabilityDto({
    required this.professionalId,
    required this.dayOfWeek,
    required this.timeSlots,
    this.specificDate,
  });
  /// The ID of the professional.
  final String professionalId;
  /// The day of the week for the availability.
  final DayOfWeek dayOfWeek;
  /// The time slots for the availability.
  final List<TimeSlotDto> timeSlots;
  /// A specific date for the availability.
  final DateTime? specificDate;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'professional_id': professionalId,
    'day_of_week': dayOfWeek.name,
    'time_slots': timeSlots.map((ts) => ts.toJson()).toList(),
    'specific_date': specificDate?.toIso8601String(),
  };
}