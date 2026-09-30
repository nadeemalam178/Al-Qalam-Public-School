import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/login_role.dart';
import '../theme/app_theme.dart';

class RoleCard extends StatefulWidget {
  final LoginRole role;
  final bool isSelected;
  final VoidCallback onTap;

  const RoleCard({
    super.key,
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  State<RoleCard> createState() => _RoleCardState();
}

class _RoleCardState extends State<RoleCard> {
  bool _isHoveredOrPressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final baseBorderColor = widget.isSelected
        ? AppTheme.forestPrimary
        : (isDark ? Colors.white24 : AppTheme.borderLight);

    final cardBgColor = widget.isSelected
        ? (isDark
            ? AppTheme.forestPrimary.withValues(alpha: 0.25)
            : AppTheme.forestTint.withValues(alpha: 0.65))
        : (isDark ? const Color(0xFF1E293B) : Colors.white);

    final iconBgColor = widget.isSelected
        ? AppTheme.forestPrimary
        : (isDark ? Colors.white12 : const Color(0xFFF0FDF4));

    final iconColor = widget.isSelected
        ? Colors.white
        : (isDark ? AppTheme.goldPrimary : AppTheme.forestPrimary);

    return AnimatedScale(
      scale: _isHoveredOrPressed ? 0.98 : 1.0,
      duration: const Duration(milliseconds: 150),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: widget.onTap,
          onHighlightChanged: (pressed) {
            setState(() {
              _isHoveredOrPressed = pressed;
            });
          },
          borderRadius: BorderRadius.circular(16),
          splashColor: AppTheme.forestPrimary.withValues(alpha: 0.1),
          highlightColor: AppTheme.forestPrimary.withValues(alpha: 0.05),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            decoration: BoxDecoration(
              color: cardBgColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: baseBorderColor,
                width: widget.isSelected ? 2.0 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: widget.isSelected
                      ? AppTheme.forestPrimary.withValues(alpha: 0.12)
                      : Colors.black.withValues(alpha: isDark ? 0.2 : 0.04),
                  blurRadius: widget.isSelected ? 16 : 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon Avatar
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: widget.isSelected
                          ? AppTheme.forestPrimary
                          : AppTheme.goldPrimary.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Icon(
                    widget.role.icon,
                    size: 28,
                    color: iconColor,
                  ),
                ),
                const SizedBox(width: 16),

                // Title & Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              widget.role.title,
                              style: GoogleFonts.outfit(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: isDark
                                    ? Colors.white
                                    : (widget.isSelected
                                        ? AppTheme.forestDeep
                                        : AppTheme.textDark),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (widget.isSelected) ...[
                            const SizedBox(width: 8),
                            const Icon(
                              Icons.check_circle_rounded,
                              size: 18,
                              color: AppTheme.forestPrimary,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        widget.role.subtitle,
                        style: GoogleFonts.inter(
                          fontSize: 13,
                          color: isDark ? Colors.white70 : AppTheme.textMuted,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 16,
                  color: widget.isSelected
                      ? AppTheme.forestPrimary
                      : (isDark ? Colors.white38 : Colors.black26),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
