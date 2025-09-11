class TimeSlotDto {
  final String startTime;
  final String endTime;

  const TimeSlotDto({required this.startTime, required this.endTime});

  Map<String, dynamic> toJson() => {
    'start_time': startTime,
    'end_time': endTime,
  };

  factory TimeSlotDto.fromJson(Map<String, dynamic> json) =>
      TimeSlotDto(startTime: json['start_time'], endTime: json['end_time']);
}
