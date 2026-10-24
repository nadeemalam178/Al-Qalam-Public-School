import 'website_management_screen.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/school_provider.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/stat_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/animated_entry.dart';
import 'fee_collection_screen.dart';
import 'post_notice_screen.dart';
import 'admission_leads_screen.dart';
import 'student_registry_screen.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final school = Provider.of<SchoolProvider>(context);
    final auth = Provider.of<AuthProvider>(context);
    final inquiries = school.inquiries;
    final newInquiryCount =
        inquiries.where((i) => i.status == 'New Enquiry').length;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Leadership Header (Frosted Glass)
          AnimatedEntry(
            delay: const Duration(milliseconds: 40),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.forestDeep.withValues(alpha: 0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 6),
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
                    child: Row(
                      children: [
                  Container(
                    width: 54,
                    height: 54,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      border: Border.all(color: AppTheme.goldPrimary, width: 2),
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/logo.png',
                        fit: BoxFit.contain,
                        errorBuilder: (_, __, ___) => const Icon(
                          Icons.account_balance,
                          color: AppTheme.forestPrimary,
                        ),
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
                          'Director & Administrator • Al-Qalam Campus',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: AppTheme.goldLight,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Session 2026-27 Management Console',
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
          ),
        ),
      ),
    ),
    const SizedBox(height: 18),

          // Operational 2x2 KPIs Grid
          AnimatedEntry(
            delay: const Duration(milliseconds: 120),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.16,
              children: [
                StatCard(
                  title: 'Total Students',
                  value: '${school.totalStudentCount}',
                  icon: Icons.school_rounded,
                  color: AppTheme.forestPrimary,
                  subtitle: 'Primary Wing',
                ),
                StatCard(
                  title: 'Fees Collected',
                  value: '₹${school.totalCollectedFees.toInt()}',
                  icon: Icons.account_balance_wallet_rounded,
                  color: const Color(0xFF10B981),
                  subtitle: 'Quarter 1-3',
                ),
                StatCard(
                  title: 'Pending Dues',
                  value: '₹${school.totalOutstandingFees.toInt()}',
                  icon: Icons.hourglass_top_rounded,
                  color: AppTheme.danger,
                  subtitle: 'Follow-up',
                ),
                StatCard(
                  title: 'Attendance Rate',
                  value: '${school.averageAttendanceRate.toStringAsFixed(1)}%',
                  icon: Icons.insights_rounded,
                  color: AppTheme.goldDark,
                  subtitle: 'Average',
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),

          // Admin Action Row
          AnimatedEntry(
            delay: const Duration(milliseconds: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionHeader(
                  title: 'Administrative Operations',
                  subtitle: 'Direct management controls',
                  icon: Icons.settings_suggest_rounded,
                ),
                const SizedBox(height: 10),

                // Featured Website CMS Control Card
                BounceTap(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const WebsiteManagementScreen()),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppTheme.forestDeep,
                          AppTheme.forestPrimary,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.forestPrimary.withValues(alpha: 0.28),
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Icon(Icons.language_rounded,
                              color: AppTheme.goldLight, size: 26),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Website CMS & Portal',
                                    style: GoogleFonts.outfit(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(width: 6),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 6, vertical: 2),
                                    decoration: BoxDecoration(
                                      color: AppTheme.goldPrimary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      'LIVE SYNC',
                                      style: GoogleFonts.inter(
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                        color: AppTheme.forestDeep,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Manage Gallery, Live Notices & Web Enquiries',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: Colors.white70,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios_rounded,
                            color: Colors.white70, size: 16),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: _buildAdminTile(
                        context,
                        title: 'Fee Collection',
                        subtitle: 'Record Payments',
                        icon: Icons.point_of_sale_rounded,
                        color: AppTheme.forestPrimary,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const FeeCollectionScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildAdminTile(
                        context,
                        title: 'Notice Broadcast',
                        subtitle: 'Publish Circular',
                        icon: Icons.campaign_rounded,
                        color: const Color(0xFF8B5CF6),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PostNoticeScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _buildAdminTile(
                        context,
                        title: 'Admission Leads',
                        subtitle: '$newInquiryCount New Inquiries',
                        icon: Icons.how_to_vote_rounded,
                        color: const Color(0xFFD4AF37),
                        badge: newInquiryCount > 0 ? '$newInquiryCount NEW' : null,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const AdmissionLeadsScreen()),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _buildAdminTile(
                        context,
                        title: 'Student Registry',
                        subtitle: 'Manage Directory',
                        icon: Icons.contact_emergency_rounded,
                        color: const Color(0xFF3B82F6),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const StudentRegistryScreen()),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Inbound Admission Inquiries Highlight
          AnimatedEntry(
            delay: const Duration(milliseconds: 280),
            child: SectionHeader(
              title: 'Inbound Admission Enquiries',
              actionText: 'View All (${inquiries.length})',
              onActionTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => const AdmissionLeadsScreen()),
              ),
              icon: Icons.mark_email_unread_outlined,
            ),
          ),
          const SizedBox(height: 6),
          ...inquiries.take(3).map((inq) {
            Color statusColor;
            if (inq.status == 'New Enquiry') {
              statusColor = AppTheme.goldDark;
            } else if (inq.status == 'Contacted') {
              statusColor = Colors.blue;
            } else {
              statusColor = AppTheme.forestPrimary;
            }

            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: statusColor.withValues(alpha: 0.12),
                  foregroundColor: statusColor,
                  child: const Icon(Icons.person_outline, size: 20),
                ),
                title: Text(
                  '${inq.studentName} (${inq.grade})',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                subtitle: Text(
                  'Parent: ${inq.parentName} • ${inq.mobile}\nRef: ${inq.referenceId}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: AppTheme.textMuted,
                  ),
                ),
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    inq.status,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ),
            );
          }),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildAdminTile(
    BuildContext context, {
    required String title,
    required String subtitle,
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
              padding: const EdgeInsets.all(14),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(icon, color: color, size: 20),
                      ),
                      if (badge != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
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
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: AppTheme.textMuted,
                    ),
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
