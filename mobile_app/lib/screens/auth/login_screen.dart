import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/login_role.dart';
import '../../providers/auth_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/role_card.dart';
import '../common/main_navigation_screen.dart';

class LoginScreen extends StatefulWidget {
  final LoginRole? initialRole;

  const LoginScreen({
    super.key,
    this.initialRole,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginRole? _selectedRole;
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _selectedRole = widget.initialRole;
  }

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onRoleSelected(LoginRole role) {
    setState(() {
      _selectedRole = role;
    });
    // Clear any previous error when switching role
    context.read<AuthProvider>().clearError();
  }

  void _onChangeAccountType() {
    setState(() {
      _selectedRole = null;
    });
    _passwordController.clear();
    context.read<AuthProvider>().clearError();
  }

  Future<void> _handleLogin() async {
    if (_selectedRole == null) return;
    if (!_formKey.currentState!.validate()) return;

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    final authProvider = context.read<AuthProvider>();
    final success = await authProvider.signIn(
      selectedRole: _selectedRole!,
      identifier: _identifierController.text.trim(),
      password: _passwordController.text,
    );

    if (success && mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => const MainNavigationScreen(),
        ),
        (route) => false,
      );
    }
  }

  void _showForgotPasswordDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        title: Row(
          children: [
            const Icon(Icons.help_outline_rounded, color: AppTheme.forestPrimary),
            const SizedBox(width: 8),
            Text(
              'Forgot Password?',
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        content: Text(
          'For security reasons, password resets are handled by the Al-Qalam IT administration desk.\n\n'
          'Please visit the administrative office or contact:\n'
          '📞 +91 93084 62418\n'
          '✉️ info@alqalam.edu.in',
          style: GoogleFonts.inter(fontSize: 14, height: 1.45),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              'Understood',
              style: GoogleFonts.inter(
                color: AppTheme.forestPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final auth = context.watch<AuthProvider>();

    final overlayStyle = isDark
        ? const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Color(0xFF0F172A),
            systemNavigationBarIconBrightness: Brightness.light,
          )
        : const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark,
          );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: Scaffold(
        backgroundColor: isDark
            ? const Color(0xFF0F172A)
            : const Color(0xFFF6F8F4), // Brand background #F6F8F4
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              physics: const BouncingScrollPhysics(),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 440),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 320),
                  switchInCurve: Curves.easeOutCubic,
                  switchOutCurve: Curves.easeInCubic,
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0.04, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  child: _selectedRole == null
                      ? _buildRoleSelectionView(isDark)
                      : _buildLoginFormView(isDark, auth),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Step 1: Role Selection with three large selectable cards
  Widget _buildRoleSelectionView(bool isDark) {
    return Column(
      key: const ValueKey('role_selection_view'),
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 12),

        // School Crest Emblem
        Container(
          width: 88,
          height: 88,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: AppTheme.goldPrimary,
              width: 2.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.forestDeep.withValues(alpha: 0.15),
                blurRadius: 18,
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
                  size: 44,
                  color: AppTheme.forestPrimary,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),

        // School Name Header
        Text(
          'Al-Qalam Public School',
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : AppTheme.forestDeep,
            letterSpacing: 0.3,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),

        // Welcome Back
        Text(
          'Welcome Back',
          style: GoogleFonts.outfit(
            fontSize: 26,
            fontWeight: FontWeight.w800,
            color: AppTheme.forestPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),

        // Subtitle
        Text(
          'Select your account type',
          style: GoogleFonts.inter(
            fontSize: 14,
            color: isDark ? Colors.white70 : AppTheme.textMuted,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 32),

        // Three Selectable Role Cards
        RoleCard(
          role: LoginRole.administrator,
          isSelected: _selectedRole == LoginRole.administrator,
          onTap: () => _onRoleSelected(LoginRole.administrator),
        ),
        const SizedBox(height: 14),

        RoleCard(
          role: LoginRole.teacher,
          isSelected: _selectedRole == LoginRole.teacher,
          onTap: () => _onRoleSelected(LoginRole.teacher),
        ),
        const SizedBox(height: 14),

        RoleCard(
          role: LoginRole.parent,
          isSelected: _selectedRole == LoginRole.parent,
          onTap: () => _onRoleSelected(LoginRole.parent),
        ),
        const SizedBox(height: 36),

        // Footer Campus Details
        Text(
          'Gulzarbagh, Patna • Est. 2011',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isDark ? Colors.white38 : AppTheme.textLight,
            letterSpacing: 0.4,
          ),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  /// Step 2: Login form for the selected account type
  Widget _buildLoginFormView(bool isDark, AuthProvider auth) {
    final role = _selectedRole!;

    return Form(
      key: _formKey,
      child: Column(
        key: ValueKey('login_form_${role.name}'),
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),

          // Mini School Crest & Role Indicator
          Center(
            child: Column(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: AppTheme.goldPrimary,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
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
                        errorBuilder: (_, __, ___) => Icon(
                          role.icon,
                          size: 32,
                          color: AppTheme.forestPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Role Header
                Text(
                  '${role.title} Login',
                  style: GoogleFonts.outfit(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : AppTheme.forestDeep,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),

                // Subtitle context
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.forestTint,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(role.icon, size: 14, color: AppTheme.forestPrimary),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          role.subtitle,
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.forestPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),

          // Error Feedback Banner
          if (auth.errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFCA5A5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.error_outline_rounded,
                    color: Color(0xFFDC2626),
                    size: 20,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      auth.errorMessage!,
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: const Color(0xFFB91C1C),
                        fontWeight: FontWeight.w500,
                        height: 1.35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],

          // Email / Mobile Field
          Text(
            'Email / Mobile Number',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _identifierController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? Colors.white : AppTheme.textDark,
            ),
            decoration: InputDecoration(
              hintText: role == LoginRole.parent
                  ? 'e.g. 9835012450 or parent@email.com'
                  : role == LoginRole.teacher
                      ? 'e.g. 9431056782 or teacher@alqalam.edu.in'
                      : 'e.g. director@alqalam.edu.in',
              hintStyle: GoogleFonts.inter(
                fontSize: 13,
                color: isDark ? Colors.white30 : AppTheme.textLight,
              ),
              prefixIcon: const Icon(
                Icons.person_outline_rounded,
                color: AppTheme.forestPrimary,
                size: 20,
              ),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter your email or mobile number.';
              }
              return null;
            },
          ),
          const SizedBox(height: 18),

          // Password Field
          Text(
            'Password',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: _passwordController,
            obscureText: _obscurePassword,
            textInputAction: TextInputAction.done,
            onFieldSubmitted: (_) => _handleLogin(),
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isDark ? Colors.white : AppTheme.textDark,
            ),
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: GoogleFonts.inter(
                fontSize: 13,
                color: isDark ? Colors.white30 : AppTheme.textLight,
              ),
              prefixIcon: const Icon(
                Icons.lock_outline_rounded,
                color: AppTheme.forestPrimary,
                size: 20,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: isDark ? Colors.white54 : AppTheme.textMuted,
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password.';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Login Button
          SizedBox(
            height: 52,
            child: ElevatedButton(
              onPressed: auth.isLoading ? null : _handleLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.forestPrimary,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                elevation: 1,
              ),
              child: auth.isLoading
                  ? const SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : Text(
                      'LOGIN',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.8,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 14),

          // Forgot Password Link
          Center(
            child: TextButton(
              onPressed: _showForgotPasswordDialog,
              child: Text(
                'Forgot Password?',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppTheme.goldPrimary : AppTheme.forestPrimary,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          // Change Account Type Button
          Center(
            child: TextButton.icon(
              onPressed: auth.isLoading ? null : _onChangeAccountType,
              icon: const Icon(Icons.arrow_back_rounded, size: 16),
              label: Text(
                'Change Account Type',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              style: TextButton.styleFrom(
                foregroundColor: isDark ? Colors.white70 : AppTheme.textDark,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
