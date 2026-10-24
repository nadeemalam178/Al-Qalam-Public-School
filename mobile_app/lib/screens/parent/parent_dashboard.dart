import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../providers/school_provider.dart';
import '../../theme/app_theme.dart';
import '../../services/school_data_repository.dart';
import '../../widgets/section_header.dart';
import '../../widgets/animated_entry.dart';
import '../../widgets/glass_widgets.dart';
import 'attendance_screen.dart';
import 'fees_screen.dart';
import 'homework_screen.dart';
import 'report_card_screen.dart';
import 'timetable_screen.dart';
import '../common/notices_screen.dart';
import '../common/about_school_screen.dart';

class ParentDashboardScreen extends StatelessWidget {
  const ParentDashboardScreen({super.key});

  Future<void> _callDesk(BuildContext context) async {
    final cleanPhone = SchoolDataRepository.schoolPhone.replaceAll(RegExp(r'[^0-9+]'), '');
    final uri = Uri.parse('tel:$cleanPhone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Could not initiate call to $cleanPhone'),
            backgroundColor: AppTheme.forestPrimary,
          ),
        );
      }
    }
  }

  Future<void> _chatDeskWhatsApp(BuildContext context, String studentName, String grade) async {
    final cleanPhone = SchoolDataRepository.schoolPhone.replaceAll(RegExp(r'[^0-9]'), '');
    final text = Uri.encodeComponent(
      'Hello Al-Qalam Campus Desk, I am the parent of $studentName ($grade). I have an inquiry regarding my ward.',
    );
    final uri = Uri.parse('https://wa.me/$cleanPhone?text=$text');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open WhatsApp on this device.'),
            backgroundColor: AppTheme.forestPrimary,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final student = school.selectedStudent;
    final studentHomework = school.getHomeworkForGrade(student.grade);
    final activeHwCount =
        studentHomework.where((h) => !h.isCompleted).length;
    final latestNotice =
        school.notices.isNotEmpty ? school.notices.first : null;
    final linkedStudents = school.linkedStudents;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Multi-Child Switcher (When guardian has multiple enrolled wards)
          if (linkedStudents.length > 1) ...[
            AnimatedEntry(
              delay: const Duration(milliseconds: 20),
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppTheme.forestTint,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppTheme.forestPrimary.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.family_restroom_rounded,
                      size: 20,
                      color: AppTheme.forestPrimary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Select Child:',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.forestDeep,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Row(
                          children: linkedStudents.map((child) {
                            final isSelected = child.id == student.id;
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: ChoiceChip(
                                label: Text(
                                  '${child.name} (${child.grade})',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.white
                                        : AppTheme.textDark,
                                  ),
                                ),
                                selected: isSelected,
                                selectedColor: AppTheme.forestPrimary,
                                backgroundColor: Colors.white,
                                showCheckmark: false,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: BorderSide(
                                    color: isSelected
                                        ? AppTheme.forestPrimary
                                        : AppTheme.borderLight,
                                  ),
                                ),
                                onSelected: (_) {
                                  school.selectChild(child);
                                },
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],

          // Student ID Profile Card (Frosted Glass)
          AnimatedEntry(
            delay: const Duration(milliseconds: 40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.forestDeep.withValues(alpha: 0.25),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(22),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                  child: Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.forestDeep.withValues(alpha: 0.88),
                          AppTheme.forestPrimary.withValues(alpha: 0.82),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.22),
                        width: 1.2,
                      ),
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
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),

          // Direct Campus Desk & WhatsApp Quick Bar
          AnimatedEntry(
            delay: const Duration(milliseconds: 80),
            child: GlassCard(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              accentColor: AppTheme.forestPrimary,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.forestTint,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(
                      Icons.support_agent_rounded,
                      color: AppTheme.forestPrimary,
                      size: 22,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Campus Office Desk',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.forestDeep,
                          ),
                        ),
                        Text(
                          'Gulzarbagh • 8:30 AM - 1:30 PM',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppTheme.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () => _callDesk(context),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.forestTint,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppTheme.forestPrimary.withValues(alpha: 0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.phone, size: 14, color: AppTheme.forestPrimary),
                          const SizedBox(width: 4),
                          Text(
                            'Call',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  InkWell(
                    onTap: () => _chatDeskWhatsApp(context, student.name, student.fullClass),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCFCE7),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFF22C55E).withValues(alpha: 0.4)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.chat_bubble_outline, size: 14, color: Color(0xFF16A34A)),
                          const SizedBox(width: 4),
                          Text(
                            'WhatsApp',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF16A34A),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Daily Moral Value / Hadith Card
          AnimatedEntry(
            delay: const Duration(milliseconds: 110),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFFFFBEB),
                    Colors.white,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.goldPrimary.withValues(alpha: 0.35)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppTheme.goldLight,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.lightbulb_outline, color: AppTheme.goldDark, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Moral Thought of the Day',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.goldDark,
                            letterSpacing: 0.5,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          '“Seeking knowledge is an obligation upon every individual. Strive for discipline, respect, and curiosity.”',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: AppTheme.textDark,
                            height: 1.35,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),

          // Quick Action Navigation Grid
          AnimatedEntry(
            delay: const Duration(milliseconds: 140),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  childAspectRatio: 0.88,
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
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Daily Diary Highlight
          AnimatedEntry(
            delay: const Duration(milliseconds: 220),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                  return BounceTap(
                    onTap: () {
                      school.toggleHomeworkCompletion(hw.id);
                    },
                    child: Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      elevation: 0.5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                        side: BorderSide(
                          color: hw.isCompleted
                              ? AppTheme.forestPrimary.withValues(alpha: 0.2)
                              : Colors.grey.shade200,
                        ),
                      ),
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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          onChanged: (_) {
                            school.toggleHomeworkCompletion(hw.id);
                          },
                        ),
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),

          // Recent Notice Card
          if (latestNotice != null) ...[
            AnimatedEntry(
              delay: const Duration(milliseconds: 300),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  BounceTap(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NoticesScreen(),
                      ),
                    ),
                    child: Container(
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
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 80),
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
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: GoogleFonts.outfit(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 10,
            color: Colors.white60,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
    final r = BorderRadius.circular(18);

    return BounceTap(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: r,
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.08),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: r,
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.78),
                borderRadius: r,
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.85),
                  width: 1.2,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withValues(alpha: 0.85),
                    color.withValues(alpha: 0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
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
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.goldPrimary.withValues(alpha: 0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
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
                      fontWeight: FontWeight.bold,
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
        ),
      ),
    );
  }
}
