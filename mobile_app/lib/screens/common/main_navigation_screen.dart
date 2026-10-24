import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/glass_widgets.dart';
import '../auth/login_screen.dart';

// Parent Screens
import '../parent/parent_dashboard.dart';
import '../parent/attendance_screen.dart';
import '../parent/fees_screen.dart';
import '../parent/homework_screen.dart';
import '../parent/report_card_screen.dart';
import '../parent/timetable_screen.dart';

// Teacher Screens
import '../teacher/teacher_dashboard.dart';
import '../teacher/mark_attendance_screen.dart';
import '../teacher/post_homework_screen.dart';
import '../teacher/student_roster_screen.dart';

// Admin Screens
import '../admin/admission_leads_screen.dart';
import '../admin/teacher_management_screen.dart';
import '../admin/class_routine_screen.dart';
import '../admin/website_management_screen.dart';
import '../admin/parent_management_screen.dart';
import '../../services/app_update_service.dart';

// Common Screens
import 'notices_screen.dart';
import 'about_school_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AppUpdateService.autoCheckOnLaunch(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final role = auth.currentUser.role;

    List<Widget> screens;
    List<NavigationDestination> destinations;
    String screenTitle;

    switch (role) {
      case UserRole.parent:
        screens = [
          const ParentDashboardScreen(),
          const ParentAttendanceScreen(),
          const ParentFeesScreen(),
          const ParentHomeworkScreen(),
          const NoticesScreen(),
        ];
        destinations = const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home, color: AppTheme.forestPrimary),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_today_outlined),
            selectedIcon:
                Icon(Icons.calendar_today, color: AppTheme.forestPrimary),
            label: 'Attendance',
          ),
          NavigationDestination(
            icon: Icon(Icons.receipt_long_outlined),
            selectedIcon:
                Icon(Icons.receipt_long, color: AppTheme.forestPrimary),
            label: 'Fees',
          ),
          NavigationDestination(
            icon: Icon(Icons.menu_book_outlined),
            selectedIcon: Icon(Icons.menu_book, color: AppTheme.forestPrimary),
            label: 'Diary',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none_rounded),
            selectedIcon:
                Icon(Icons.notifications_rounded, color: AppTheme.forestPrimary),
            label: 'Notices',
          ),
        ];
        screenTitle = _getParentTitle(_currentIndex);
        break;

      case UserRole.teacher:
        screens = [
          const TeacherDashboardScreen(),
          const MarkAttendanceScreen(),
          const PostHomeworkScreen(),
          const StudentRosterScreen(),
          const NoticesScreen(),
        ];
        destinations = const [
          NavigationDestination(
            icon: Icon(Icons.dashboard_outlined),
            selectedIcon:
                Icon(Icons.dashboard, color: AppTheme.forestPrimary),
            label: 'Overview',
          ),
          NavigationDestination(
            icon: Icon(Icons.how_to_reg_outlined),
            selectedIcon:
                Icon(Icons.how_to_reg, color: AppTheme.forestPrimary),
            label: 'Attendance',
          ),
          NavigationDestination(
            icon: Icon(Icons.edit_note_outlined),
            selectedIcon:
                Icon(Icons.edit_note, color: AppTheme.forestPrimary),
            label: 'Homework',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people, color: AppTheme.forestPrimary),
            label: 'Students',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign, color: AppTheme.forestPrimary),
            label: 'Circulars',
          ),
        ];
        screenTitle = _getTeacherTitle(_currentIndex);
        break;

      case UserRole.admin:
        screens = [
          const AdmissionLeadsScreen(),
          const NoticesScreen(),
          const TeacherManagementScreen(),
          const ClassRoutineScreen(),
        ];
        destinations = const [
          NavigationDestination(
            icon: Icon(Icons.person_add_alt_1_outlined),
            selectedIcon: Icon(Icons.person_add_alt_1,
                color: AppTheme.forestPrimary),
            label: 'Admissions',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign, color: AppTheme.forestPrimary),
            label: 'Notices',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge, color: AppTheme.forestPrimary),
            label: 'Teachers',
          ),
          NavigationDestination(
            icon: Icon(Icons.schedule_outlined),
            selectedIcon: Icon(Icons.schedule, color: AppTheme.forestPrimary),
            label: 'Routine',
          ),
        ];
        screenTitle = _getAdminTitle(_currentIndex);
        break;
    }

    // Guard index bounds if role switched
    if (_currentIndex >= screens.length) {
      _currentIndex = 0;
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9F6),
      appBar: CustomSchoolAppBar(
        title: screenTitle,
        showProfileBadge: true,
      ),
      drawer: _buildAppDrawer(context, auth),
      body: AmbientGlassBackground(
        child: SafeArea(
          bottom: false,
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            },
            child: KeyedSubtree(
              key: ValueKey('${role.name}_$_currentIndex'),
              child: screens[_currentIndex],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.fromLTRB(14, 0, 14, 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          boxShadow: [
            BoxShadow(
              color: AppTheme.forestDeep.withValues(alpha: 0.12),
              blurRadius: 24,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(28),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.6),
                  width: 1.5,
                ),
              ),
              child: NavigationBarTheme(
                data: NavigationBarThemeData(
                  indicatorColor: AppTheme.forestTint,
                  elevation: 0,
                  backgroundColor: Colors.transparent,
                  labelTextStyle: WidgetStateProperty.resolveWith((states) {
                    final selected = states.contains(WidgetState.selected);
                    return GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                      color: selected
                          ? AppTheme.forestPrimary
                          : AppTheme.textMuted,
                    );
                  }),
                ),
                child: NavigationBar(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (idx) {
                    setState(() => _currentIndex = idx);
                  },
                  destinations: destinations,
                  height: 64,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getParentTitle(int index) {
    switch (index) {
      case 0:
        return 'Guardian Portal';
      case 1:
        return 'Attendance Tracker';
      case 2:
        return 'Fee Receipts';
      case 3:
        return 'Daily Homework';
      case 4:
        return 'School Circulars';
      default:
        return 'Al-Qalam School';
    }
  }

  String _getTeacherTitle(int index) {
    switch (index) {
      case 0:
        return 'Faculty Desk';
      case 1:
        return 'Roll Call';
      case 2:
        return 'Homework Diary';
      case 3:
        return 'Student Directory';
      case 4:
        return 'Staff Notices';
      default:
        return 'Teacher Console';
    }
  }

  String _getAdminTitle(int index) {
    switch (index) {
      case 0:
        return 'Admission Enquiries';
      case 1:
        return 'School Notices';
      case 2:
        return 'Faculty & Teachers';
      case 3:
        return 'Class Routine';
      default:
        return 'Administrator';
    }
  }

  Widget _buildAppDrawer(BuildContext context, AuthProvider auth) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(16, 52, 16, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.forestDeep,
                  AppTheme.forestPrimary,
                ],
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppTheme.goldPrimary,
                  child: Text(
                    auth.currentUser.name.isNotEmpty
                        ? auth.currentUser.name[0]
                        : 'A',
                    style: GoogleFonts.outfit(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.forestDeep,
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        auth.currentUser.name,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.goldPrimary.withValues(alpha: 0.25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          auth.currentUser.roleDisplayName,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: AppTheme.goldPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: [
                if (auth.isAdmin) ...[
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppTheme.forestPrimary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.add_photo_alternate_rounded,
                          color: AppTheme.forestPrimary, size: 20),
                    ),
                    title: Row(
                      children: [
                        Text('Website Gallery (Photos)',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: AppTheme.goldPrimary,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'SYNC',
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                        'Upload & remove photos on live school website',
                        style: GoogleFonts.inter(
                            fontSize: 11, color: AppTheme.textMuted)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const WebsiteManagementScreen()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(7),
                      decoration: BoxDecoration(
                        color: AppTheme.forestPrimary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.family_restroom_rounded,
                          color: AppTheme.forestPrimary, size: 20),
                    ),
                    title: Row(
                      children: [
                        Text('Parent & Guardian Logins',
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600, fontSize: 13)),
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1.5),
                          decoration: BoxDecoration(
                            color: const Color(0xFF25D366),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'PORTAL',
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                        'Create guardian login IDs, passwords & WhatsApp sharing',
                        style: GoogleFonts.inter(
                            fontSize: 11, color: AppTheme.textMuted)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const ParentManagementScreen()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.system_update_rounded,
                        color: AppTheme.forestPrimary),
                    title: Text('Check for Updates (OTA)',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                    subtitle: Text('Current v1.3.0 • Auto-check enabled',
                        style: GoogleFonts.inter(
                            fontSize: 11, color: AppTheme.textMuted)),
                    trailing: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.forestTint,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'OTA',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.forestPrimary,
                        ),
                      ),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                      AppUpdateService.checkFromDrawer(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.switch_account_outlined,
                        color: AppTheme.forestPrimary),
                    title: Text('Switch Role / Re-Login',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                    subtitle: Text('Switch to Teacher or Parent account',
                        style: GoogleFonts.inter(
                            fontSize: 11, color: AppTheme.textMuted)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_rounded,
                        color: Colors.redAccent),
                    title: Text('Sign Out Administrator',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent)),
                    onTap: () {
                      Navigator.pop(context);
                      auth.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                ] else ...[
                  ListTile(
                    leading: const Icon(Icons.school_outlined,
                        color: AppTheme.forestPrimary),
                    title: Text('About Al-Qalam Campus',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const AboutSchoolScreen()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.system_update_rounded,
                        color: AppTheme.forestPrimary),
                    title: Text('Check for Updates (OTA)',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                      AppUpdateService.checkFromDrawer(context);
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: const Icon(Icons.logout_rounded,
                        color: Colors.redAccent),
                    title: Text('Sign Out',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: Colors.redAccent)),
                    onTap: () {
                      Navigator.pop(context);
                      auth.signOut();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const LoginScreen()),
                      );
                    },
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
