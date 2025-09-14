/// Data transfer object for a time slot.
class TimeSlotDto {
  /// Creates a new instance of [TimeSlotDto].
  const TimeSlotDto({required this.startTime, required this.endTime});

  /// Creates a new instance of [TimeSlotDto] from a JSON object.
  factory TimeSlotDto.fromJson(Map<String, dynamic> json) =>
      TimeSlotDto(startTime: json['start_time'], endTime: json['end_time']);
  /// The start time of the time slot.
  final String startTime;
  /// The end time of the time slot.
  final String endTime;

  /// Converts the DTO to a JSON object.
  Map<String, dynamic> toJson() => {
    'start_time': startTime,
    'end_time': endTime,
  };
}