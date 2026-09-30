import 'package:flutter/foundation.dart';
import '../models/user_model.dart';
import '../services/school_data_repository.dart';

class AuthProvider extends ChangeNotifier {
  AppUser _currentUser = SchoolDataRepository.demoUsers.first; // Default to Parent demo

  AppUser get currentUser => _currentUser;
  UserRole get currentRole => _currentUser.role;

  bool get isParent => _currentUser.role == UserRole.parent;
  bool get isTeacher => _currentUser.role == UserRole.teacher;
  bool get isAdmin => _currentUser.role == UserRole.admin;

  void switchUser(AppUser user) {
    _currentUser = user;
    notifyListeners();
  }

  void switchRole(UserRole role) {
    final user = SchoolDataRepository.demoUsers.firstWhere(
      (u) => u.role == role,
      orElse: () => SchoolDataRepository.demoUsers.first,
    );
    _currentUser = user;
    notifyListeners();
  }
}
