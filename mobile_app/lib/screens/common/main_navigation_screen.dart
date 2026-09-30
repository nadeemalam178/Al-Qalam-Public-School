import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../providers/auth_provider.dart';
import '../../models/user_model.dart';
import '../../theme/app_theme.dart';
import '../../widgets/custom_app_bar.dart';

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
import '../admin/admin_dashboard.dart';
import '../admin/fee_collection_screen.dart';
import '../admin/post_notice_screen.dart';
import '../admin/admission_leads_screen.dart';
import '../admin/student_registry_screen.dart';

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
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);
    final role = auth.currentRole;

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
                Icon(Icons.calendar_month, color: AppTheme.forestPrimary),
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
          const AdminDashboardScreen(),
          const FeeCollectionScreen(),
          const AdmissionLeadsScreen(),
          const StudentRegistryScreen(),
          const NoticesScreen(),
        ];
        destinations = const [
          NavigationDestination(
            icon: Icon(Icons.analytics_outlined),
            selectedIcon:
                Icon(Icons.analytics, color: AppTheme.forestPrimary),
            label: 'Admin Hub',
          ),
          NavigationDestination(
            icon: Icon(Icons.account_balance_wallet_outlined),
            selectedIcon: Icon(Icons.account_balance_wallet,
                color: AppTheme.forestPrimary),
            label: 'Finance',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_add_alt_1_outlined),
            selectedIcon: Icon(Icons.person_add_alt_1,
                color: AppTheme.forestPrimary),
            label: 'Admissions',
          ),
          NavigationDestination(
            icon: Icon(Icons.badge_outlined),
            selectedIcon: Icon(Icons.badge, color: AppTheme.forestPrimary),
            label: 'Registry',
          ),
          NavigationDestination(
            icon: Icon(Icons.campaign_outlined),
            selectedIcon: Icon(Icons.campaign, color: AppTheme.forestPrimary),
            label: 'Notices',
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
      appBar: CustomSchoolAppBar(
        title: screenTitle,
        showRoleSwitcher: true,
      ),
      drawer: _buildAppDrawer(context, auth),
      body: screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        elevation: 4,
        indicatorColor: AppTheme.forestTint,
        destinations: destinations,
      ),
    );
  }

  String _getParentTitle(int index) {
    switch (index) {
      case 0:
        return 'Student Portal';
      case 1:
        return 'Attendance Tracker';
      case 2:
        return 'Fee Receipts & Dues';
      case 3:
        return 'Daily Diary & Homework';
      case 4:
        return 'School Notices';
      default:
        return 'Al-Qalam School';
    }
  }

  String _getTeacherTitle(int index) {
    switch (index) {
      case 0:
        return 'Faculty Workspace';
      case 1:
        return 'Mark Attendance';
      case 2:
        return 'Assign Homework';
      case 3:
        return 'Class Student Roster';
      case 4:
        return 'Circulars';
      default:
        return 'Faculty Portal';
    }
  }

  String _getAdminTitle(int index) {
    switch (index) {
      case 0:
        return 'Management Dashboard';
      case 1:
        return 'Fee Accounts Ledger';
      case 2:
        return 'Admission Enquiries';
      case 3:
        return 'Student Registry';
      case 4:
        return 'Notice Broadcast';
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
            padding: const EdgeInsets.fromLTRB(20, 52, 20, 20),
            color: AppTheme.forestDeep,
            child: Row(
              children: [
                Container(
                  width: 54,
                  height: 54,
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (_, __, ___) => const Icon(
                        Icons.school,
                        color: AppTheme.forestPrimary,
                        size: 32,
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
                  leading: const Icon(Icons.grade_outlined,
                      color: AppTheme.forestPrimary),
                  title: Text('Academic Report Card',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReportCardScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.schedule_outlined,
                      color: AppTheme.forestPrimary),
                  title: Text('Weekly Class Timetable',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const TimetableScreen()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.campaign_outlined,
                      color: AppTheme.forestPrimary),
                  title: Text('Notices & Circulars',
                      style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const NoticesScreen()),
                    );
                  },
                ),
                if (auth.isAdmin)
                  ListTile(
                    leading: const Icon(Icons.post_add_rounded,
                        color: AppTheme.forestPrimary),
                    title: Text('Broadcast New Notice',
                        style: GoogleFonts.inter(fontWeight: FontWeight.w500)),
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PostNoticeScreen()),
                      );
                    },
                  ),
                const Divider(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: Text(
                    'PORTAL ROLE SWITCH',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.textMuted,
                      letterSpacing: 0.8,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.family_restroom,
                      color: AppTheme.forestPrimary),
                  title: Text('Parent / Student View',
                      style: GoogleFonts.inter(fontSize: 13)),
                  selected: auth.isParent,
                  onTap: () {
                    auth.switchRole(UserRole.parent);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading:
                      const Icon(Icons.school, color: AppTheme.forestPrimary),
                  title: Text('Class Teacher View',
                      style: GoogleFonts.inter(fontSize: 13)),
                  selected: auth.isTeacher,
                  onTap: () {
                    auth.switchRole(UserRole.teacher);
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.admin_panel_settings,
                      color: AppTheme.forestPrimary),
                  title: Text('Administrator View',
                      style: GoogleFonts.inter(fontSize: 13)),
                  selected: auth.isAdmin,
                  onTap: () {
                    auth.switchRole(UserRole.admin);
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            color: const Color(0xFFF9FAFB),
            child: Row(
              children: [
                const Icon(Icons.location_on_outlined,
                    size: 16, color: AppTheme.textMuted),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Gulzarbagh, Patna • Est. 2011',
                    style: GoogleFonts.inter(
                        fontSize: 11, color: AppTheme.textMuted),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
