import '../models/user_model.dart';
import '../models/student_model.dart';
import '../models/attendance_model.dart';
import '../models/fee_model.dart';
import '../models/homework_model.dart';
import '../models/exam_model.dart';
import '../models/notice_model.dart';
import '../models/timetable_model.dart';
import '../models/admission_inquiry_model.dart';

class SchoolDataRepository {
  static const String schoolName = 'Al-Qalam Public School';
  static const String schoolTagline = 'We Shape Your Future';
  static const String schoolMottoArabic = 'الَّذِي عَلَّمَ بِالْقَلَمِ';
  static const String schoolMottoTranslation = 'Who taught by the pen (Surah Al-Alaq)';
  static const String schoolAddress =
      'Dr. Fateullah Colony, Near Water Tank, Gulzarbagh, Patna - 800007, Bihar';
  static const String schoolPhone = '+91 93084 62418';
  static const String schoolEmail = 'info@alqalam.edu.in';
  static const String directorName = 'Rahat Jahan';
  static const String directorTitle = 'Director & Founder';

  // Demo Users
  static final List<AppUser> demoUsers = [
    const AppUser(
      id: 'USR-PARENT-01',
      name: 'Mohd. Tariq Alam',
      email: 'tariq.alam@gmail.com',
      phone: '+91 98350 12450',
      role: UserRole.parent,
      designation: 'Parent of Zaid Alam (Class 3-A)',
      studentId: 'STU-001',
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
      id: 'USR-ADMIN-01',
      name: 'Rahat Jahan',
      email: 'director@alqalam.edu.in',
      phone: '+91 93084 62418',
      role: UserRole.admin,
      designation: 'Director & Campus Administrator',
    ),
  ];

  // Students List
  static final List<Student> initialStudents = [
    const Student(
      id: 'STU-001',
      admissionNo: 'AQPS-2024-082',
      name: 'Zaid Alam',
      grade: 'Class 3',
      section: 'A',
      rollNo: 12,
      fatherName: 'Mohd. Tariq Alam',
      motherName: 'Shabana Khatoon',
      phone: '+91 98350 12450',
      address: 'Gulzarbagh Main Bazar, Patna - 800007',
      dob: '14-Aug-2017',
      bloodGroup: 'B+',
      attendanceRate: 94.2,
      pendingFees: 1200.0,
    ),
    const Student(
      id: 'STU-002',
      admissionNo: 'AQPS-2024-089',
      name: 'Aisha Fatima',
      grade: 'Class 3',
      section: 'A',
      rollNo: 15,
      fatherName: 'Syed Arshad Ali',
      motherName: 'Nusrat Parveen',
      phone: '+91 97092 33411',
      address: 'Near Old Water Tank, Gulzarbagh, Patna',
      dob: '05-Jan-2018',
      bloodGroup: 'O+',
      attendanceRate: 97.5,
      pendingFees: 0.0,
    ),
    const Student(
      id: 'STU-003',
      admissionNo: 'AQPS-2024-094',
      name: 'Rayan Siddiqui',
      grade: 'Class 3',
      section: 'A',
      rollNo: 18,
      fatherName: 'Imran Siddiqui',
      motherName: 'Nazia Begum',
      phone: '+91 99341 88200',
      address: 'Fateullah Colony Road #3, Gulzarbagh',
      dob: '22-Oct-2017',
      bloodGroup: 'A+',
      attendanceRate: 88.0,
      pendingFees: 2400.0,
    ),
    const Student(
      id: 'STU-004',
      admissionNo: 'AQPS-2024-102',
      name: 'Maryam Khan',
      grade: 'Class 3',
      section: 'A',
      rollNo: 21,
      fatherName: 'Asif Khan',
      motherName: 'Sultana Khan',
      phone: '+91 91234 56789',
      address: 'Sultanganj Crossing, Patna City',
      dob: '12-Mar-2018',
      bloodGroup: 'AB+',
      attendanceRate: 92.0,
      pendingFees: 0.0,
    ),
    const Student(
      id: 'STU-005',
      admissionNo: 'AQPS-2024-110',
      name: 'Hamza Tariq',
      grade: 'Class 3',
      section: 'A',
      rollNo: 24,
      fatherName: 'Tariq Anwar',
      motherName: 'Farida Bano',
      phone: '+91 93345 67890',
      address: 'Bari Patan Devi Road, Patna',
      dob: '19-Jun-2017',
      bloodGroup: 'O-',
      attendanceRate: 91.5,
      pendingFees: 1200.0,
    ),
    const Student(
      id: 'STU-006',
      admissionNo: 'AQPS-2025-014',
      name: 'Zainab Parveen',
      grade: 'Class 3',
      section: 'A',
      rollNo: 28,
      fatherName: 'Kamran Haider',
      motherName: 'Salma Khatoon',
      phone: '+91 98012 34567',
      address: 'Ranipur, Patna City',
      dob: '02-Dec-2017',
      bloodGroup: 'B-',
      attendanceRate: 96.0,
      pendingFees: 0.0,
    ),
  ];

  // Attendance History for Zaid Alam (STU-001)
  static final List<AttendanceRecord> initialAttendance = [
    const AttendanceRecord(
      id: 'ATT-101',
      studentId: 'STU-001',
      date: '2026-09-29',
      status: AttendanceStatus.present,
      remarks: 'Present in morning assembly',
    ),
    const AttendanceRecord(
      id: 'ATT-102',
      studentId: 'STU-001',
      date: '2026-09-28',
      status: AttendanceStatus.present,
    ),
    const AttendanceRecord(
      id: 'ATT-103',
      studentId: 'STU-001',
      date: '2026-09-27',
      status: AttendanceStatus.holiday,
      remarks: 'Sunday',
    ),
    const AttendanceRecord(
      id: 'ATT-104',
      studentId: 'STU-001',
      date: '2026-09-26',
      status: AttendanceStatus.present,
    ),
    const AttendanceRecord(
      id: 'ATT-105',
      studentId: 'STU-001',
      date: '2026-09-25',
      status: AttendanceStatus.late,
      remarks: 'Arrived 10 mins late due to rain',
    ),
    const AttendanceRecord(
      id: 'ATT-106',
      studentId: 'STU-001',
      date: '2026-09-24',
      status: AttendanceStatus.present,
    ),
    const AttendanceRecord(
      id: 'ATT-107',
      studentId: 'STU-001',
      date: '2026-09-23',
      status: AttendanceStatus.present,
    ),
    const AttendanceRecord(
      id: 'ATT-108',
      studentId: 'STU-001',
      date: '2026-09-22',
      status: AttendanceStatus.present,
    ),
    const AttendanceRecord(
      id: 'ATT-109',
      studentId: 'STU-001',
      date: '2026-09-21',
      status: AttendanceStatus.absent,
      remarks: 'Informed leave - Medical appointment',
    ),
  ];

  // Fee Receipts & Dues
  static final List<FeeReceipt> initialFees = [
    const FeeReceipt(
      id: 'FEE-2026-Q3',
      receiptNo: 'REC-AQPS-9842',
      studentId: 'STU-001',
      studentName: 'Zaid Alam',
      grade: 'Class 3-A',
      term: 'Quarter 3 (Jul - Sep 2026)',
      totalAmount: 3600.0,
      paidAmount: 2400.0,
      dueAmount: 1200.0,
      dueDate: '10-Oct-2026',
      paidDate: '15-Aug-2026',
      status: FeeStatus.pending,
      paymentMode: 'UPI / PhonePe',
    ),
    const FeeReceipt(
      id: 'FEE-2026-Q2',
      receiptNo: 'REC-AQPS-7120',
      studentId: 'STU-001',
      studentName: 'Zaid Alam',
      grade: 'Class 3-A',
      term: 'Quarter 2 (Apr - Jun 2026)',
      totalAmount: 3600.0,
      paidAmount: 3600.0,
      dueAmount: 0.0,
      dueDate: '10-Jul-2026',
      paidDate: '08-Jul-2026',
      status: FeeStatus.paid,
      paymentMode: 'School Cash Counter',
    ),
    const FeeReceipt(
      id: 'FEE-2026-Q1',
      receiptNo: 'REC-AQPS-5421',
      studentId: 'STU-001',
      studentName: 'Zaid Alam',
      grade: 'Class 3-A',
      term: 'Quarter 1 (Jan - Mar 2026)',
      totalAmount: 3600.0,
      paidAmount: 3600.0,
      dueAmount: 0.0,
      dueDate: '10-Apr-2026',
      paidDate: '05-Apr-2026',
      status: FeeStatus.paid,
      paymentMode: 'Net Banking',
    ),
  ];

  // Homework & Digital Diary Items
  static final List<HomeworkItem> initialHomework = [
    const HomeworkItem(
      id: 'HW-01',
      subject: 'Mathematics',
      title: 'Multiplication Tables & Word Problems',
      description:
          'Complete Exercise 4.2 in workbook (Questions 1 to 10). Memorize tables of 8 and 9 for oral viva.',
      grade: 'Class 3',
      assignedDate: '29-Sep-2026',
      dueDate: '01-Oct-2026',
      teacherName: 'Farzana Begum',
      isCompleted: false,
    ),
    const HomeworkItem(
      id: 'HW-02',
      subject: 'English Grammar',
      title: 'Nouns & Pronouns Practice Sheet',
      description:
          'Read Chapter 5 "The Clever Rabbit" and underline all proper and common nouns. Write 5 sentences using pronouns.',
      grade: 'Class 3',
      assignedDate: '28-Sep-2026',
      dueDate: '30-Sep-2026',
      teacherName: 'Nuzhat Ara',
      isCompleted: true,
    ),
    const HomeworkItem(
      id: 'HW-03',
      subject: 'Environmental Studies (EVS)',
      title: 'Our Natural Helpers & Plant Parts',
      description:
          'Draw and label parts of a plant in your EVS project scrapbook. List 4 uses of medicinal plants found at home.',
      grade: 'Class 3',
      assignedDate: '27-Sep-2026',
      dueDate: '02-Oct-2026',
      teacherName: 'Farzana Begum',
      isCompleted: false,
    ),
    const HomeworkItem(
      id: 'HW-04',
      subject: 'Urdu & Moral Values',
      title: 'Penmanship & Moral Lesson',
      description:
          'Practice 2 pages of Urdu Khushkhati (calligraphy). Memorize the 4 golden words of respect.',
      grade: 'Class 3',
      assignedDate: '26-Sep-2026',
      dueDate: '29-Sep-2026',
      teacherName: 'Maulana Qasim',
      isCompleted: true,
    ),
  ];

  // Exam Report Cards
  static final List<ExamReportCard> initialReportCards = [
    const ExamReportCard(
      id: 'REP-MID-2026',
      examTitle: 'Half-Yearly Evaluation Examination 2026',
      studentId: 'STU-001',
      studentName: 'Zaid Alam',
      grade: 'Class 3-A',
      term: 'Term 1 Evaluation',
      issueDate: '20-Sep-2026',
      rankInClass: 3,
      teacherRemarks:
          'Zaid shows exemplary arithmetic reasoning and enthusiastic participation in class discussions. Keep practicing handwriting.',
      directorRemarks:
          'Commendable academic progress. Promoted with distinction honours.',
      scores: [
        SubjectScore(
          subject: 'English Language & Reading',
          marksObtained: 88,
          maxMarks: 100,
          gradeLetter: 'A',
          remarks: 'Fluent reading and excellent vocabulary.',
        ),
        SubjectScore(
          subject: 'Mathematics & Arithmetic',
          marksObtained: 95,
          maxMarks: 100,
          gradeLetter: 'A+',
          remarks: 'Outstanding speed in mental maths.',
        ),
        SubjectScore(
          subject: 'Environmental Studies (EVS)',
          marksObtained: 90,
          maxMarks: 100,
          gradeLetter: 'A+',
          remarks: 'Strong conceptual grasp of nature and science.',
        ),
        SubjectScore(
          subject: 'Hindi Literature & Vyakaran',
          marksObtained: 82,
          maxMarks: 100,
          gradeLetter: 'A',
          remarks: 'Good comprehension; spelling needs minor focus.',
        ),
        SubjectScore(
          subject: 'Urdu & Islamic Moral Studies',
          marksObtained: 92,
          maxMarks: 100,
          gradeLetter: 'A+',
          remarks: 'Well disciplined and excellent recitation.',
        ),
        SubjectScore(
          subject: 'Drawing, Craft & General Knowledge',
          marksObtained: 94,
          maxMarks: 100,
          gradeLetter: 'A+',
          remarks: 'Highly creative and curious.',
        ),
      ],
    ),
  ];

  // School Notices
  static final List<SchoolNotice> initialNotices = [
    const SchoolNotice(
      id: 'NTC-01',
      title: 'Admissions Open for Session 2026-27 (Nursery to Class 5)',
      date: '25-Sep-2026',
      category: 'Admissions',
      isImportant: true,
      summary:
          'Admission forms and prospectuses are now available at the school administrative desk and via the online portal.',
      details:
          'Al-Qalam Public School invites applications for foundational and primary classes for the upcoming academic session. Parents may collect the registration kit from the school reception between 8:30 AM and 1:30 PM on all working days or register interest through this app. Early interaction rounds will begin next month.',
    ),
    const SchoolNotice(
      id: 'NTC-02',
      title: 'Parent-Teacher Interaction Meeting (Class 1 to 5)',
      date: '22-Sep-2026',
      category: 'Academic',
      isImportant: true,
      summary:
          'Quarterly PTM scheduled for Saturday to discuss Mid-Term evaluation progress and holistic student development.',
      details:
          'All parents and guardians are requested to attend the interactive session between 9:00 AM and 12:30 PM. Class teachers will share evaluation sheets, handwriting samples, and personal developmental observations. Roll number-wise time slots are pinned on the school board.',
    ),
    const SchoolNotice(
      id: 'NTC-03',
      title: 'Annual Children Day Cultural & Drawing Exhibition',
      date: '18-Sep-2026',
      category: 'General',
      isImportant: false,
      summary:
          'Inter-house art competition, speech recitations, and award ceremony scheduled for next month.',
      details:
          'Students from Kindergarten through Class 5 will participate in calligraphy, poster making, science models, and moral story enactments. Refreshments will be arranged for all attending guests and parents.',
    ),
    const SchoolNotice(
      id: 'NTC-04',
      title: 'Campus Safety & Verified Entry Badge Protocols',
      date: '10-Sep-2026',
      category: 'Safety',
      isImportant: false,
      summary:
          'Reinforced security check and guardian identification card mandatory during dispersal hours.',
      details:
          'To ensure the highest child security, gate access at 1:30 PM requires parents/guardians to present the authorized student pick-up card. CCTV monitoring is active across all entry hallways and school playground zones.',
    ),
  ];

  // Weekly Timetable (Class 3-A)
  static final List<DayTimetable> timetableData = [
    const DayTimetable(
      dayName: 'Monday',
      slots: [
        TimetableSlot(
          period: 1,
          time: '08:30 - 09:15',
          subject: 'Morning Assembly & Moral Science',
          teacher: 'Farzana Begum',
          room: 'Hall A',
        ),
        TimetableSlot(
          period: 2,
          time: '09:15 - 10:00',
          subject: 'Mathematics',
          teacher: 'Farzana Begum',
          room: 'Room 102',
        ),
        TimetableSlot(
          period: 3,
          time: '10:00 - 10:45',
          subject: 'English Language',
          teacher: 'Nuzhat Ara',
          room: 'Room 102',
        ),
        TimetableSlot(
          period: 4,
          time: '11:15 - 12:00',
          subject: 'EVS / Science',
          teacher: 'Farzana Begum',
          room: 'Room 102',
        ),
        TimetableSlot(
          period: 5,
          time: '12:00 - 12:45',
          subject: 'Urdu / Hindi',
          teacher: 'Maulana Qasim',
          room: 'Room 102',
        ),
        TimetableSlot(
          period: 6,
          time: '12:45 - 01:30',
          subject: 'Art & Craft / Activity',
          teacher: 'Saba Parveen',
          room: 'Creative Studio',
        ),
      ],
    ),
    const DayTimetable(
      dayName: 'Tuesday',
      slots: [
        TimetableSlot(
          period: 1,
          time: '08:30 - 09:15',
          subject: 'English Reading & Phonics',
          teacher: 'Nuzhat Ara',
          room: 'Room 102',
        ),
        TimetableSlot(
          period: 2,
          time: '09:15 - 10:00',
          subject: 'Mathematics',
          teacher: 'Farzana Begum',
          room: 'Room 102',
        ),
        TimetableSlot(
          period: 3,
          time: '10:00 - 10:45',
          subject: 'Computer Literacy',
          teacher: 'Rashid Khan',
          room: 'Smart Lab',
        ),
        TimetableSlot(
          period: 4,
          time: '11:15 - 12:00',
          subject: 'EVS Exploration',
          teacher: 'Farzana Begum',
          room: 'Room 102',
        ),
        TimetableSlot(
          period: 5,
          time: '12:00 - 12:45',
          subject: 'Hindi Vyakaran',
          teacher: 'Sunita Sharma',
          room: 'Room 102',
        ),
        TimetableSlot(
          period: 6,
          time: '12:45 - 01:30',
          subject: 'Library & Reading Hour',
          teacher: 'Nuzhat Ara',
          room: 'Library',
        ),
      ],
    ),
  ];

  // Inbound Admission Inquiries
  static final List<AdmissionInquiry> initialInquiries = [
    const AdmissionInquiry(
      id: 'INQ-101',
      referenceId: 'AQPS-884102',
      studentName: 'Zubair Akhtar',
      parentName: 'Md. Akhtar Hussain',
      mobile: '+91 94318 76543',
      grade: 'Class 1',
      message:
          'Seeking admission for Class 1. We recently shifted to Gulzarbagh near the station.',
      submissionDate: '28-Sep-2026',
      status: 'New Enquiry',
    ),
    const AdmissionInquiry(
      id: 'INQ-102',
      referenceId: 'AQPS-884095',
      studentName: 'Fatima Zahra',
      parentName: 'Dr. Shakeel Ahmad',
      mobile: '+91 98352 11980',
      grade: 'Lower Kindergarten (LKG)',
      message:
          'Interested in LKG play-based curriculum and safe transportation options.',
      submissionDate: '26-Sep-2026',
      status: 'Contacted',
    ),
    const AdmissionInquiry(
      id: 'INQ-103',
      referenceId: 'AQPS-883980',
      studentName: 'Amaan Raza',
      parentName: 'Feroz Raza',
      mobile: '+91 97098 44321',
      grade: 'Class 4',
      message:
          'Transfer case from previous primary school with transfer certificate ready.',
      submissionDate: '24-Sep-2026',
      status: 'Campus Visit Scheduled',
    ),
  ];
}
