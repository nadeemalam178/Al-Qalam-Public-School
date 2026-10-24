import '../models/student_model.dart';
import '../models/attendance_model.dart';
import '../models/fee_model.dart';
import '../models/homework_model.dart';
import '../models/exam_model.dart';
import '../models/notice_model.dart';
import '../models/admission_inquiry_model.dart';
import '../models/timetable_model.dart';

/// Central School Data Repository
/// Cleaned of all demonstration/dummy records so data is 100% genuine and synced.
class SchoolDataRepository {
  // Empty Students List (Real students load from Supabase or administrative entry)
  static final List<Student> initialStudents = const [];

  // Empty Attendance Records
  static final List<AttendanceRecord> initialAttendance = const [];

  // Empty Fee Receipts
  static final List<FeeReceipt> initialFees = const [];

  // Empty Homework Assignments
  static final List<HomeworkItem> initialHomework = const [];

  // Empty Report Cards
  static final List<ExamReportCard> initialReportCards = const [];

  // Empty School Notices (Only real notices broadcasted by Administrator appear)
  static final List<SchoolNotice> initialNotices = const [];

  // Class Routine / Timetable Structure
  static final List<DayTimetable> timetableData = const [
    DayTimetable(
      dayName: 'Monday',
      slots: [
        TimetableSlot(
          period: 1,
          time: '08:00 AM - 08:45 AM',
          subject: 'Assembly & Morning Dua',
          teacher: 'School Faculty',
          room: 'Main Ground',
        ),
      ],
    ),
  ];

  // Empty Inbound Admission Inquiries (Populated directly from Website submissions)
  static final List<AdmissionInquiry> initialInquiries = const [];
}
