class Student {
  final String id;
  final String admissionNo;
  final String name;
  final String grade;
  final String section;
  final int rollNo;
  final String fatherName;
  final String motherName;
  final String phone;
  final String address;
  final String dob;
  final String bloodGroup;
  final double attendanceRate;
  final double pendingFees;

  const Student({
    required this.id,
    required this.admissionNo,
    required this.name,
    required this.grade,
    required this.section,
    required this.rollNo,
    required this.fatherName,
    required this.motherName,
    required this.phone,
    required this.address,
    required this.dob,
    required this.bloodGroup,
    required this.attendanceRate,
    required this.pendingFees,
  });

  String get fullClass => '$grade - Section $section';
}
