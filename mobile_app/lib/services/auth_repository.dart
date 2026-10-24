import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/login_role.dart';
import '../models/user_model.dart';
import 'school_data_repository.dart';
import 'supabase_service.dart';

/// Custom exception for user-friendly authentication and authorization errors.
class AuthFailureException implements Exception {
  final String message;
  const AuthFailureException(this.message);

  @override
  String toString() => message;
}

/// Abstract contract for authentication operations.
abstract class AuthRepository {
  Future<AppUser> signIn({
    required LoginRole selectedRole,
    required String identifier,
    required String password,
  });

  Future<AppUser?> restoreSession();

  Future<void> signOut();
}

/// Production implementation of [AuthRepository] interacting with Supabase Auth
/// and PostgreSQL `profiles` table with row-level role enforcement.
class SupabaseAuthRepository implements AuthRepository {
  const SupabaseAuthRepository();

  /// Converts a phone number or employee ID into an internal synthetic email
  /// if an email address was not directly provided.
  static String formatIdentifierToEmail(String rawIdentifier) {
    final trimmed = rawIdentifier.trim();
    if (trimmed.contains('@')) {
      return trimmed.toLowerCase();
    }
    // Clean non-alphanumeric characters for phone / ID
    final cleaned = trimmed.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toLowerCase();
    return '$cleaned@alqalam.com';
  }

  @override
  Future<AppUser> signIn({
    required LoginRole selectedRole,
    required String identifier,
    required String password,
  }) async {
    final client = SupabaseService.client;

    if (client == null || !SupabaseService.isInitialized) {
      throw const AuthFailureException(
        'Unable to connect to school server. Please verify your internet connection.',
      );
    }

    return await _signInWithSupabase(
      client: client,
      selectedRole: selectedRole,
      identifier: identifier,
      password: password,
    );
  }

  Future<AppUser> _signInWithSupabase({
    required SupabaseClient client,
    required LoginRole selectedRole,
    required String identifier,
    required String password,
  }) async {
    final email = formatIdentifierToEmail(identifier);

    AuthResponse authResponse;
    try {
      authResponse = await client.auth.signInWithPassword(
        email: email,
        password: password,
      );
    } on AuthException catch (e) {
      debugPrint('Supabase AuthException: ${e.message} (${e.statusCode})');
      final msg = e.message.toLowerCase();
      if (msg.contains('invalid') || msg.contains('credentials')) {
        throw const AuthFailureException('Invalid email or password.');
      }
      throw const AuthFailureException(
        'Authentication error: Please check your credentials or network connection.',
      );
    } catch (e) {
      debugPrint('Supabase unexpected sign-in error: $e');
      throw const AuthFailureException(
        'Unable to connect to school server. Please verify your internet connection.',
      );
    }

    final user = authResponse.user;
    if (user == null) {
      throw const AuthFailureException('Invalid email or password.');
    }

    // Fetch user profile from PostgreSQL profiles table
    Map<String, dynamic>? profile;
    try {
      profile = await client
          .from('profiles')
          .select()
          .eq('id', user.id)
          .maybeSingle();
    } catch (e) {
      debugPrint('Error fetching profile from Supabase: $e');
      await client.auth.signOut();
      throw const AuthFailureException(
        'Unable to verify school profile. Please check your network connection.',
      );
    }

    if (profile == null) {
      await client.auth.signOut();
      throw const AuthFailureException(
        'Your account is authenticated, but your school profile has not been configured. '
        'Please contact the administrator.',
      );
    }

    // Strict Role Enforcement
    final actualDbRole = profile['role'] as String?;
    final expectedDbRole = selectedRole.databaseRole;

    if (actualDbRole == null ||
        actualDbRole.toLowerCase().trim() != expectedDbRole) {
      // Discard auth session immediately
      await client.auth.signOut();
      final actualRoleTitle = LoginRole.formatDatabaseRole(actualDbRole);
      throw AuthFailureException(
        'This account is registered as a $actualRoleTitle. '
        'Please select $actualRoleTitle to continue.',
      );
    }

    return AppUser(
      id: profile['id'] as String? ?? user.id,
      name: (profile['full_name'] ?? profile['name'] ?? user.email ?? 'School Member')
          as String,
      email: (profile['email'] ?? user.email ?? '') as String,
      phone: (profile['phone'] ?? user.phone ?? '') as String,
      role: selectedRole.toUserRole(),
      designation: (profile['designation'] ??
              'Al-Qalam ${selectedRole.title}') as String,
      studentId: profile['student_id'] as String?,
      classAssigned: profile['class_assigned'] as String?,
    );
  }

  Future<AppUser?> restoreSession() async {
    final client = SupabaseService.client;
    if (client == null || !SupabaseService.isInitialized) {
      return null;
    }

    final session = client.auth.currentSession;
    if (session == null || session.isExpired) {
      return null;
    }

    try {
      final profile = await client
          .from('profiles')
          .select()
          .eq('id', session.user.id)
          .maybeSingle();

      if (profile == null) return null;

      final dbRole = profile['role'] as String?;
      final role = LoginRole.tryFromDatabaseRole(dbRole)?.toUserRole();
      if (role == null) return null;

      return AppUser(
        id: profile['id'] as String? ?? session.user.id,
        name: (profile['full_name'] ?? profile['name'] ?? session.user.email ?? 'Member')
            as String,
        email: (profile['email'] ?? session.user.email ?? '') as String,
        phone: (profile['phone'] ?? session.user.phone ?? '') as String,
        role: role,
        designation: (profile['designation'] ?? 'Al-Qalam Member') as String,
        studentId: profile['student_id'] as String?,
        classAssigned: profile['class_assigned'] as String?,
      );
    } catch (e) {
      debugPrint('Error restoring session: $e');
      return null;
    }
  }

  @override
  Future<void> signOut() async {
    final client = SupabaseService.client;
    if (client != null && SupabaseService.isInitialized) {
      try {
        await client.auth.signOut();
      } catch (e) {
        debugPrint('Error signing out from Supabase: $e');
      }
    }
  }
}
