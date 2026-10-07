import 'package:flutter_test/flutter_test.dart';
import 'package:al_qalam_school/models/student_model.dart';
import 'package:al_qalam_school/models/attendance_model.dart';
import 'package:al_qalam_school/models/notice_model.dart';
import 'package:al_qalam_school/models/user_model.dart';
import 'package:al_qalam_school/providers/school_provider.dart';

void main() {
  group('Supabase School Provider & Multi-Child Switcher Tests', () {
    late SchoolProvider schoolProvider;

    setUp(() {
      schoolProvider = SchoolProvider();
    });

    test('Initial state contains students and selectedStudent defaults to first child', () {
      expect(schoolProvider.students, isNotEmpty);
      expect(schoolProvider.selectedStudent.name, 'Zaid Alam');
      expect(schoolProvider.selectedStudent.grade, 'Class 3');
    });

    test('Guardian multi-child switcher updates selectedStudent reactively', () {
      const childOne = Student(
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
      );

      const childTwo = Student(
        id: 'STU-002-ZOYA',
        admissionNo: 'AQPS-2025-031',
        name: 'Zoya Alam',
        grade: 'Class 1',
        section: 'A',
        rollNo: 6,
        fatherName: 'Mohd. Tariq Alam',
        motherName: 'Shabana Khatoon',
        phone: '+91 98350 12450',
        address: 'Gulzarbagh Main Bazar, Patna - 800007',
        dob: '20-Nov-2019',
        bloodGroup: 'O+',
        attendanceRate: 98.0,
        pendingFees: 0.0,
      );

      // Default is child one
      expect(schoolProvider.selectedStudent.id, childOne.id);

      // Parent switches to sibling Zoya Alam
      schoolProvider.selectChild(childTwo);
      expect(schoolProvider.selectedStudent.id, 'STU-002-ZOYA');
      expect(schoolProvider.selectedStudent.name, 'Zoya Alam');
      expect(schoolProvider.selectedStudent.grade, 'Class 1');

      // Parent switches back to Zaid Alam
      schoolProvider.selectChild(childOne);
      expect(schoolProvider.selectedStudent.id, 'STU-001');
      expect(schoolProvider.selectedStudent.name, 'Zaid Alam');
    });

    test('Marking attendance records locally and updates list', () {
      final initialCount = schoolProvider.attendance.length;

      schoolProvider.markStudentAttendance(
        studentId: 'STU-001',
        date: '2026-10-01',
        status: AttendanceStatus.present,
        remarks: 'Present on time',
      );

      expect(schoolProvider.attendance.length, initialCount + 1);
      final recorded = schoolProvider.attendance.firstWhere(
        (a) => a.studentId == 'STU-001' && a.date == '2026-10-01',
      );
      expect(recorded.status, AttendanceStatus.present);
      expect(recorded.remarks, 'Present on time');
    });

    test('Broadcasting notice adds to school circulars', () {
      final initialNoticeCount = schoolProvider.notices.length;

      const newNotice = SchoolNotice(
        id: 'NTC-TEST-001',
        title: 'Sports Day Rehearsal Notice',
        category: 'Event',
        date: '30-Sep-2026',
        summary: 'All classes 1 to 5 report in sports uniform.',
        details: 'Full details of sports day schedule.',
        isImportant: true,
      );

      schoolProvider.broadcastNotice(newNotice);

      expect(schoolProvider.notices.length, initialNoticeCount + 1);
      expect(schoolProvider.notices.first.title, 'Sports Day Rehearsal Notice');
      expect(schoolProvider.notices.first.category, 'Event');
    });

    test('Fee payment recording updates invoice and dues', () {
      final initialFee = schoolProvider.fees.first;
      final initialDue = initialFee.dueAmount;

      schoolProvider.recordFeePayment(
        feeId: initialFee.id,
        amountPaidNow: 500.0,
        paymentMode: 'Cash',
      );

      final updatedFee = schoolProvider.fees.firstWhere((f) => f.id == initialFee.id);
      expect(updatedFee.paidAmount, initialFee.paidAmount + 500.0);
      expect(updatedFee.dueAmount, (initialDue - 500.0).clamp(0.0, initialFee.totalAmount));
    });

    test('Loading initial data for Guardian populates linked children', () async {
      const guardianUser = AppUser(
        id: 'USR-PARENT-01',
        name: 'Mohd. Tariq Alam',
        email: 'tariq.alam@gmail.com',
        phone: '+91 98350 12450',
        role: UserRole.parent,
        designation: 'Parent of Zaid & Zoya Alam',
      );

      await schoolProvider.loadInitialData(user: guardianUser);

      expect(schoolProvider.linkedStudents, isNotEmpty);
      expect(schoolProvider.selectedStudent, isNotNull);
    });
  });
}
