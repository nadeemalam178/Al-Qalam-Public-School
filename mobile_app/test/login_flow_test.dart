import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:al_qalam_school/models/login_role.dart';
import 'package:al_qalam_school/models/user_model.dart';
import 'package:al_qalam_school/providers/auth_provider.dart';
import 'package:al_qalam_school/providers/school_provider.dart';
import 'package:al_qalam_school/screens/auth/login_screen.dart';
import 'package:al_qalam_school/theme/app_theme.dart';

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
      authProvider = AuthProvider();
    });

    test('Selecting Administrator but using Parent credentials rejects with role error', () async {
      // Parent demo credentials: tariq.alam@gmail.com
      final success = await authProvider.signIn(
        selectedRole: LoginRole.administrator,
        identifier: 'tariq.alam@gmail.com',
        password: 'password123',
      );

      expect(success, isFalse);
      expect(authProvider.isAuthenticated, isFalse);
      expect(
        authProvider.errorMessage,
        'This account is registered as a Parent. Please select Parent to continue.',
      );
    });

    test('Selecting Teacher but using Administrator credentials rejects with role error', () async {
      // Administrator demo credentials: director@alqalam.edu.in
      final success = await authProvider.signIn(
        selectedRole: LoginRole.teacher,
        identifier: 'director@alqalam.edu.in',
        password: 'password123',
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
        identifier: 'tariq.alam@gmail.com',
        password: 'correctpassword',
      );

      expect(success, isTrue);
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.currentRole, UserRole.parent);
      expect(authProvider.errorMessage, isNull);
    });

    test('Alqalam_777 with newappschool logs in as Administrator successfully', () async {
      final success = await authProvider.signIn(
        selectedRole: LoginRole.administrator,
        identifier: 'Alqalam_777',
        password: 'newappschool',
      );

      expect(success, isTrue);
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.currentRole, UserRole.admin);
      expect(authProvider.currentUser.name, 'Rahat Jahan');
      expect(authProvider.errorMessage, isNull);
    });

    test('Alqalam_777 under Teacher role is rejected with role mismatch error', () async {
      final success = await authProvider.signIn(
        selectedRole: LoginRole.teacher,
        identifier: 'Alqalam_777',
        password: 'newappschool',
      );

      expect(success, isFalse);
      expect(authProvider.isAuthenticated, isFalse);
      expect(
        authProvider.errorMessage,
        'This account is registered as a Administrator. Please select Administrator to continue.',
      );
    });

    test('Alqalam_777 with wrong password is rejected', () async {
      final success = await authProvider.signIn(
        selectedRole: LoginRole.administrator,
        identifier: 'Alqalam_777',
        password: 'wrong_password',
      );

      expect(success, isFalse);
      expect(authProvider.isAuthenticated, isFalse);
      expect(authProvider.errorMessage, 'Invalid email or password.');
    });
  });

  group('LoginScreen UI and Interaction Flow Tests', () {
    Widget createTestApp({AuthProvider? auth}) {
      return MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => auth ?? AuthProvider(),
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
      expect(find.text('Administrator'), findsOneWidget);
      expect(find.text('Teacher'), findsOneWidget);
      expect(find.text('Parent'), findsOneWidget);

      // Subtitles
      expect(find.text('Manage school operations'), findsOneWidget);
      expect(find.text('Attendance, homework & academics'), findsOneWidget);
      expect(find.text("View your child's academic information"), findsOneWidget);
    });

    testWidgets('Tapping Teacher card transitions to Teacher Login form', (tester) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Tap Teacher card
      await tester.tap(find.text('Teacher'));
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
      await tester.tap(find.text('Parent'));
      await tester.pumpAndSettle();

      expect(find.text('Parent Login'), findsOneWidget);

      // Tap Change Account Type
      await tester.tap(find.text('Change Account Type'));
      await tester.pumpAndSettle();

      // Back to three cards
      expect(find.text('Select your account type'), findsOneWidget);
      expect(find.text('Administrator'), findsOneWidget);
      expect(find.text('Teacher'), findsOneWidget);
      expect(find.text('Parent'), findsOneWidget);
    });
  });
}
