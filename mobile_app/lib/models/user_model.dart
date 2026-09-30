enum UserRole {
  parent,
  teacher,
  admin,
}

class AppUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final String designation;
  final String? studentId; // If parent
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
        return 'Parent / Student';
      case UserRole.teacher:
        return 'Class Teacher';
      case UserRole.admin:
        return 'School Administration';
    }
  }
}
