import 'package:flutter/material.dart';
import 'user_model.dart';

/// Strongly-typed login roles for account selection and authentication.
enum LoginRole {
  administrator,
  teacher,
  parent;

  /// Internal database role stored in Supabase profiles (PostgreSQL RLS).
  String get databaseRole {
    switch (this) {
      case LoginRole.administrator:
        return 'admin';
      case LoginRole.teacher:
        return 'teacher';
      case LoginRole.parent:
        return 'guardian';
    }
  }

  /// Corresponding [UserRole] in the mobile app model.
  UserRole toUserRole() {
    switch (this) {
      case LoginRole.administrator:
        return UserRole.admin;
      case LoginRole.teacher:
        return UserRole.teacher;
      case LoginRole.parent:
        return UserRole.parent;
    }
  }

  /// Title displayed on role cards and login headers.
  String get title {
    switch (this) {
      case LoginRole.administrator:
        return 'Administrator';
      case LoginRole.teacher:
        return 'Teacher';
      case LoginRole.parent:
        return 'Parent';
    }
  }

  /// Subtitle explaining what the role handles.
  String get subtitle {
    switch (this) {
      case LoginRole.administrator:
        return 'Manage school operations';
      case LoginRole.teacher:
        return 'Attendance, homework & academics';
      case LoginRole.parent:
        return "View your child's academic information";
    }
  }

  /// Proper Flutter Material Icon for each role.
  IconData get icon {
    switch (this) {
      case LoginRole.administrator:
        return Icons.admin_panel_settings_rounded;
      case LoginRole.teacher:
        return Icons.school_rounded;
      case LoginRole.parent:
        return Icons.family_restroom_rounded;
    }
  }

  /// Resolves database string to [LoginRole].
  static LoginRole? tryFromDatabaseRole(String? dbRole) {
    if (dbRole == null) return null;
    switch (dbRole.toLowerCase().trim()) {
      case 'admin':
      case 'administrator':
        return LoginRole.administrator;
      case 'teacher':
        return LoginRole.teacher;
      case 'guardian':
      case 'parent':
        return LoginRole.parent;
      default:
        return null;
    }
  }

  /// Resolves database string to [LoginRole] with fallback to [LoginRole.parent].
  static LoginRole fromDatabaseRole(String dbRole) {
    return tryFromDatabaseRole(dbRole) ?? LoginRole.parent;
  }

  /// User-friendly label for error messages and UI display.
  static String formatDatabaseRole(String? dbRole) {
    final role = tryFromDatabaseRole(dbRole);
    if (role != null) return role.title;
    if (dbRole == null || dbRole.isEmpty) return 'Unknown Role';
    return dbRole[0].toUpperCase() + dbRole.substring(1);
  }
}
