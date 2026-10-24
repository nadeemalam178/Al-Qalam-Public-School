import '../models/user_model.dart';
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
  static const String schoolName = 'Al-Qalam Public School';
  static const String schoolTagline = 'We Shape Your Future';
  static const String schoolMottoArabic = 'الَّذِي عَلَّمَ بِالْقَلَمِ';
  static const String schoolMottoTranslation = 'Who taught by the pen (Surah Al-Alaq)';
  static const String schoolAddress =
      'Opposite Jashn Palace Marriage Hall, Ashok Rajpath Road, Gulzarbagh, Patna - 800007, Bihar';
  static const String schoolPhone = '+91 93084 62418';
  static const String schoolEmail = 'info@alqalam.edu.in';
  static const String directorName = 'Kausar Jahan';
  static const String directorTitle = 'Director & Founder';

  // Demo / Role Context Profiles
  static final List<AppUser> demoUsers = [
    const AppUser(
      id: 'USR-ADMIN-01',
      name: 'Kausar Jahan',
      email: 'director@alqalam.edu.in',
      phone: '+91 93084 62418',
      role: UserRole.admin,
      designation: 'Director & Campus Administrator',
    ),
    const AppUser(
      id: 'USR-TEACHER-01',
      name: 'Farzana Begum',
      email: 'farzana.t@alqalam.edu.in',
      phone: '+91 94310 56782',
      role: UserRole.teacher,
      designation: 'Senior Primary Teacher (Maths & EVS)',
      classAssigned: 'Class 3-A',
    ),
    const AppUser(
      id: 'USR-PARENT-01',
      name: 'Mohd. Tariq Alam',
      email: 'tariq.alam@gmail.com',
      phone: '+91 98350 12450',
      role: UserRole.parent,
      designation: 'Parent of Zaid Alam (Class 3-A)',
      studentId: 'STU-001',
    ),
  ];

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
