class TimetableSlot {
  final int period;
  final String time;
  final String subject;
  final String teacher;
  final String room;

  const TimetableSlot({
    required this.period,
    required this.time,
    required this.subject,
    required this.teacher,
    required this.room,
  });
}

class DayTimetable {
  final String dayName;
  final List<TimetableSlot> slots;

  const DayTimetable({
    required this.dayName,
    required this.slots,
  });
}
