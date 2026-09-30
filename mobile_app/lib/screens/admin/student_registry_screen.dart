import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../models/student_model.dart';
import '../../theme/app_theme.dart';

class StudentRegistryScreen extends StatefulWidget {
  const StudentRegistryScreen({super.key});

  @override
  State<StudentRegistryScreen> createState() => _StudentRegistryScreenState();
}

class _StudentRegistryScreenState extends State<StudentRegistryScreen> {
  String _searchQuery = '';

  void _showStudentProfileModal(BuildContext context, Student student) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: AppTheme.forestTint,
                    child: Text(
                      '#${student.rollNo}',
                      style: GoogleFonts.outfit(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.forestDeep,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          student.name,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                        Text(
                          '${student.fullClass} • Adm: ${student.admissionNo}',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              const SizedBox(height: 8),
              _buildRow('Father Name:', student.fatherName),
              _buildRow('Mother Name:', student.motherName),
              _buildRow('Emergency Contact:', student.phone),
              _buildRow('Residential Address:', student.address),
              _buildRow('Date of Birth:', student.dob),
              _buildRow('Blood Group:', student.bloodGroup),
              _buildRow(
                  'Attendance Regularity:', '${student.attendanceRate}%'),
              _buildRow(
                'Fee Due Status:',
                student.pendingFees > 0
                    ? '₹${student.pendingFees.toInt()} Pending'
                    : 'All Dues Paid in Full',
                valueColor: student.pendingFees > 0
                    ? AppTheme.danger
                    : AppTheme.forestPrimary,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Calling parent ${student.fatherName} at ${student.phone}...',
                          style: GoogleFonts.inter(),
                        ),
                        backgroundColor: AppTheme.forestPrimary,
                      ),
                    );
                  },
                  icon: const Icon(Icons.call, size: 18),
                  label: const Text('Contact Parent / Guardian'),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  static Widget _buildRow(String label, String value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 12, color: AppTheme.textMuted),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: valueColor ?? AppTheme.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final students = school.students.where((s) {
      final q = _searchQuery.toLowerCase();
      return s.name.toLowerCase().contains(q) ||
          s.admissionNo.toLowerCase().contains(q) ||
          s.rollNo.toString().contains(q);
    }).toList();

    return Scaffold(
      body: Column(
        children: [
          // Search & Filter Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search registry by student name, roll or admission...',
                prefixIcon: const Icon(Icons.search, size: 20),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(color: AppTheme.borderLight),
                ),
              ),
              onChanged: (val) {
                setState(() {
                  _searchQuery = val;
                });
              },
            ),
          ),

          // Subtitle bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Registry: ${students.length} Enrolled Primary Students',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.textMuted,
                  ),
                ),
                Text(
                  'Al-Qalam Public School',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // Students list
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.forestTint,
                      foregroundColor: AppTheme.forestDeep,
                      child: Text(
                        '#${student.rollNo}',
                        style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      student.name,
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Text(
                      '${student.fullClass} • Adm: ${student.admissionNo}\nGuardian: ${student.fatherName}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppTheme.textMuted,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '${student.attendanceRate}%',
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestPrimary,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          student.pendingFees > 0
                              ? '₹${student.pendingFees.toInt()} Due'
                              : 'Clear',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: student.pendingFees > 0
                                ? AppTheme.danger
                                : AppTheme.forestPrimary,
                          ),
                        ),
                      ],
                    ),
                    onTap: () => _showStudentProfileModal(context, student),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
