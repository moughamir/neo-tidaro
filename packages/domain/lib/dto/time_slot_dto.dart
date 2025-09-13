class TimeSlotDto {
  const TimeSlotDto({required this.startTime, required this.endTime});

  factory TimeSlotDto.fromJson(Map<String, dynamic> json) =>
      TimeSlotDto(startTime: json['start_time'], endTime: json['end_time']);
  final String startTime;
  final String endTime;

  Map<String, dynamic> toJson() => {
    'start_time': startTime,
    'end_time': endTime,
  };
}
