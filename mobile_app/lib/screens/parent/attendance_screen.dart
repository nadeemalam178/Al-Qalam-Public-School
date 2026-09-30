import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/attendance_model.dart';
import '../../theme/app_theme.dart';

class ParentAttendanceScreen extends StatefulWidget {
  const ParentAttendanceScreen({super.key});

  @override
  State<ParentAttendanceScreen> createState() => _ParentAttendanceScreenState();
}

class _ParentAttendanceScreenState extends State<ParentAttendanceScreen> {
  String _selectedFilter = 'All';

  void _showApplyLeaveDialog(BuildContext context) {
    final reasonController = TextEditingController();
    final dateController = TextEditingController(text: '02-Oct-2026 to 03-Oct-2026');

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppTheme.forestTint,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.event_note, color: AppTheme.forestPrimary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Apply Leave',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppTheme.forestDeep,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Submit leave application for Zaid Alam (Class 3-A) directly to Class Teacher Farzana Begum.',
                  style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Leave Dates',
                    prefixIcon: Icon(Icons.calendar_today, size: 18),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: reasonController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Reason for Leave',
                    hintText: 'e.g. Mild fever, family event, out of town',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Leave request submitted for approval to Class Teacher.',
                      style: GoogleFonts.inter(),
                    ),
                    backgroundColor: AppTheme.forestPrimary,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Submit Application'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final student = school.getStudentById('STU-001');
    final attendanceRecords = school.getAttendanceForStudent(student.id);

    final presentCount = attendanceRecords
        .where((a) => a.status == AttendanceStatus.present)
        .length;
    final absentCount = attendanceRecords
        .where((a) => a.status == AttendanceStatus.absent)
        .length;
    final lateCount = attendanceRecords
        .where((a) => a.status == AttendanceStatus.late)
        .length;

    final filteredRecords = attendanceRecords.where((a) {
      if (_selectedFilter == 'Present') return a.status == AttendanceStatus.present;
      if (_selectedFilter == 'Absent') return a.status == AttendanceStatus.absent;
      if (_selectedFilter == 'Late') return a.status == AttendanceStatus.late;
      return true;
    }).toList();

    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Month Header & Overview
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFFECEFF1)),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.forestDeep.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'September 2026',
                              style: GoogleFonts.outfit(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.forestDeep,
                              ),
                            ),
                            Text(
                              'Academic Year 2026-27',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                color: AppTheme.textMuted,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppTheme.forestTint,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${student.attendanceRate.toStringAsFixed(1)}% Regularity',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildAttendanceCountBadge(
                          'Present',
                          '$presentCount Days',
                          const Color(0xFF10B981),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildAttendanceCountBadge(
                          'Absent',
                          '$absentCount Day',
                          const Color(0xFFEF4444),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: _buildAttendanceCountBadge(
                          'Late',
                          '$lateCount Day',
                          const Color(0xFFF59E0B),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action: Apply for leave button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: () => _showApplyLeaveDialog(context),
                icon: const Icon(Icons.note_alt_outlined),
                label: const Text('Apply for Leave to Class Teacher'),
              ),
            ),
            const SizedBox(height: 18),

            // Filter Chips
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip('All'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Present'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Absent'),
                  const SizedBox(width: 8),
                  _buildFilterChip('Late'),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Attendance Records Timeline
            ...filteredRecords.map((rec) {
              Color statusColor;
              IconData statusIcon;

              switch (rec.status) {
                case AttendanceStatus.present:
                  statusColor = const Color(0xFF10B981);
                  statusIcon = Icons.check_circle_rounded;
                  break;
                case AttendanceStatus.absent:
                  statusColor = const Color(0xFFEF4444);
                  statusIcon = Icons.cancel_rounded;
                  break;
                case AttendanceStatus.late:
                  statusColor = const Color(0xFFF59E0B);
                  statusIcon = Icons.access_time_filled_rounded;
                  break;
                case AttendanceStatus.holiday:
                  statusColor = const Color(0xFF3B82F6);
                  statusIcon = Icons.beach_access_rounded;
                  break;
              }

              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(statusIcon, color: statusColor, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rec.date,
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.textDark,
                              ),
                            ),
                            if (rec.remarks != null)
                              Text(
                                rec.remarks!,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppTheme.textMuted,
                                ),
                              ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          rec.label,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: statusColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildAttendanceCountBadge(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              color: AppTheme.textMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppTheme.forestPrimary,
      backgroundColor: Colors.white,
      labelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: isSelected ? Colors.white : AppTheme.textDark,
      ),
      onSelected: (_) {
        setState(() {
          _selectedFilter = label;
        });
      },
    );
  }
}
