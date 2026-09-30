enum AttendanceStatus {
  present,
  absent,
  late,
  holiday,
}

class AttendanceRecord {
  final String id;
  final String studentId;
  final String date; // YYYY-MM-DD
  final AttendanceStatus status;
  final String? remarks;

  const AttendanceRecord({
    required this.id,
    required this.studentId,
    required this.date,
    required this.status,
    this.remarks,
  });

  String get label {
    switch (status) {
      case AttendanceStatus.present:
        return 'Present';
      case AttendanceStatus.absent:
        return 'Absent';
      case AttendanceStatus.late:
        return 'Late';
      case AttendanceStatus.holiday:
        return 'Holiday';
    }
  }
}
