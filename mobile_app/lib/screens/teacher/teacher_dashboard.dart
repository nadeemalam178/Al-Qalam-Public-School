import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/section_header.dart';
import 'mark_attendance_screen.dart';
import 'post_homework_screen.dart';
import 'student_roster_screen.dart';

class TeacherDashboardScreen extends StatelessWidget {
  const TeacherDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final students = school.students;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Faculty Welcome Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppTheme.forestDeep, AppTheme.forestPrimary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.forestDeep.withValues(alpha: 0.2),
                  blurRadius: 12,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: AppTheme.goldPrimary, width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person_pin,
                      size: 34,
                      color: AppTheme.forestPrimary,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        auth.currentUser.name,
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Class Teacher • ${auth.currentUser.classAssigned ?? "Class 3-A"}',
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: AppTheme.goldLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Total 6 Students Registered in Class',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.white60,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Key Stats
          Row(
            children: [
              Expanded(
                child: StatCard(
                  title: 'Enrolled',
                  value: '${students.length}',
                  icon: Icons.groups_rounded,
                  color: AppTheme.forestPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: StatCard(
                  title: 'Avg Regularity',
                  value:
                      '${school.averageAttendanceRate.toStringAsFixed(1)}%',
                  icon: Icons.how_to_reg_rounded,
                  color: const Color(0xFF10B981),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          // Quick Action Buttons
          const SectionHeader(
            title: 'Teacher Quick Actions',
            subtitle: 'Daily classroom administration',
            icon: Icons.bolt_rounded,
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: _buildTeacherActionTile(
                  context,
                  title: 'Mark Today Attendance',
                  subtitle: 'Daily Register',
                  icon: Icons.checklist_rtl_rounded,
                  color: AppTheme.forestPrimary,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const MarkAttendanceScreen()),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildTeacherActionTile(
                  context,
                  title: 'Assign Homework',
                  subtitle: 'Post to Class Diary',
                  icon: Icons.edit_calendar_rounded,
                  color: const Color(0xFFD4AF37),
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PostHomeworkScreen()),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Student List with Quick Parent Contact
          SectionHeader(
            title: 'Class 3-A Student Roster',
            actionText: 'View All (6)',
            onActionTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) => const StudentRosterScreen()),
            ),
            icon: Icons.badge_outlined,
          ),
          const SizedBox(height: 6),
          ...students.take(4).map((student) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: AppTheme.forestTint,
                  foregroundColor: AppTheme.forestDeep,
                  child: Text(
                    '#${student.rollNo}',
                    style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ),
                title: Text(
                  student.name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  'Guardian: ${student.fatherName} • ${student.phone}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.phone_in_talk_rounded,
                      color: AppTheme.forestPrimary),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Calling guardian ${student.fatherName} (${student.phone})...',
                          style: GoogleFonts.inter(),
                        ),
                        backgroundColor: AppTheme.forestPrimary,
                      ),
                    );
                  },
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTeacherActionTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFECEFF1)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 24),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textDark,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  color: AppTheme.textMuted,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
