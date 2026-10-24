import '../models/teacher_model.dart';
import '../models/gallery_item_model.dart';
import 'package:flutter/foundation.dart';
import '../models/student_model.dart';
import '../models/attendance_model.dart';
import '../models/fee_model.dart';
import '../models/homework_model.dart';
import '../models/notice_model.dart';
import '../models/timetable_model.dart';
import '../models/admission_inquiry_model.dart';
import 'school_data_repository.dart';
import 'supabase_service.dart';

/// Central database repository communicating directly with Supabase PostgreSQL tables.
/// Provides safe offline cache fallback if the client is not connected.
class SupabaseSchoolRepository {
  const SupabaseSchoolRepository();

  // --------------------------------------------------------------------------
  // STUDENTS & GUARDIAN LINKAGE
  // --------------------------------------------------------------------------

  /// Fetches enrolled students from Supabase `students` table.
  Future<List<Student>> fetchStudents() async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      final response = await client
          .from('students')
          .select()
          .order('name', ascending: true);

      final list = (response as List).map((row) => _mapStudent(row)).toList();
      return list;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchStudents fallback: $e');
      return [];
    }
  }

  /// Fetches all linked children for a parent/guardian from `guardian_students`.
  Future<List<Student>> fetchLinkedChildren(String guardianId) async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      final response = await client
          .from('guardian_students')
          .select('student_id, relationship, students(*)')
          .eq('guardian_id', guardianId);

      final List<Student> children = [];
      for (final item in response as List) {
        if (item['students'] != null) {
          children.add(_mapStudent(item['students'] as Map<String, dynamic>));
        }
      }

      return children;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchLinkedChildren fallback: $e');
      return [];
    }
  }

  // --------------------------------------------------------------------------
  // ATTENDANCE
  // --------------------------------------------------------------------------

  /// Fetches attendance records from Supabase `attendance` table.
  Future<List<AttendanceRecord>> fetchAttendance({String? studentId}) async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      var query = client.from('attendance').select();
      if (studentId != null) {
        query = query.eq('student_id', studentId);
      }

      final response = await query.order('date', ascending: false);
      final list =
          (response as List).map((row) => _mapAttendance(row)).toList();
      return list;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchAttendance fallback: $e');
      return [];
    }
  }

  /// Records attendance in Supabase `attendance` table and logs audit.
  Future<void> markAttendance({
    required String studentId,
    required String date,
    required AttendanceStatus status,
    String? remarks,
  }) async {
    final client = SupabaseService.client;
    final statusStr = status.name;

    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('attendance').upsert({
          'student_id': studentId,
          'date': date,
          'status': statusStr,
          'remarks': remarks,
          'recorded_by': SupabaseService.currentUserId,
          'created_at': DateTime.now().toIso8601String(),
        }, onConflict: 'student_id,date');

        await SupabaseService.logAudit(
          action: 'MARK_ATTENDANCE',
          entityType: 'attendance',
          entityId: studentId,
          metadata: {'date': date, 'status': statusStr, 'remarks': remarks},
        );
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] markAttendance error: $e');
      }
    }
  }

  // --------------------------------------------------------------------------
  // HOMEWORK
  // --------------------------------------------------------------------------

  /// Fetches homework assignments from Supabase `homework` table.
  Future<List<HomeworkItem>> fetchHomework({String? grade}) async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      var query = client.from('homework').select();
      if (grade != null) {
        query = query.ilike('grade', '%$grade%');
      }

      final response = await query.order('due_date', ascending: true);
      final list = (response as List).map((row) => _mapHomework(row)).toList();
      return list;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchHomework fallback: $e');
      return [];
    }
  }

  /// Inserts new homework to Supabase `homework` table and logs audit.
  Future<void> addHomework(HomeworkItem item) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('homework').insert({
          'grade': item.grade,
          'subject': item.subject,
          'title': item.title,
          'description': item.description,
          'due_date': item.dueDate,
          'is_completed': item.isCompleted,
          'assigned_by': SupabaseService.currentUserId,
        });

        await SupabaseService.logAudit(
          action: 'ASSIGN_HOMEWORK',
          entityType: 'homework',
          metadata: {
            'title': item.title,
            'subject': item.subject,
            'grade': item.grade,
          },
        );
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] addHomework error: $e');
      }
    }
  }

  /// Toggles homework completion status in Supabase.
  Future<void> toggleHomeworkCompletion(String id, bool isCompleted) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client
            .from('homework')
            .update({'is_completed': isCompleted}).eq('id', id);
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] toggleHomework error: $e');
      }
    }
  }

  // --------------------------------------------------------------------------
  // NOTICES & CIRCULARS (Shared with Next.js Website)
  // --------------------------------------------------------------------------

  /// Fetches school circulars from Supabase `notices` table.
  Future<List<SchoolNotice>> fetchNotices({String? role}) async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      var query = client.from('notices').select().eq('is_active', true);
      if (role != null && role != 'admin') {
        query = query.inFilter('target_role', ['all', role]);
      }

      final response = await query.order('publish_date', ascending: false);
      final list = (response as List).map((row) => _mapNotice(row)).toList();
      return list;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchNotices fallback: $e');
      return [];
    }
  }

  /// Broadcasts notice across Supabase backend, updating website & mobile simultaneously.
  Future<void> broadcastNotice(SchoolNotice notice) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('notices').insert({
          'title': notice.title,
          'content': notice.details.isNotEmpty ? notice.details : notice.summary,
          'category': notice.category,
          'target_role': 'all',
          'is_active': true,
          'publish_date': DateTime.now().toIso8601String(),
          'created_by': SupabaseService.currentUserId,
        });

        await SupabaseService.logAudit(
          action: 'PUBLISH_NOTICE',
          entityType: 'notices',
          metadata: {'title': notice.title, 'category': notice.category},
        );
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] broadcastNotice error: $e');
      }
    }
  }

  /// Deletes or deactivates a notice in Supabase.
  Future<void> deleteNotice(String id) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('notices').update({'is_active': false}).eq('id', id);
        await SupabaseService.logAudit(
          action: 'DELETE_NOTICE',
          entityType: 'notices',
          entityId: id,
        );
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] deleteNotice error: $e');
      }
    }
  }


  // --------------------------------------------------------------------------
  // FEES & PAYMENTS
  // --------------------------------------------------------------------------

  /// Fetches fee invoices & payments from Supabase.
  Future<List<FeeReceipt>> fetchFees({String? studentId}) async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      var query = client.from('fee_invoices').select('*, students(name, grade)');
      if (studentId != null) {
        query = query.eq('student_id', studentId);
      }

      final response = await query.order('due_date', ascending: false);
      final list = (response as List).map((row) => _mapFeeInvoice(row)).toList();
      return list;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchFees fallback: $e');
      return [];
    }
  }

  /// Records fee payment into Supabase `fee_payments` table and logs audit.
  Future<void> recordFeePayment({
    required String invoiceId,
    required double amountPaidNow,
    required String paymentMode,
  }) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        final receiptNo =
            'REC-AQPS-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';

        await client.from('fee_payments').insert({
          'receipt_no': receiptNo,
          'invoice_id': invoiceId,
          'amount': amountPaidNow,
          'payment_mode': paymentMode,
          'transaction_reference': 'COUNTER-$receiptNo',
          'recorded_by': SupabaseService.currentUserId,
        });

        await SupabaseService.logAudit(
          action: 'FEE_PAYMENT_RECORDED',
          entityType: 'fee_payments',
          metadata: {
            'invoice_id': invoiceId,
            'amount': amountPaidNow,
            'receipt_no': receiptNo,
            'mode': paymentMode,
          },
        );
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] recordFeePayment error: $e');
      }
    }
  }

  // --------------------------------------------------------------------------
  // ADMISSION LEADS (Shared with Next.js Website)
  // --------------------------------------------------------------------------

  /// Fetches online admission enquiries submitted from the website.
  Future<List<AdmissionInquiry>> fetchAdmissionInquiries() async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      final response = await client
          .from('admission_enquiries')
          .select()
          .order('created_at', ascending: false);

      final list =
          (response as List).map((row) => _mapInquiry(row)).toList();
      return list;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchAdmissionInquiries fallback: $e');
      return [];
    }
  }

  /// Updates admission lead status in Supabase.
  Future<void> updateInquiryStatus(String id, String status) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        // Map UI string to database enum status if needed
        String dbStatus = status.toLowerCase();
        if (dbStatus.contains('contact')) {
          dbStatus = 'contacted';
        } else if (dbStatus.contains('enrolled') || dbStatus.contains('admit')) {
          dbStatus = 'admitted';
        } else if (dbStatus.contains('reject')) {
          dbStatus = 'rejected';
        } else {
          dbStatus = 'pending';
        }

        await client
            .from('admission_enquiries')
            .update({'status': dbStatus, 'updated_at': DateTime.now().toIso8601String()})
            .eq('id', id);

        await SupabaseService.logAudit(
          action: 'UPDATE_ADMISSION_STATUS',
          entityType: 'admission_enquiries',
          entityId: id,
          metadata: {'status': status, 'db_status': dbStatus},
        );
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] updateInquiryStatus error: $e');
      }
    }
  }

  // --------------------------------------------------------------------------
  // TIMETABLE
  // --------------------------------------------------------------------------

  /// Fetches timetable from Supabase `timetables` table.
  Future<List<TimetableSlot>> fetchTimetable({String? grade}) async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      var query = client.from('timetables').select();
      if (grade != null) {
        query = query.ilike('grade', '%$grade%');
      }

      final response =
          await query.order('period_no', ascending: true);
      final list =
          (response as List).map((row) => _mapTimetable(row)).toList();
      return list.isNotEmpty
          ? list
          : SchoolDataRepository.timetableData.first.slots;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchTimetable fallback: $e');
      return [];
    }
  }

  // --------------------------------------------------------------------------
  // MAPPER UTILITIES
  // --------------------------------------------------------------------------

  Student _mapStudent(Map<String, dynamic> row) {
    return Student(
      id: row['id'] as String,
      admissionNo: (row['admission_no'] ?? 'AQPS-2024-000') as String,
      name: (row['name'] ?? 'Student') as String,
      grade: (row['grade'] ?? 'Class 3') as String,
      section: (row['section'] ?? 'A') as String,
      rollNo: (row['roll_no'] is int) ? row['roll_no'] as int : 1,
      fatherName: (row['father_name'] ?? '') as String,
      motherName: (row['mother_name'] ?? '') as String,
      phone: (row['phone'] ?? '') as String,
      address: (row['address'] ?? '') as String,
      dob: (row['dob'] ?? '') as String,
      bloodGroup: (row['blood_group'] ?? 'B+') as String,
      attendanceRate: (row['attendance_rate'] is num)
          ? (row['attendance_rate'] as num).toDouble()
          : 95.0,
      pendingFees: (row['pending_fees'] is num)
          ? (row['pending_fees'] as num).toDouble()
          : 0.0,
    );
  }

  AttendanceRecord _mapAttendance(Map<String, dynamic> row) {
    AttendanceStatus status = AttendanceStatus.present;
    final statusStr = (row['status'] as String? ?? 'present').toLowerCase();
    if (statusStr == 'absent') status = AttendanceStatus.absent;
    if (statusStr == 'late') status = AttendanceStatus.late;
    if (statusStr == 'holiday' || statusStr == 'excused') {
      status = AttendanceStatus.holiday;
    }

    return AttendanceRecord(
      id: row['id'] as String,
      studentId: (row['student_id'] ?? '') as String,
      date: (row['date'] ?? '30-Sep-2026') as String,
      status: status,
      remarks: row['remarks'] as String?,
    );
  }

  HomeworkItem _mapHomework(Map<String, dynamic> row) {
    return HomeworkItem(
      id: row['id'] as String,
      subject: (row['subject'] ?? 'General') as String,
      title: (row['title'] ?? 'Homework') as String,
      description: (row['description'] ?? '') as String,
      grade: (row['grade'] ?? 'Class 3') as String,
      assignedDate: '30-Sep-2026',
      dueDate: (row['due_date'] ?? '01-Oct-2026') as String,
      teacherName: 'Farzana Begum',
      isCompleted: row['is_completed'] as bool? ?? false,
    );
  }

  SchoolNotice _mapNotice(Map<String, dynamic> row) {
    final rawDate = row['publish_date'] as String?;
    final dateStr = rawDate != null && rawDate.length >= 10
        ? rawDate.substring(0, 10)
        : '30-Sep-2026';

    return SchoolNotice(
      id: row['id'] as String,
      title: (row['title'] ?? 'Notice') as String,
      category: (row['category'] ?? 'General') as String,
      date: dateStr,
      summary: (row['content'] ?? '') as String,
      details: (row['content'] ?? '') as String,
      isImportant: true,
    );
  }

  FeeReceipt _mapFeeInvoice(Map<String, dynamic> row) {
    final amountDue = (row['amount_due'] as num? ?? 1200.0).toDouble();
    final statusStr = (row['status'] as String? ?? 'pending').toLowerCase();
    FeeStatus status = FeeStatus.pending;
    if (statusStr == 'paid') status = FeeStatus.paid;
    if (statusStr == 'overdue') status = FeeStatus.overdue;

    final studentInfo = row['students'] as Map<String, dynamic>?;

    return FeeReceipt(
      id: row['id'] as String,
      receiptNo: (row['invoice_no'] ?? 'INV-001') as String,
      studentId: (row['student_id'] ?? '') as String,
      studentName: (studentInfo?['name'] ?? 'Zaid Alam') as String,
      grade: (studentInfo?['grade'] ?? 'Class 3') as String,
      term: (row['fee_head'] ?? 'Monthly Tuition') as String,
      totalAmount: amountDue,
      paidAmount: status == FeeStatus.paid ? amountDue : 0.0,
      dueAmount: status == FeeStatus.paid ? 0.0 : amountDue,
      dueDate: (row['due_date'] ?? '10-Oct-2026') as String,
      status: status,
      paymentMode: 'Counter Cash / UPI',
    );
  }

  AdmissionInquiry _mapInquiry(Map<String, dynamic> row) {
    return AdmissionInquiry(
      id: row['id'] as String,
      referenceId: (row['reference_no'] ?? 'AQPS-000000') as String,
      studentName: (row['student_name'] ?? 'Applicant') as String,
      parentName: (row['parent_name'] ?? 'Parent') as String,
      grade: (row['grade_applying'] ?? 'Class 1') as String,
      mobile: (row['phone'] ?? '') as String,
      submissionDate:
          (row['created_at'] as String? ?? '30-Sep-2026').substring(0, 10),
      status: (row['status'] ?? 'New Enquiry') as String,
      message: (row['message'] ?? '') as String,
    );
  }

  TimetableSlot _mapTimetable(Map<String, dynamic> row) {
    return TimetableSlot(
      period: (row['period_no'] is int) ? row['period_no'] as int : 1,
      time: '${row['start_time'] ?? '08:00 AM'} - ${row['end_time'] ?? '08:45 AM'}',
      subject: (row['subject'] ?? 'Subject') as String,
      teacher: 'Farzana Begum',
      room: (row['room_no'] ?? 'Room 301') as String,
    );
  }

  // --------------------------------------------------------------------------
  // WEBSITE PHOTO GALLERY (Syncs directly with Next.js Website)
  // --------------------------------------------------------------------------

  static const List<SchoolGalleryItem> defaultGalleryItems = [
    SchoolGalleryItem(
      id: 'rotary-shiksha-ratna-award',
      title: 'Rotary Shiksha Ratna Samman Recognition',
      category: 'Achievements',
      src: '/images/school/achievements/rotary-shiksha-ratna-award.jpg',
      tag: 'State Honor',
      description: 'Director Kausar Jahan receiving the Rotary Shiksha Ratna Samman from Shri Nitish Kumar (Hon',
    ),
    SchoolGalleryItem(
      id: 'annual-exam-merit-shield',
      title: 'Annual Examination Merit Awards Ceremony',
      category: 'Achievements',
      src: '/images/school/achievements/annual-exam-merit-shield.jpg',
      tag: 'Merit Shield',
      description: 'Annual examination toppers recognized with academic merit shields and certificates for outstanding performance across all foundational subjects.',
    ),
    SchoolGalleryItem(
      id: 'annual-quiz-competition',
      title: 'Annual Quiz & Computer Competition',
      category: 'Activities',
      src: '/images/school/activities/annual-quiz-competition.jpg',
      tag: 'Academic Quiz',
      description: 'Students actively engaged in the school',
    ),
    SchoolGalleryItem(
      id: 'classroom-learning',
      title: 'Active Classroom Learning in Session',
      category: 'Classroom',
      src: '/images/school/classrooms/classroom-learning.jpg',
      tag: 'Foundational',
      description: 'Primary students seated with notebooks, attending structured foundational lessons in their official green plaid school uniforms.',
    ),
    SchoolGalleryItem(
      id: 'educational-tour-bapu-tower',
      title: 'Annual Educational Tour: Visit to Bapu Tower',
      category: 'Events',
      src: '/images/school/events/educational-tour-bapu-tower.jpg',
      tag: 'Study Excursion',
      description: 'Al-Qalam Public School students on a guided educational excursion to Bapu Tower in Patna, learning about Mahatma Gandhi',
    ),
    SchoolGalleryItem(
      id: 'star-student-trophy-ceremony',
      title: 'Star of Al-Qalam Trophy Presentation',
      category: 'Achievements',
      src: '/images/school/achievements/star-student-trophy-ceremony.jpg',
      tag: 'Star Achiever',
      description: 'Honoring distinguished student achievers with trophies and certificates for all-round excellence, integrity, and peer mentorship.',
    ),
    SchoolGalleryItem(
      id: 'annual-drawing-competition',
      title: 'Annual Drawing & Painting Exhibition',
      category: 'Activities',
      src: '/images/school/activities/annual-drawing-competition.jpg',
      tag: 'Creative Arts',
      description: 'Students proudly displaying their creative paintings and crayon artwork during the school',
    ),
    SchoolGalleryItem(
      id: 'educational-tour-eco-park',
      title: 'Nature & Environmental Tour: Eco Park',
      category: 'Events',
      src: '/images/school/events/educational-tour-eco-park.jpg',
      tag: 'Nature Tour',
      description: 'Students exploring Eco Park during the school',
    ),
    SchoolGalleryItem(
      id: 'writing-competition-winner',
      title: 'School Writing Competition Winner',
      category: 'Activities',
      src: '/images/school/activities/writing-competition-winner.jpg',
      tag: 'Penmanship',
      description: 'Student recognized with an award certificate for exemplary penmanship, neat handwriting, and language proficiency in the annual contest.',
    ),
    SchoolGalleryItem(
      id: 'quiz-participants',
      title: 'Quiz Round Participant Teams',
      category: 'Activities',
      src: '/images/school/activities/quiz-participants.jpg',
      tag: 'Student Teams',
      description: 'Student teams seated in classroom formation during the inter-class general knowledge and computer quiz rounds.',
    ),
    SchoolGalleryItem(
      id: 'annual-exam-merit-medal',
      title: 'Academic Excellence Medal Felicitation',
      category: 'Achievements',
      src: '/images/school/achievements/annual-exam-merit-medal.jpg',
      tag: 'Merit Medal',
      description: 'Class toppers receiving medals and honors during the school',
    ),
    SchoolGalleryItem(
      id: 'interactive-classroom-session',
      title: 'Interactive Classroom Study Dynamics',
      category: 'Classroom',
      src: '/images/school/classrooms/interactive-classroom-session.jpg',
      tag: 'Foundational',
      description: 'Interactive foundational class sessions encouraging peer learning, curiosity, and respectful classroom habits.',
    ),
    SchoolGalleryItem(
      id: 'school-building-hashmi-manzil',
      title: 'School Building & Entrance (Hashmi Manzil)',
      category: 'Campus',
      src: '/images/school/campus/school-building.png',
      tag: 'Campus Landmark',
      description: 'Exterior view of Al-Qalam Public School primary campus building (Hashmi Manzil) in Loharwa Ghat Lane, Alamganj, Patna-7.',
    ),
    SchoolGalleryItem(
      id: 'school-campus-exterior',
      title: 'School Campus Exterior & Courtyard',
      category: 'Campus',
      src: '/images/school/campus/school-campus-exterior.jpg',
      tag: 'Loharwa Ghat',
      description: 'Authentic exterior view of the school building located on Ashok Rajpath Road, opposite Jashn Palace, Gulzarbagh, Patna.',
    ),
    SchoolGalleryItem(
      id: 'school-gate-entrance-banner',
      title: 'School Entrance & Official Gate Banner',
      category: 'Campus',
      src: '/images/school/campus/school-gate-entrance-banner.jpg',
      tag: 'Main Gate',
      description: 'Official entrance banner displaying school registration, foundational curriculum details, and institutional contact guidance.',
    ),
    SchoolGalleryItem(
      id: 'independence-day-celebration',
      title: 'Independence Day Tricolor Flag Honors',
      category: 'Events',
      src: '/images/school/events/independence-day-celebration.jpg',
      tag: 'National Day',
      description: 'Students and staff celebrating Independence Day with patriotic songs, speeches, and flag honors in the campus courtyard.',
    ),
    SchoolGalleryItem(
      id: 'museum-educational-trip',
      title: 'Patna Museum Historical Excursion',
      category: 'Events',
      src: '/images/school/events/museum-educational-trip.jpg',
      tag: 'Heritage Trip',
      description: 'Students exploring historical artifacts, ancient coins, and state heritage exhibits at the Patna Museum.',
    ),
    SchoolGalleryItem(
      id: 'star-of-the-week-merit',
      title: 'Star of the Week Discipline & Merit Citation',
      category: 'Achievements',
      src: '/images/school/achievements/star-of-the-week-merit.jpg',
      tag: 'Weekly Merit',
      description: 'Weekly student merit recognition for punctuality, neat classroom work, and helpful behavior among classmates.',
    ),
    SchoolGalleryItem(
      id: 'student-academic-excellence',
      title: 'Academic Distinction Recognition',
      category: 'Achievements',
      src: '/images/school/achievements/student-academic-excellence.jpg',
      tag: 'Term Honors',
      description: 'Student proudly displaying a certificate of distinction for outstanding marks in term summative assessments.',
    ),
    SchoolGalleryItem(
      id: 'students-group-assembly',
      title: 'Morning Assembly & Unified Student Cohort',
      category: 'Campus',
      src: '/images/school/students/students-group-assembly.jpg',
      tag: 'Assembly',
      description: 'Students assembled in uniform for morning assembly, moral thought of the day, and national anthem.',
    ),
    SchoolGalleryItem(
      id: 'official-facebook-cover-banner',
      title: 'Official Institutional Visual & Motto',
      category: 'Campus',
      src: '/images/school/campus/official-facebook-cover-banner.jpg',
      tag: 'Emblem',
      description: 'Official institutional banner featuring the Al-Qalam school crest, foundational motto, and location details in Gulzarbagh.',
    ),
    SchoolGalleryItem(
      id: 'drawing-competition-session',
      title: 'Artistic Expression & Painting Session',
      category: 'Activities',
      src: '/images/school/activities/drawing-competition-session.jpg',
      tag: 'Creativity',
      description: 'Young artists expressing their imagination through color sketching and nature landscapes during the art competition.',
    ),
    SchoolGalleryItem(
      id: 'quiz-round-team-session',
      title: 'Rapid Fire Quiz & Logic Problem Solving',
      category: 'Activities',
      src: '/images/school/activities/quiz-round-team-session.jpg',
      tag: 'Logic Round',
      description: 'Students collaborating in teams during rapid-fire quiz rounds testing foundational math, science, and current events.',
    ),
    SchoolGalleryItem(
      id: 'quiz-stage-presentation',
      title: 'Quiz Finalists Stage Presentation',
      category: 'Activities',
      src: '/images/school/activities/quiz-stage-presentation.jpg',
      tag: 'Stage Final',
      description: 'Finalist teams presenting their answers before peers and teachers in the concluding round of the annual quiz contest.',
    ),
    SchoolGalleryItem(
      id: 'students-educational-excursion',
      title: 'Annual Educational Study Tour Cohort',
      category: 'Events',
      src: '/images/school/events/students-educational-excursion.jpg',
      tag: 'Annual Excursion',
      description: 'Students gathering outside excursion destination sites in Patna, accompanied by supervising teachers.',
    ),
    SchoolGalleryItem(
      id: 'smart-classes',
      title: 'Smart Class Audio-Visual Learning',
      category: 'Facilities',
      src: '/images/school/classrooms/classroom-learning.jpg',
      tag: 'Technology',
      description: 'Digital learning tools and audio-visual instructional methods that make foundational science and mathematics concepts intuitive.',
    ),
    SchoolGalleryItem(
      id: 'campus-safety-cctv',
      title: 'Monitored Safety & Campus Security',
      category: 'Facilities',
      src: '/images/school/campus/school-campus-exterior.jpg',
      tag: 'Security',
      description: '24/7 CCTV surveillance across campus gates, common corridors, and activity areas for comprehensive student safety.',
    ),
  ];

  /// Fetches live gallery photos from Supabase `gallery_items`.
  Future<List<SchoolGalleryItem>> fetchGalleryItems() async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return defaultGalleryItems;
    }

    try {
      final response = await client
          .from('gallery_items')
          .select()
          .eq('is_active', true)
          .order('created_at', ascending: false);

      final list = (response as List)
          .map((row) => SchoolGalleryItem.fromJson(row as Map<String, dynamic>))
          .toList();
      return list.isNotEmpty ? list : defaultGalleryItems;
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchGalleryItems fallback: $e');
      return defaultGalleryItems;
    }
  }

  /// Adds a new photo into Supabase `gallery_items` (instantly appears on website).
  Future<void> addGalleryItem(SchoolGalleryItem item) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('gallery_items').insert({
          'title': item.title,
          'category': item.category,
          'src': item.src,
          'tag': item.tag,
          'description': item.description,
          'is_active': true,
        });

        await SupabaseService.logAudit(
          action: 'ADD_GALLERY_PHOTO',
          entityType: 'gallery_items',
          metadata: {'title': item.title, 'category': item.category},
        );
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] addGalleryItem error: $e');
      }
    }
  }

  /// Deletes a photo from Supabase `gallery_items` (instantly removed from website).
  Future<void> deleteGalleryItem(String id) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('gallery_items').update({'is_active': false}).eq('id', id);

        await SupabaseService.logAudit(
          action: 'DELETE_GALLERY_PHOTO',
          entityType: 'gallery_items',
          entityId: id,
        );
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] deleteGalleryItem error: $e');
      }
    }
  }


  // --------------------------------------------------------------------------
  // TEACHERS MANAGEMENT
  // --------------------------------------------------------------------------

  Future<List<TeacherModel>> fetchTeachers() async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return [];
    }

    try {
      final response = await client
          .from('teachers')
          .select()
          .order('name', ascending: true);

      return (response as List).map((row) => TeacherModel.fromJson(row)).toList();
    } catch (e) {
      debugPrint('[SupabaseSchoolRepository] fetchTeachers error: $e');
      return [];
    }
  }

  Future<void> saveTeacher(TeacherModel teacher) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('teachers').upsert(teacher.toJson());
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] saveTeacher error: $e');
      }
    }
  }

  Future<void> deleteTeacher(String id) async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.from('teachers').delete().eq('id', id);
      } catch (e) {
        debugPrint('[SupabaseSchoolRepository] deleteTeacher error: $e');
      }
    }
  }
}
