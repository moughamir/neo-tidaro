import 'package:domain/enums/enums.dart';

import 'time_slot_dto.dart';

class CreateBookingDto {
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
  final String clientId;
  final String professionalId;
  final String serviceId;
  final DateTime scheduledDate;
  final TimeSlotDto timeSlot;
  final String addressId;
  final PaymentMethod paymentMethod;
  final String? specialInstructions;
  final JobRecurrenceType recurrence;
  final List<String>? attachments;

  final int durationMinutes;
  final double totalPrice;

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

class UpdateBookingStatusDto {
  const UpdateBookingStatusDto({
    required this.bookingId,
    required this.status,
    this.reason,
    this.metadata,
  });
  final String bookingId;
  final BookingActivityStatus status;
  final String? reason;
  final Map<String, dynamic>? metadata;

  Map<String, dynamic> toJson() => {
    'booking_id': bookingId,
    'status': status.name,
    'reason': reason,
    'metadata': metadata,
  };
}

class SetAvailabilityDto {
  const SetAvailabilityDto({
    required this.professionalId,
    required this.dayOfWeek,
    required this.timeSlots,
    this.specificDate,
  });
  final String professionalId;
  final DayOfWeek dayOfWeek;
  final List<TimeSlotDto> timeSlots;
  final DateTime? specificDate;

  Map<String, dynamic> toJson() => {
    'professional_id': professionalId,
    'day_of_week': dayOfWeek.name,
    'time_slots': timeSlots.map((ts) => ts.toJson()).toList(),
    'specific_date': specificDate?.toIso8601String(),
  };
}
