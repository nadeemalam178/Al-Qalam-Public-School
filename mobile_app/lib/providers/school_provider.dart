import 'package:flutter/foundation.dart';
import '../models/student_model.dart';
import '../models/attendance_model.dart';
import '../models/fee_model.dart';
import '../models/homework_model.dart';
import '../models/exam_model.dart';
import '../models/notice_model.dart';
import '../models/admission_inquiry_model.dart';
import '../services/school_data_repository.dart';

class SchoolProvider extends ChangeNotifier {
  final List<Student> _students = List.from(SchoolDataRepository.initialStudents);
  final List<AttendanceRecord> _attendance =
      List.from(SchoolDataRepository.initialAttendance);
  final List<FeeReceipt> _fees = List.from(SchoolDataRepository.initialFees);
  final List<HomeworkItem> _homework = List.from(SchoolDataRepository.initialHomework);
  final List<SchoolNotice> _notices = List.from(SchoolDataRepository.initialNotices);
  final List<AdmissionInquiry> _inquiries =
      List.from(SchoolDataRepository.initialInquiries);
  final List<ExamReportCard> _reportCards =
      List.from(SchoolDataRepository.initialReportCards);

  // Getters
  List<Student> get students => _students;
  List<AttendanceRecord> get attendance => _attendance;
  List<FeeReceipt> get fees => _fees;
  List<HomeworkItem> get homework => _homework;
  List<SchoolNotice> get notices => _notices;
  List<AdmissionInquiry> get inquiries => _inquiries;
  List<ExamReportCard> get reportCards => _reportCards;

  // Student specific queries
  Student getStudentById(String id) {
    return _students.firstWhere(
      (s) => s.id == id,
      orElse: () => _students.first,
    );
  }

  List<AttendanceRecord> getAttendanceForStudent(String studentId) {
    return _attendance.where((a) => a.studentId == studentId).toList();
  }

  List<FeeReceipt> getFeesForStudent(String studentId) {
    return _fees.where((f) => f.studentId == studentId).toList();
  }

  List<HomeworkItem> getHomeworkForGrade(String grade) {
    return _homework.where((h) => h.grade.contains(grade)).toList();
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
      _homework[index] = current.copyWith(isCompleted: !current.isCompleted);
      notifyListeners();
    }
  }

  void addHomework(HomeworkItem item) {
    _homework.insert(0, item);
    notifyListeners();
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
        receiptNo: 'REC-AQPS-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
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

      // Also update student pending fees
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
    }
  }

  void broadcastNotice(SchoolNotice notice) {
    _notices.insert(0, notice);
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
    }
  }

  // Dashboard Aggregates
  int get totalStudentCount => _students.length;
  double get totalCollectedFees => _fees.fold(0.0, (acc, f) => acc + f.paidAmount);
  double get totalOutstandingFees =>
      _students.fold(0.0, (acc, s) => acc + s.pendingFees);
  double get averageAttendanceRate =>
      _students.fold(0.0, (acc, s) => acc + s.attendanceRate) /
      (_students.isEmpty ? 1 : _students.length);
}
