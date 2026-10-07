import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Reusable Glassmorphism Container with BackdropFilter blur and frosted edge highlight
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final Color? color;
  final Gradient? gradient;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Border? border;
  final Color? borderColor;
  final double borderWidth;
  final List<BoxShadow>? shadows;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 14.0,
    this.opacity = 0.75,
    this.color,
    this.gradient,
    this.borderRadius,
    this.padding,
    this.margin,
    this.border,
    this.borderColor,
    this.borderWidth = 1.0,
    this.shadows,
    this.onTap,
    this.width,
    this.height,
    this.alignment,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final r = borderRadius ?? BorderRadius.circular(18);

    final defaultBgColor = color ??
        (isDark
            ? const Color(0xFF1E293B).withValues(alpha: opacity)
            : Colors.white.withValues(alpha: opacity));

    final effectiveGradient = gradient ??
        LinearGradient(
          colors: isDark
              ? [
                  const Color(0xFF1E293B).withValues(alpha: opacity),
                  const Color(0xFF0F172A).withValues(alpha: opacity * 0.85),
                ]
              : [
                  Colors.white.withValues(alpha: opacity),
                  Colors.white.withValues(alpha: opacity * 0.65),
                ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );

    final effectiveBorder = border ??
        Border.all(
          color: borderColor ??
              (isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.65)),
          width: borderWidth,
        );

    final effectiveShadows = shadows ??
        [
          BoxShadow(
            color: isDark
                ? Colors.black.withValues(alpha: 0.3)
                : AppTheme.forestDeep.withValues(alpha: 0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ];

    Widget content = Container(
      width: width,
      height: height,
      alignment: alignment,
      padding: padding ?? const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: gradient == null ? defaultBgColor : null,
        gradient: effectiveGradient,
        borderRadius: r,
        border: effectiveBorder,
      ),
      child: child,
    );

    if (onTap != null) {
      content = Material(
        color: Colors.transparent,
        borderRadius: r,
        child: InkWell(
          onTap: onTap,
          borderRadius: r,
          splashColor: AppTheme.forestPrimary.withValues(alpha: 0.12),
          highlightColor: AppTheme.forestPrimary.withValues(alpha: 0.05),
          child: content,
        ),
      );
    }

    Widget glassBody = Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: r,
        boxShadow: effectiveShadows,
      ),
      child: ClipRRect(
        borderRadius: r,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: content,
        ),
      ),
    );

    return glassBody;
  }
}

/// Frosted Glass Card optimized for dashboard items and list entries
class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double blur;
  final double opacity;
  final Color? accentColor;
  final VoidCallback? onTap;
  final BorderRadius? borderRadius;
  final Border? border;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.blur = 16.0,
    this.opacity = 0.78,
    this.accentColor,
    this.onTap,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final r = borderRadius ?? BorderRadius.circular(20);

    return GlassContainer(
      margin: margin ?? const EdgeInsets.symmetric(vertical: 6),
      padding: padding ?? const EdgeInsets.all(16),
      borderRadius: r,
      blur: blur,
      opacity: opacity,
      border: border,
      borderColor: accentColor != null
          ? accentColor!.withValues(alpha: 0.28)
          : (isDark ? Colors.white.withValues(alpha: 0.15) : Colors.white.withValues(alpha: 0.7)),
      gradient: LinearGradient(
        colors: isDark
            ? [
                const Color(0xFF1E293B).withValues(alpha: 0.8),
                const Color(0xFF0F172A).withValues(alpha: 0.6),
              ]
            : [
                Colors.white.withValues(alpha: 0.85),
                (accentColor != null
                    ? accentColor!.withValues(alpha: 0.04)
                    : Colors.white.withValues(alpha: 0.55)),
              ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadows: [
        BoxShadow(
          color: (accentColor ?? AppTheme.forestDeep).withValues(alpha: 0.06),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ],
      onTap: onTap,
      child: child,
    );
  }
}

/// Frosted Glass Pill / Badge
class GlassBadge extends StatelessWidget {
  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final double blur;
  final VoidCallback? onTap;

  const GlassBadge({
    super.key,
    required this.child,
    this.color,
    this.padding,
    this.blur = 8.0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveColor = color ?? AppTheme.forestPrimary;
    final r = BorderRadius.circular(24);

    return Container(
      decoration: BoxDecoration(
        borderRadius: r,
        boxShadow: [
          BoxShadow(
            color: effectiveColor.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: r,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding ?? const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: effectiveColor.withValues(alpha: 0.12),
              borderRadius: r,
              border: Border.all(
                color: effectiveColor.withValues(alpha: 0.25),
                width: 0.8,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Living Canvas with Soft Radiant Ambient Glow Orbs
/// This ensures frosted glass and BackdropFilter blurs look deeply luminous
class AmbientGlassBackground extends StatelessWidget {
  final Widget child;
  final bool isDark;
  final bool showOrbs;

  const AmbientGlassBackground({
    super.key,
    required this.child,
    this.isDark = false,
    this.showOrbs = true,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Stack(
      children: [
        // Base canvas color
        Positioned.fill(
          child: Container(
            color: isDark ? const Color(0xFF0A0F1D) : const Color(0xFFF3F7F4),
          ),
        ),

        // Glowing Ambient Orbs that shimmer behind frosted glass
        if (showOrbs) ...[
          // Top-right Forest Green Orb
          Positioned(
            top: -size.height * 0.08,
            right: -size.width * 0.15,
            child: Container(
              width: size.width * 0.75,
              height: size.width * 0.75,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.forestPrimary.withValues(alpha: isDark ? 0.25 : 0.14),
                    AppTheme.forestPrimary.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          // Center-left Warm Amber / Gold Orb
          Positioned(
            top: size.height * 0.32,
            left: -size.width * 0.2,
            child: Container(
              width: size.width * 0.7,
              height: size.width * 0.7,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppTheme.goldPrimary.withValues(alpha: isDark ? 0.18 : 0.11),
                    AppTheme.goldPrimary.withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),

          // Bottom-right Soft Mint/Forest Tint Orb
          Positioned(
            bottom: -size.height * 0.05,
            right: -size.width * 0.1,
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    const Color(0xFF4ADE80).withValues(alpha: isDark ? 0.15 : 0.10),
                    const Color(0xFF4ADE80).withValues(alpha: 0.0),
                  ],
                ),
              ),
            ),
          ),
        ],

        // Foreground content with transparent hit-test
        Positioned.fill(
          child: child,
        ),
      ],
    );
  }
}
