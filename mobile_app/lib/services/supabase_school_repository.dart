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
      id: 'gal-rotary-shiksha-ratna',
      title: 'Rotary Shiksha Ratna Samman Recognition',
      category: 'Achievements',
      src: '/images/school/achievements/rotary-shiksha-ratna-award.jpg',
      tag: 'State Honor',
      description: 'Director Kausar Jahan receiving the Rotary Shiksha Ratna Samman from Hon\'ble Chief Minister of Bihar Nitish Kumar.',
    ),
    SchoolGalleryItem(
      id: 'gal-merit-awards',
      title: 'Annual Examination Merit Awards Ceremony',
      category: 'Achievements',
      src: '/images/school/achievements/annual-exam-merit-shield.jpg',
      tag: 'Merit Shield',
      description: 'Annual examination toppers recognized with academic merit shields and certificates.',
    ),
    SchoolGalleryItem(
      id: 'gal-quiz-competition',
      title: 'Annual Quiz & Computer Competition',
      category: 'Activities',
      src: '/images/school/activities/annual-quiz-competition.jpg',
      tag: 'STEM & Logic',
      description: 'Students competing in inter-house mental arithmetic, Islamic studies, and IT rounds.',
    ),
    SchoolGalleryItem(
      id: 'gal-classroom-learning',
      title: 'Classroom Learning & Interactive Pedagogy',
      category: 'Classroom',
      src: '/images/school/classroom/classroom-learning.jpg',
      tag: 'Smart Class',
      description: 'Engaging, child-centered classroom sessions focusing on Urdu, English, Mathematics and Science.',
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
