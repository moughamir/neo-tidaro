
class TimeOfDay {

  const TimeOfDay({required this.hour, required this.minute});
  final int hour;
  final int minute;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimeOfDay &&
          runtimeType == other.runtimeType &&
          hour == other.hour &&
          minute == other.minute;

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;

  @override
  String toString() {
    return '$hour:$minute';
  }
}
