import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/section_header.dart';
import 'attendance_screen.dart';
import 'fees_screen.dart';
import 'homework_screen.dart';
import 'report_card_screen.dart';
import 'timetable_screen.dart';
import '../common/notices_screen.dart';
import '../common/about_school_screen.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final student = school.getStudentById('STU-001'); // Zaid Alam
    final studentHomework = school.getHomeworkForGrade(student.grade);
    final activeHwCount =
        studentHomework.where((h) => !h.isCompleted).length;
    final latestNotice =
        school.notices.isNotEmpty ? school.notices.first : null;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Student ID Profile Card
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
                  color: AppTheme.forestDeep.withValues(alpha: 0.25),
                  blurRadius: 16,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 58,
                      height: 58,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border: Border.all(
                          color: AppTheme.goldPrimary,
                          width: 2.5,
                        ),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.face_rounded,
                          size: 38,
                          color: AppTheme.forestPrimary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  student.name,
                                  style: GoogleFonts.outfit(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.goldPrimary,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Roll #${student.rollNo}',
                                  style: GoogleFonts.inter(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.forestDeep,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            student.fullClass,
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppTheme.forestSoft,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Adm: ${student.admissionNo}',
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
                const SizedBox(height: 16),
                const Divider(color: Colors.white12, height: 1),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStudentMiniStat(
                      'Attendance',
                      '${student.attendanceRate.toStringAsFixed(1)}%',
                      Icons.check_circle_outline,
                      Colors.greenAccent,
                    ),
                    _buildStudentMiniStat(
                      'Blood Group',
                      student.bloodGroup,
                      Icons.favorite_outline,
                      Colors.pinkAccent,
                    ),
                    _buildStudentMiniStat(
                      'Pending Fees',
                      student.pendingFees > 0
                          ? '₹${student.pendingFees.toInt()}'
                          : 'Clear',
                      Icons.receipt_outlined,
                      student.pendingFees > 0
                          ? AppTheme.goldPrimary
                          : Colors.greenAccent,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Quick Action Navigation Grid
          const SectionHeader(
            title: 'School Services',
            subtitle: 'Key modules for parent monitoring',
            icon: Icons.grid_view_rounded,
          ),
          const SizedBox(height: 6),
          GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 0.95,
            children: [
              _buildServiceButton(
                context,
                title: 'Attendance',
                icon: Icons.calendar_month_rounded,
                color: const Color(0xFF10B981),
                badge: '${student.attendanceRate.toInt()}%',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ParentAttendanceScreen(),
                  ),
                ),
              ),
              _buildServiceButton(
                context,
                title: 'Fee Dues',
                icon: Icons.receipt_long_rounded,
                color: const Color(0xFFD4AF37),
                badge: student.pendingFees > 0
                    ? '₹${student.pendingFees.toInt()}'
                    : null,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ParentFeesScreen()),
                ),
              ),
              _buildServiceButton(
                context,
                title: 'Diary/HW',
                icon: Icons.menu_book_rounded,
                color: const Color(0xFF3B82F6),
                badge: activeHwCount > 0 ? '$activeHwCount Tasks' : null,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ParentHomeworkScreen(),
                  ),
                ),
              ),
              _buildServiceButton(
                context,
                title: 'Report Card',
                icon: Icons.military_tech_rounded,
                color: const Color(0xFF8B5CF6),
                badge: 'Rank #3',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const ReportCardScreen(),
                  ),
                ),
              ),
              _buildServiceButton(
                context,
                title: 'Timetable',
                icon: Icons.schedule_rounded,
                color: const Color(0xFFEC4899),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const TimetableScreen(),
                  ),
                ),
              ),
              _buildServiceButton(
                context,
                title: 'Campus Info',
                icon: Icons.info_outline_rounded,
                color: AppTheme.forestPrimary,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const AboutSchoolScreen(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Daily Diary Highlight
          SectionHeader(
            title: 'Active Homework Tasks',
            actionText: 'View All',
            onActionTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const ParentHomeworkScreen(),
              ),
            ),
            icon: Icons.assignment_outlined,
          ),
          const SizedBox(height: 6),
          ...studentHomework.take(2).map((hw) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: hw.isCompleted
                        ? AppTheme.forestTint
                        : const Color(0xFFFFF7DC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    hw.isCompleted
                        ? Icons.check_circle_outline
                        : Icons.pending_actions_rounded,
                    color: hw.isCompleted
                        ? AppTheme.forestPrimary
                        : AppTheme.goldDark,
                  ),
                ),
                title: Text(
                  hw.title,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '${hw.subject} • Due: ${hw.dueDate}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
                trailing: Checkbox(
                  value: hw.isCompleted,
                  activeColor: AppTheme.forestPrimary,
                  onChanged: (_) {
                    school.toggleHomeworkCompletion(hw.id);
                  },
                ),
              ),
            );
          }),
          const SizedBox(height: 16),

          // Recent Notice Card
          if (latestNotice != null) ...[
            SectionHeader(
              title: 'Important School Circular',
              actionText: 'All Notices',
              onActionTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NoticesScreen(),
                ),
              ),
              icon: Icons.campaign_outlined,
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: latestNotice.isImportant
                      ? AppTheme.goldPrimary.withValues(alpha: 0.5)
                      : const Color(0xFFECEFF1),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.forestDeep.withValues(alpha: 0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.forestTint,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          latestNotice.category,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                      ),
                      Text(
                        latestNotice.date,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: AppTheme.textMuted,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    latestNotice.title,
                    style: GoogleFonts.outfit(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.forestDeep,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    latestNotice.summary,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      color: AppTheme.textDark,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildStudentMiniStat(
      String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Colors.white60,
          ),
        ),
      ],
    );
  }

  Widget _buildServiceButton(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    String? badge,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFECEFF1)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.12),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(icon, color: color, size: 22),
                  ),
                  if (badge != null)
                    Positioned(
                      top: -4,
                      right: -8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.goldPrimary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          badge,
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.textDark,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
