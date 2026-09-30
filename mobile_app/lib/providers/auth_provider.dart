import 'package:flutter/foundation.dart';
import '../models/login_role.dart';
import '../models/user_model.dart';
import '../services/auth_repository.dart';
import '../services/school_data_repository.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository _authRepository;

  AuthProvider({AuthRepository? authRepository})
      : _authRepository = authRepository ?? const SupabaseAuthRepository();

  AppUser? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  LoginRole? _selectedRole;

  // Getters
  AppUser? get user => _currentUser;
  AppUser get currentUser =>
      _currentUser ?? SchoolDataRepository.demoUsers.first;
  bool get isAuthenticated => _currentUser != null;
  UserRole get currentRole => currentUser.role;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginRole? get selectedRole => _selectedRole;

  bool get isParent => currentRole == UserRole.parent;
  bool get isTeacher => currentRole == UserRole.teacher;
  bool get isAdmin => currentRole == UserRole.admin;

  void setSelectedRole(LoginRole? role) {
    _selectedRole = role;
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  /// Sign in using selected role context and credentials.
  /// Enforces server-side database role verification.
  Future<bool> signIn({
    required LoginRole selectedRole,
    required String identifier,
    required String password,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final user = await _authRepository.signIn(
        selectedRole: selectedRole,
        identifier: identifier,
        password: password,
      );
      _currentUser = user;
      _selectedRole = selectedRole;
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
      return true;
    } on AuthFailureException catch (e) {
      _errorMessage = e.message;
      _isLoading = false;
      notifyListeners();
      return false;
    } catch (e) {
      debugPrint('Unexpected error in AuthProvider.signIn: $e');
      _errorMessage = 'An unexpected error occurred. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  /// Sign out current authenticated session.
  Future<void> signOut() async {
    _isLoading = true;
    notifyListeners();
    try {
      await _authRepository.signOut();
    } finally {
      _currentUser = null;
      _selectedRole = null;
      _isLoading = false;
      _errorMessage = null;
      notifyListeners();
    }
  }

  /// Restore persisted session from secure storage on app launch.
  Future<bool> restoreSession() async {
    _isLoading = true;
    notifyListeners();
    try {
      final user = await _authRepository.restoreSession();
      if (user != null) {
        _currentUser = user;
        _selectedRole = LoginRole.fromDatabaseRole(user.role.databaseRole);
        _isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (e) {
      debugPrint('Error restoring session: $e');
    }
    _isLoading = false;
    notifyListeners();
    return false;
  }

  /// In-memory user switch for testing and preview modes.
  void switchUser(AppUser user) {
    _currentUser = user;
    _selectedRole = LoginRole.fromDatabaseRole(user.role.databaseRole);
    notifyListeners();
  }

  /// In-memory role switch for testing and preview modes.
  void switchRole(UserRole role) {
    final user = SchoolDataRepository.demoUsers.firstWhere(
      (u) => u.role == role,
      orElse: () => SchoolDataRepository.demoUsers.first,
    );
    _currentUser = user;
    _selectedRole = LoginRole.fromDatabaseRole(role.databaseRole);
    notifyListeners();
  }
}
