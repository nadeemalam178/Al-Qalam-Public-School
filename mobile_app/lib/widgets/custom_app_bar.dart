import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';
import '../services/school_data_repository.dart';
import '../theme/app_theme.dart';

class CustomSchoolAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showRoleSwitcher;
  final List<Widget>? actions;

  const CustomSchoolAppBar({
    super.key,
    required this.title,
    this.showRoleSwitcher = true,
    this.actions,
  });

  @override
  Size get preferredSize => const Size.fromHeight(68);

  void _showRoleSwitcherModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) {
        return Consumer<AuthProvider>(
          builder: (context, auth, _) {
            return Container(
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: AppTheme.forestTint,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.swap_horiz_rounded,
                          color: AppTheme.forestPrimary,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Switch Portal Role',
                            style: GoogleFonts.outfit(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.forestDeep,
                            ),
                          ),
                          Text(
                            'Experience Al-Qalam app as each school persona',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: AppTheme.textMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ...SchoolDataRepository.demoUsers.map((user) {
                    final isSelected = auth.currentUser.id == user.id;
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.forestTint
                            : const Color(0xFFF9FAFB),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.forestPrimary
                              : AppTheme.borderLight,
                          width: isSelected ? 1.5 : 1,
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: isSelected
                              ? AppTheme.forestPrimary
                              : const Color(0xFFE5E7EB),
                          foregroundColor:
                              isSelected ? Colors.white : AppTheme.forestDeep,
                          child: Icon(
                            user.role.name == 'parent'
                                ? Icons.family_restroom
                                : user.role.name == 'teacher'
                                    ? Icons.school
                                    : Icons.admin_panel_settings,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          user.name,
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.textDark,
                          ),
                        ),
                        subtitle: Text(
                          '${user.roleDisplayName} • ${user.designation}',
                          style: GoogleFonts.inter(fontSize: 12),
                        ),
                        trailing: isSelected
                            ? const Icon(
                                Icons.check_circle,
                                color: AppTheme.forestPrimary,
                              )
                            : null,
                        onTap: () {
                          auth.switchUser(user);
                          Navigator.pop(ctx);
                        },
                      ),
                    );
                  }),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return AppBar(
      backgroundColor: AppTheme.forestDeep,
      elevation: 0,
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: AppTheme.goldPrimary, width: 1.5),
            ),
            child: ClipOval(
              child: Image.asset(
                'assets/images/clean_logo.png',
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.school,
                    size: 20,
                    color: AppTheme.forestPrimary,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${SchoolDataRepository.schoolName} • ${auth.currentUser.roleDisplayName}',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    color: AppTheme.goldPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        if (showRoleSwitcher)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Tooltip(
              message: 'Switch Role (Parent/Teacher/Admin)',
              child: InkWell(
                onTap: () => _showRoleSwitcherModal(context),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppTheme.goldPrimary.withValues(alpha: 0.6),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.swap_horiz,
                        size: 16,
                        color: AppTheme.goldPrimary,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Switch',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        if (actions != null) ...actions!,
      ],
    );
  }
}
