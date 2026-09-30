import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_theme.dart';
import '../../services/school_data_repository.dart';
import '../auth/auth_gate.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _entryController;
  late AnimationController _pulseController;
  late AnimationController _exitController;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _arabicFade;
  late Animation<Offset> _arabicSlide;
  late Animation<double> _titleFade;
  late Animation<Offset> _titleSlide;
  late Animation<double> _badgeFade;
  late Animation<double> _haloPulse;
  late Animation<double> _exitZoom;
  late Animation<double> _exitFade;

  @override
  void initState() {
    super.initState();

    // Entry Controller: 1600ms staggered orchestration
    _entryController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    // Continuous soft breathing pulse for golden halo
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..repeat(reverse: true);

    // Exit Controller: 650ms cinematic outward expansion into the app
    _exitController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 650),
    );

    // Animations setup
    _logoScale = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _arabicFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.35, 0.75, curve: Curves.easeIn),
      ),
    );

    _arabicSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.25),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.35, 0.75, curve: Curves.easeOutCubic),
      ),
    );

    _titleFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.55, 0.9, curve: Curves.easeIn),
      ),
    );

    _titleSlide = Tween<Offset>(
      begin: const Offset(0.0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.55, 0.9, curve: Curves.easeOutCubic),
      ),
    );

    _badgeFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _entryController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeIn),
      ),
    );

    _haloPulse = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _exitZoom = Tween<double>(begin: 1.0, end: 1.35).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeInOutCubic),
    );

    _exitFade = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(parent: _exitController, curve: Curves.easeOut),
    );

    _entryController.forward();

    // Trigger transition into the app after 2.6s
    Future.delayed(const Duration(milliseconds: 2600), () async {
      if (!mounted) return;
      await _exitController.forward();
      if (!mounted) return;

      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => const AuthGate(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeIn,
              ),
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 500),
        ),
      );
    });
  }

  @override
  void dispose() {
    _entryController.dispose();
    _pulseController.dispose();
    _exitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF072414), // Luxurious Deep Imperial Pine
      body: AnimatedBuilder(
        animation: Listenable.merge([_entryController, _pulseController, _exitController]),
        builder: (context, _) {
          return FadeTransition(
            opacity: _exitFade,
            child: ScaleTransition(
              scale: _exitZoom,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // Ambient radiant background gradients
                  Positioned(
                    top: -size.height * 0.15,
                    right: -size.width * 0.2,
                    child: Container(
                      width: size.width * 0.9,
                      height: size.width * 0.9,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            const Color(0xFF14532D).withValues(alpha: 0.35),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -size.height * 0.15,
                    left: -size.width * 0.2,
                    child: Container(
                      width: size.width * 0.95,
                      height: size.width * 0.95,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            AppTheme.goldPrimary.withValues(alpha: 0.16),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Geometric star ornament watermark
                  Center(
                    child: Transform.rotate(
                      angle: _pulseController.value * math.pi * 0.05,
                      child: Container(
                        width: 320,
                        height: 320,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.025),
                            width: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Central Content
                  Center(
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Pulsing Emblem with Glowing Golden Halo
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              // Pulsing outer aura ring
                              Transform.scale(
                                scale: _haloPulse.value,
                                child: Container(
                                  width: 146,
                                  height: 146,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        AppTheme.goldPrimary.withValues(alpha: 0.28),
                                        AppTheme.goldPrimary.withValues(alpha: 0.0),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              // School Emblem Badge
                              FadeTransition(
                                opacity: _logoFade,
                                child: ScaleTransition(
                                  scale: _logoScale,
                                  child: Container(
                                    width: 122,
                                    height: 122,
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                      border: Border.all(
                                        color: AppTheme.goldPrimary,
                                        width: 3.5,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: AppTheme.goldPrimary.withValues(alpha: 0.35),
                                          blurRadius: 28,
                                          offset: const Offset(0, 10),
                                        ),
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.4),
                                          blurRadius: 20,
                                          offset: const Offset(0, 8),
                                        ),
                                      ],
                                    ),
                                    child: ClipOval(
                                      child: Image.asset(
                                        'assets/images/clean_logo.png',
                                        fit: BoxFit.contain,
                                        errorBuilder: (_, __, ___) => Image.asset(
                                          'assets/images/logo.png',
                                          fit: BoxFit.contain,
                                          errorBuilder: (_, __, ___) => const Icon(
                                            Icons.school_rounded,
                                            size: 56,
                                            color: AppTheme.forestPrimary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 28),

                          // Arabic Calligraphy Motto
                          FadeTransition(
                            opacity: _arabicFade,
                            child: SlideTransition(
                              position: _arabicSlide,
                              child: Column(
                                children: [
                                  Text(
                                    SchoolDataRepository.schoolMottoArabic,
                                    style: GoogleFonts.amiri(
                                      fontSize: 26,
                                      color: AppTheme.goldPrimary,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1.2,
                                      shadows: [
                                        Shadow(
                                          color: AppTheme.goldPrimary.withValues(alpha: 0.4),
                                          blurRadius: 16,
                                        ),
                                      ],
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    SchoolDataRepository.schoolMottoTranslation,
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      color: Colors.white.withValues(alpha: 0.8),
                                      fontStyle: FontStyle.italic,
                                      letterSpacing: 0.3,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // English Name Header
                          FadeTransition(
                            opacity: _titleFade,
                            child: SlideTransition(
                              position: _titleSlide,
                              child: Column(
                                children: [
                                  Text(
                                    SchoolDataRepository.schoolName.toUpperCase(),
                                    style: GoogleFonts.outfit(
                                      fontSize: 23,
                                      fontWeight: FontWeight.w800,
                                      color: Colors.white,
                                      letterSpacing: 1.8,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    'Gulzarbagh, Patna • Est. 2011',
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: AppTheme.goldPrimary,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Tagline Pill
                          FadeTransition(
                            opacity: _badgeFade,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.08),
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(
                                  color: AppTheme.goldPrimary.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                SchoolDataRepository.schoolTagline,
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.95),
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 44),

                          // Glowing Pulse Progress Indicator
                          FadeTransition(
                            opacity: _badgeFade,
                            child: const SizedBox(
                              width: 32,
                              height: 32,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.6,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.goldPrimary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom Suite Branding
                  Positioned(
                    bottom: 20,
                    left: 0,
                    right: 0,
                    child: FadeTransition(
                      opacity: _badgeFade,
                      child: Center(
                        child: Text(
                          'Al-Qalam Smart Campus Management Suite',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            color: Colors.white.withValues(alpha: 0.35),
                            letterSpacing: 0.6,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
