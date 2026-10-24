import '../models/gallery_item_model.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../models/student_model.dart';
import '../models/attendance_model.dart';
import '../models/fee_model.dart';
import '../models/homework_model.dart';
import '../models/exam_model.dart';
import '../models/notice_model.dart';
import '../models/admission_inquiry_model.dart';
import '../models/timetable_model.dart';
import '../models/teacher_model.dart';
import '../services/supabase_school_repository.dart';
import '../services/supabase_service.dart';

class SchoolProvider extends ChangeNotifier {
  final SupabaseSchoolRepository _repository;
  static const _storage = FlutterSecureStorage();

  SchoolProvider({SupabaseSchoolRepository? repository})
      : _repository = repository ?? const SupabaseSchoolRepository();

  List<Student> _students = [];
  List<AttendanceRecord> _attendance = [];
  List<FeeReceipt> _fees = [];
  List<HomeworkItem> _homework = [];
  List<SchoolNotice> _notices = [];
  List<AdmissionInquiry> _inquiries = [];
  final List<ExamReportCard> _reportCards = [];
  List<TimetableSlot> _timetable = [];
  List<TeacherModel> _teachers = [];
  List<SchoolGalleryItem> _galleryItems =
      List.from(SupabaseSchoolRepository.defaultGalleryItems);

  // Multi-Child / Sibling Support for Guardians
  List<Student> _linkedStudents = [];
  Student? _selectedStudent;

  bool _isLoading = false;
  bool _isRealtimeActive = false;
  StreamSubscription? _noticesSubscription;

  // Getters
  List<Student> get students => _students;
  List<AttendanceRecord> get attendance => _attendance;
  List<FeeReceipt> get fees => _fees;
  List<HomeworkItem> get homework => _homework;
  List<SchoolNotice> get notices => _notices;
  List<AdmissionInquiry> get inquiries => _inquiries;
  List<ExamReportCard> get reportCards => _reportCards;
  List<TimetableSlot> get timetable => _timetable;
  List<TeacherModel> get teachers => _teachers;
  List<SchoolGalleryItem> get galleryItems => _galleryItems;

  // Multi-Child Getters
  List<Student> get linkedStudents => _linkedStudents;
  Student get selectedStudent {
    if (_selectedStudent != null) return _selectedStudent!;
    if (_linkedStudents.isNotEmpty) return _linkedStudents.first;
    if (_students.isNotEmpty) return _students.first;
    return const Student(
      id: 'no-student',
      name: 'No Enrolled Student',
      admissionNo: 'AQPS-NONE',
      grade: 'General',
      section: 'A',
      rollNo: 0,
      fatherName: '',
      motherName: '',
      phone: '',
      address: '',
      dob: '',
      bloodGroup: '',
      attendanceRate: 100.0,
      pendingFees: 0.0,
    );
  }

  bool get isLoading => _isLoading;
  bool get isRealtimeActive => _isRealtimeActive;

  /// Switch the active child in Guardian Portal
  void selectChild(Student child) {
    _selectedStudent = child;
    notifyListeners();
  }

  /// Initialize and load real data from Supabase backend
  Future<void> loadInitialData({AppUser? user}) async {
    _isLoading = true;
    notifyListeners();

    try {
      // 1. Fetch Students
      _students = await _repository.fetchStudents();

      // 2. If parent, fetch linked children
      if (user != null && user.role == UserRole.parent) {
        _linkedStudents = await _repository.fetchLinkedChildren(user.id);
        if (_linkedStudents.isNotEmpty) {
          _selectedStudent = _linkedStudents.first;
        }
      }

      // 3. Fetch Notices (Shared with website)
      _notices = await _repository.fetchNotices(
        role: user?.role == UserRole.admin
            ? 'admin'
            : (user?.role == UserRole.teacher ? 'teacher' : 'guardian'),
      );

      // 4. Fetch Attendance & Homework & Fees & Inquiries
      _attendance = await _repository.fetchAttendance();
      _homework = await _repository.fetchHomework();
      _fees = await _repository.fetchFees();
      _inquiries = await _repository.fetchAdmissionInquiries();
      _timetable = await _repository.fetchTimetable();
      _galleryItems = await _repository.fetchGalleryItems();
      await fetchTeachers();

      // 5. Setup Realtime Sync for Notices & Circulars
      _setupRealtimeSync();
    } catch (e) {
      debugPrint('[SchoolProvider loadInitialData Error] $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _setupRealtimeSync() {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized || _isRealtimeActive) {
      return;
    }

    try {
      // Listen for newly broadcasted notices
      client
          .channel('public:notices')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'notices',
            callback: (payload) async {
              debugPrint('[Realtime Notice Event] received: ${payload.eventType}');
              final updated = await _repository.fetchNotices();
              _notices = updated;
              notifyListeners();
            },
          )
          .subscribe();

      // Listen for new admission enquiries submitted from the website
      client
          .channel('public:admission_enquiries')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'admission_enquiries',
            callback: (payload) async {
              debugPrint('[Realtime Admission Event] received: ${payload.eventType}');
              final updated = await _repository.fetchAdmissionInquiries();
              _inquiries = updated;
              notifyListeners();
            },
          )
          .subscribe();

      // Listen for website photo gallery changes
      client
          .channel('public:gallery_items')
          .onPostgresChanges(
            event: PostgresChangeEvent.all,
            schema: 'public',
            table: 'gallery_items',
            callback: (payload) async {
              final updated = await _repository.fetchGalleryItems();
              _galleryItems = updated;
              notifyListeners();
            },
          )
          .subscribe();

      _isRealtimeActive = true;
    } catch (e) {
      debugPrint('[Realtime Sync Init Error] $e');
    }
  }

  ExamReportCard? getReportCardForStudent(String studentId) {
    try {
      return _reportCards.firstWhere((r) => r.studentId == studentId);
    } catch (_) {
      return _reportCards.isNotEmpty ? _reportCards.first : null;
    }
  }

  // Teacher & Admin actions
  void toggleHomeworkCompletion(String id) {
    final index = _homework.indexWhere((h) => h.id == id);
    if (index != -1) {
      final current = _homework[index];
      final newStatus = !current.isCompleted;
      _homework[index] = current.copyWith(isCompleted: newStatus);
      notifyListeners();
      _repository.toggleHomeworkCompletion(id, newStatus);
    }
  }

  void addHomework(HomeworkItem item) {
    _homework.insert(0, item);
    notifyListeners();
    _repository.addHomework(item);
  }

  void markStudentAttendance({
    required String studentId,
    required String date,
    required AttendanceStatus status,
    String? remarks,
  }) {
    final existingIdx = _attendance.indexWhere(
      (a) => a.studentId == studentId && a.date == date,
    );
    if (existingIdx != -1) {
      _attendance[existingIdx] = AttendanceRecord(
        id: _attendance[existingIdx].id,
        studentId: studentId,
        date: date,
        status: status,
        remarks: remarks,
      );
    } else {
      _attendance.insert(
        0,
        AttendanceRecord(
          id: 'ATT-${DateTime.now().millisecondsSinceEpoch}',
          studentId: studentId,
          date: date,
          status: status,
          remarks: remarks,
        ),
      );
    }
    notifyListeners();
    _repository.markAttendance(
      studentId: studentId,
      date: date,
      status: status,
      remarks: remarks,
    );
  }

  void recordFeePayment({
    required String feeId,
    required double amountPaidNow,
    required String paymentMode,
  }) {
    final index = _fees.indexWhere((f) => f.id == feeId);
    if (index != -1) {
      final f = _fees[index];
      final newPaid = f.paidAmount + amountPaidNow;
      final newDue = (f.totalAmount - newPaid).clamp(0.0, f.totalAmount);
      final newStatus = newDue == 0 ? FeeStatus.paid : FeeStatus.pending;

      _fees[index] = FeeReceipt(
        id: f.id,
        receiptNo:
            'REC-AQPS-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
        studentId: f.studentId,
        studentName: f.studentName,
        grade: f.grade,
        term: f.term,
        totalAmount: f.totalAmount,
        paidAmount: newPaid,
        dueAmount: newDue,
        dueDate: f.dueDate,
        paidDate: '30-Sep-2026',
        status: newStatus,
        paymentMode: paymentMode,
      );

      final stuIdx = _students.indexWhere((s) => s.id == f.studentId);
      if (stuIdx != -1) {
        final stu = _students[stuIdx];
        _students[stuIdx] = Student(
          id: stu.id,
          admissionNo: stu.admissionNo,
          name: stu.name,
          grade: stu.grade,
          section: stu.section,
          rollNo: stu.rollNo,
          fatherName: stu.fatherName,
          motherName: stu.motherName,
          phone: stu.phone,
          address: stu.address,
          dob: stu.dob,
          bloodGroup: stu.bloodGroup,
          attendanceRate: stu.attendanceRate,
          pendingFees: newDue,
        );
      }

      notifyListeners();
      _repository.recordFeePayment(
        invoiceId: feeId,
        amountPaidNow: amountPaidNow,
        paymentMode: paymentMode,
      );
    }
  }

  Future<void> addGalleryPhoto(SchoolGalleryItem item) async {
    _galleryItems.insert(0, item);
    notifyListeners();
    await _repository.addGalleryItem(item);
  }

  Future<void> deleteGalleryPhoto(String id) async {
    _galleryItems.removeWhere((g) => g.id == id);
    notifyListeners();
    await _repository.deleteGalleryItem(id);
  }

  Future<void> deleteSchoolNotice(String id) async {
    _notices.removeWhere((n) => n.id == id);
    notifyListeners();
    await _repository.deleteNotice(id);
  }

  Future<void> refreshNotices() async {
    _notices = await _repository.fetchNotices();
    notifyListeners();
  }

  void broadcastNotice(SchoolNotice notice) {
    _notices.insert(0, notice);
    notifyListeners();
    _repository.broadcastNotice(notice);
  }

  Future<void> refreshInquiries() async {
    _inquiries = await _repository.fetchAdmissionInquiries();
    notifyListeners();
  }

  void submitAdmissionInquiry(AdmissionInquiry inquiry) {
    _inquiries.insert(0, inquiry);
    notifyListeners();
  }

  void updateInquiryStatus(String id, String newStatus) {
    final index = _inquiries.indexWhere((i) => i.id == id);
    if (index != -1) {
      _inquiries[index] = _inquiries[index].copyWith(status: newStatus);
      notifyListeners();
      _repository.updateInquiryStatus(id, newStatus);
    }
  }

  // --------------------------------------------------------------------------
  // TEACHER MANAGEMENT
  // --------------------------------------------------------------------------

  Future<void> fetchTeachers() async {
    try {
      final cloudList = await _repository.fetchTeachers();
      if (cloudList.isNotEmpty) {
        _teachers = cloudList;
      } else {
        // Check local persisted teachers
        final stored = await _storage.read(key: 'saved_teachers_cache');
        if (stored != null) {
          final List decoded = jsonDecode(stored);
          _teachers = decoded.map((e) => TeacherModel.fromJson(e)).toList();
        }
      }
    } catch (_) {}
    notifyListeners();
  }

  Future<void> addTeacher(TeacherModel teacher) async {
    _teachers.insert(0, teacher);
    notifyListeners();
    try {
      final jsonList = jsonEncode(_teachers.map((t) => t.toJson()).toList());
      await _storage.write(key: 'saved_teachers_cache', value: jsonList);
      await _repository.saveTeacher(teacher);
    } catch (_) {}
  }

  Future<void> updateTeacher(TeacherModel teacher) async {
    final idx = _teachers.indexWhere((t) => t.id == teacher.id);
    if (idx != -1) {
      _teachers[idx] = teacher;
      notifyListeners();
      try {
        final jsonList = jsonEncode(_teachers.map((t) => t.toJson()).toList());
        await _storage.write(key: 'saved_teachers_cache', value: jsonList);
        await _repository.saveTeacher(teacher);
      } catch (_) {}
    }
  }

  Future<void> deleteTeacher(String teacherId) async {
    _teachers.removeWhere((t) => t.id == teacherId);
    notifyListeners();
    try {
      final jsonList = jsonEncode(_teachers.map((t) => t.toJson()).toList());
      await _storage.write(key: 'saved_teachers_cache', value: jsonList);
      await _repository.deleteTeacher(teacherId);
    } catch (_) {}
  }

  // Dashboard Aggregates
  int get totalStudentCount => _students.length;
  double get totalCollectedFees =>
      _fees.fold(0.0, (acc, f) => acc + f.paidAmount);
  double get totalOutstandingFees =>
      _students.fold(0.0, (acc, s) => acc + s.pendingFees);
  double get averageAttendanceRate =>
      _students.fold(0.0, (acc, s) => acc + s.attendanceRate) /
      (_students.isEmpty ? 1 : _students.length);

  @override
  void dispose() {
    _noticesSubscription?.cancel();
    super.dispose();
  }
}
