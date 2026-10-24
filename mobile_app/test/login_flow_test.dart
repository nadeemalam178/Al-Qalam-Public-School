import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:al_qalam_school/models/login_role.dart';
import 'package:al_qalam_school/models/user_model.dart';
import 'package:al_qalam_school/providers/auth_provider.dart';
import 'package:al_qalam_school/providers/school_provider.dart';
import 'package:al_qalam_school/screens/auth/login_screen.dart';
import 'package:al_qalam_school/services/auth_repository.dart';
import 'package:al_qalam_school/theme/app_theme.dart';
import 'package:al_qalam_school/widgets/role_card.dart';

/// Test mock implementation of [AuthRepository]
class MockAuthRepository implements AuthRepository {
  @override
  Future<AppUser> signIn({
    required LoginRole selectedRole,
    required String identifier,
    required String password,
  }) async {
    final cleanId = identifier.trim().toLowerCase();

    if (password != 'secure_test_password') {
      throw const AuthFailureException('Invalid email or password.');
    }

    if (cleanId == 'parent@example.com' || cleanId == 'parent_201') {
      if (selectedRole != LoginRole.parent) {
        throw const AuthFailureException(
          'This account is registered as a Parent. Please select Parent to continue.',
        );
      }
      return const AppUser(
        id: 'USR-PARENT-TEST',
        name: 'Test Parent',
        email: 'parent@example.com',
        phone: '+91 98000 00000',
        role: UserRole.parent,
        designation: 'Parent of Test Student',
      );
    }

    if (cleanId == 'admin@example.com' || cleanId == 'admin_777') {
      if (selectedRole != LoginRole.administrator) {
        throw const AuthFailureException(
          'This account is registered as a Administrator. Please select Administrator to continue.',
        );
      }
      return const AppUser(
        id: 'USR-ADMIN-TEST',
        name: 'Test Admin',
        email: 'admin@example.com',
        phone: '+91 99000 00000',
        role: UserRole.admin,
        designation: 'Director',
      );
    }

    throw const AuthFailureException('Invalid email or password.');
  }

  @override
  Future<AppUser?> restoreSession() async => null;

  @override
  Future<void> signOut() async {}
}

void main() {
  group('LoginRole and Database Mapping Tests', () {
    test('Correct database role mapping', () {
      expect(LoginRole.administrator.databaseRole, 'admin');
      expect(LoginRole.teacher.databaseRole, 'teacher');
      expect(LoginRole.parent.databaseRole, 'guardian');
    });

    test('Correct UserRole mapping', () {
      expect(LoginRole.administrator.toUserRole(), UserRole.admin);
      expect(LoginRole.teacher.toUserRole(), UserRole.teacher);
      expect(LoginRole.parent.toUserRole(), UserRole.parent);
    });

    test('Format database role strings', () {
      expect(LoginRole.formatDatabaseRole('admin'), 'Administrator');
      expect(LoginRole.formatDatabaseRole('teacher'), 'Teacher');
      expect(LoginRole.formatDatabaseRole('guardian'), 'Parent');
      expect(LoginRole.formatDatabaseRole('parent'), 'Parent');
    });
  });

  group('Authentication and Security Role Mismatch Tests', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider(authRepository: MockAuthRepository());
    });

    test('Selecting Administrator but using Parent credentials rejects with role error', () async {
      final success = await authProvider.signIn(
        selectedRole: LoginRole.administrator,
        identifier: 'parent@example.com',
        password: 'secure_test_password',
      );

      expect(success, isFalse);
      expect(authProvider.isAuthenticated, isFalse);
      expect(
        authProvider.errorMessage,
        'This account is registered as a Parent. Please select Parent to continue.',
      );
    });

    test('Selecting Teacher but using Administrator credentials rejects with role error', () async {
      final success = await authProvider.signIn(
        selectedRole: LoginRole.teacher,
        identifier: 'admin@example.com',
        password: 'secure_test_password',
      );

      expect(success, isFalse);
      expect(authProvider.isAuthenticated, isFalse);
      expect(
        authProvider.errorMessage,
        'This account is registered as a Administrator. Please select Administrator to continue.',
      );
    });

    test('Invalid credentials error message', () async {
      final success = await authProvider.signIn(
        selectedRole: LoginRole.parent,
        identifier: 'nonexistent@example.com',
        password: 'wrongpassword',
      );

      expect(success, isFalse);
      expect(authProvider.errorMessage, 'Invalid email or password.');
    });

    test('Matching credentials and role succeeds', () async {
      final success = await authProvider.signIn(
        selectedRole: LoginRole.parent,
        identifier: 'parent@example.com',
        password: 'secure_test_password',
      );

      expect(success, isTrue);
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.currentRole, UserRole.parent);
      expect(authProvider.errorMessage, isNull);
    });

    test('Administrator login succeeds with correct credentials', () async {
      final success = await authProvider.signIn(
        selectedRole: LoginRole.administrator,
        identifier: 'admin@example.com',
        password: 'secure_test_password',
      );

      expect(success, isTrue);
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.currentRole, UserRole.admin);
      expect(authProvider.currentUser.name, 'Test Admin');
      expect(authProvider.errorMessage, isNull);
    });

    test('Primary Admin ID ALQALAM with newapp2026 succeeds', () async {
      final prodRepo = const SupabaseAuthRepository();
      final adminProvider = AuthProvider(authRepository: prodRepo);
      final success = await adminProvider.signIn(
        selectedRole: LoginRole.administrator,
        identifier: 'ALQALAM',
        password: 'newapp2026',
      );

      expect(success, isTrue);
      expect(adminProvider.isAuthenticated, isTrue);
      expect(adminProvider.currentRole, UserRole.admin);
      expect(adminProvider.currentUser.role, UserRole.admin);
    });
  });

  group('LoginScreen UI and Interaction Flow Tests', () {
    Widget createTestApp({AuthProvider? auth}) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => auth ?? AuthProvider(authRepository: MockAuthRepository()),
          ),
          ChangeNotifierProvider<SchoolProvider>(
            create: (_) => SchoolProvider(),
          ),
        ],
        child: MaterialApp(
          theme: AppTheme.lightTheme,
          home: const LoginScreen(),
        ),
      );
    }

    testWidgets('Displays brand header and three role cards initially', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Brand text
      expect(find.text('Al-Qalam Public School'), findsOneWidget);
      expect(find.text('Welcome Back'), findsOneWidget);
      expect(find.text('Select your account type'), findsOneWidget);

      // Three cards
      expect(find.widgetWithText(RoleCard, 'Administrator'), findsOneWidget);
      expect(find.widgetWithText(RoleCard, 'Teacher'), findsOneWidget);
      expect(find.widgetWithText(RoleCard, 'Parent'), findsOneWidget);

      // Subtitles
      expect(find.text('Manage school operations'), findsOneWidget);
      expect(find.text('Attendance, homework & academics'), findsOneWidget);
      expect(find.text("View your child's academic information"), findsOneWidget);
    });

    testWidgets('Tapping Teacher card transitions to Teacher Login form', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Tap Teacher card
      await tester.tap(find.widgetWithText(RoleCard, 'Teacher'));
      await tester.pumpAndSettle();

      // Form header
      expect(find.text('Teacher Login'), findsOneWidget);
      expect(find.text('Email / Mobile Number'), findsOneWidget);
      expect(find.text('Password'), findsOneWidget);
      expect(find.text('LOGIN'), findsOneWidget);
      expect(find.text('Forgot Password?'), findsOneWidget);
      expect(find.text('Change Account Type'), findsOneWidget);
    });

    testWidgets('Tapping Change Account Type returns to role selection', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Select Parent
      await tester.tap(find.widgetWithText(RoleCard, 'Parent'));
      await tester.pumpAndSettle();

      expect(find.text('Parent Login'), findsOneWidget);

      // Tap Change Account Type
      await tester.tap(find.text('Change Account Type'));
      await tester.pumpAndSettle();

      // Back to three cards
      expect(find.text('Select your account type'), findsOneWidget);
      expect(find.widgetWithText(RoleCard, 'Administrator'), findsOneWidget);
      expect(find.widgetWithText(RoleCard, 'Teacher'), findsOneWidget);
      expect(find.widgetWithText(RoleCard, 'Parent'), findsOneWidget);
    });
  });
}
