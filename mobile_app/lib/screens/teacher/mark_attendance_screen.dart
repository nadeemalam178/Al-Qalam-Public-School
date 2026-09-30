import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/attendance_model.dart';
import '../../theme/app_theme.dart';

class MarkAttendanceScreen extends StatefulWidget {
  const MarkAttendanceScreen({super.key});

  @override
  State<MarkAttendanceScreen> createState() => _MarkAttendanceScreenState();
}

class _MarkAttendanceScreenState extends State<MarkAttendanceScreen> {
  final Map<String, AttendanceStatus> _attendanceMap = {};
  final String _selectedDate = '2026-09-30';

  @override
  void initState() {
    super.initState();
    // Default all students to present initially
    final school = Provider.of<SchoolProvider>(context, listen: false);
    for (final student in school.students) {
      _attendanceMap[student.id] = AttendanceStatus.present;
    }
  }

  void _markAllPresent() {
    final school = Provider.of<SchoolProvider>(context, listen: false);
    setState(() {
      for (final student in school.students) {
        _attendanceMap[student.id] = AttendanceStatus.present;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final students = school.students;

    final presentCount = _attendanceMap.values
        .where((s) => s == AttendanceStatus.present)
        .length;
    final absentCount = _attendanceMap.values
        .where((s) => s == AttendanceStatus.absent)
        .length;
    final lateCount =
        _attendanceMap.values.where((s) => s == AttendanceStatus.late).length;

    return Scaffold(
      body: Column(
        children: [
          // Class & Date Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Class 3-A Register',
                      style: GoogleFonts.outfit(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.forestDeep,
                      ),
                    ),
                    Text(
                      'Date: $_selectedDate (Wednesday)',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                      ),
                    ),
                  ],
                ),
                TextButton.icon(
                  onPressed: _markAllPresent,
                  icon: const Icon(Icons.done_all,
                      size: 16, color: AppTheme.forestPrimary),
                  label: Text(
                    'Mark All Present',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.forestPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Count stats
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFF9FAFB),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildRegisterCounter('Present', '$presentCount', Colors.green),
                _buildRegisterCounter('Absent', '$absentCount', Colors.red),
                _buildRegisterCounter('Late', '$lateCount', Colors.amber[800]!),
              ],
            ),
          ),
          const Divider(height: 1),

          // Student roster list with P/A/L selectors
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                final currentStatus =
                    _attendanceMap[student.id] ?? AttendanceStatus.present;

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: AppTheme.forestTint,
                          child: Text(
                            '#${student.rollNo}',
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                student.name,
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                'Adm: ${student.admissionNo}',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Status Buttons
                        Row(
                          children: [
                            _buildStatusToggleButton(
                              student.id,
                              AttendanceStatus.present,
                              'P',
                              currentStatus == AttendanceStatus.present,
                              const Color(0xFF10B981),
                            ),
                            const SizedBox(width: 6),
                            _buildStatusToggleButton(
                              student.id,
                              AttendanceStatus.absent,
                              'A',
                              currentStatus == AttendanceStatus.absent,
                              const Color(0xFFEF4444),
                            ),
                            const SizedBox(width: 6),
                            _buildStatusToggleButton(
                              student.id,
                              AttendanceStatus.late,
                              'L',
                              currentStatus == AttendanceStatus.late,
                              const Color(0xFFF59E0B),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Submit Bottom Bar
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10,
                  offset: Offset(0, -2),
                ),
              ],
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  for (final entry in _attendanceMap.entries) {
                    school.markStudentAttendance(
                      studentId: entry.key,
                      date: _selectedDate,
                      status: entry.value,
                    );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Class 3-A Attendance for $_selectedDate recorded successfully!',
                        style: GoogleFonts.inter(),
                      ),
                      backgroundColor: AppTheme.forestPrimary,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                icon: const Icon(Icons.check_circle_outline, size: 20),
                label: const Text('Save & Submit Daily Register'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegisterCounter(String label, String count, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(
          '$label: ',
          style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted),
        ),
        Text(
          count,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusToggleButton(
    String studentId,
    AttendanceStatus status,
    String label,
    bool isSelected,
    Color color,
  ) {
    return InkWell(
      onTap: () {
        setState(() {
          _attendanceMap[studentId] = status;
        });
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 34,
        height: 34,
        decoration: BoxDecoration(
          color: isSelected ? color : color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : color,
            ),
          ),
        ),
      ),
    );
  }
}
