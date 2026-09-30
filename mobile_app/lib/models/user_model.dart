enum UserRole {
  parent,
  teacher,
  admin;

  /// Resolves database string (e.g. 'guardian', 'admin', 'teacher') to [UserRole].
  static UserRole fromDatabaseRole(String dbRole) {
    switch (dbRole.toLowerCase().trim()) {
      case 'admin':
      case 'administrator':
        return UserRole.admin;
      case 'teacher':
        return UserRole.teacher;
      case 'guardian':
      case 'parent':
        return UserRole.parent;
      default:
        return UserRole.parent;
    }
  }

  /// Internal database role representation for Supabase PostgreSQL RLS.
  String get databaseRole {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.teacher:
        return 'teacher';
      case UserRole.parent:
        return 'guardian';
    }
  }
}

class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String designation;
  final String? studentId; // If guardian / parent
  final String? classAssigned; // If teacher

  const AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    required this.designation,
    this.studentId,
    this.classAssigned,
  });

  String get roleDisplayName {
    switch (role) {
      case UserRole.parent:
        return 'Parent / Guardian';
      case UserRole.teacher:
        return 'Class Teacher';
      case UserRole.admin:
        return 'School Administration';
    }
  }
}
