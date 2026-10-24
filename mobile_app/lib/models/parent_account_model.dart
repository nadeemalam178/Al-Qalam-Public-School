class ParentAccountModel {
  final String id;
  final String studentName;
  final String parentName;
  final String grade;
  final String rollNo;
  final String phone;
  final String loginId;
  final String password;
  final bool isActive;
  final DateTime createdAt;

  ParentAccountModel({
    required this.id,
    required this.studentName,
    required this.parentName,
    required this.grade,
    required this.rollNo,
    required this.phone,
    String? loginId,
    String? password,
    this.isActive = true,
    DateTime? createdAt,
  })  : loginId = loginId != null && loginId.trim().isNotEmpty
            ? loginId.trim()
            : (phone.trim().isNotEmpty ? phone.trim() : 'parent_${id.substring(0, 6)}'),
        password = password != null && password.trim().isNotEmpty
            ? password.trim()
            : 'alqalam2026',
        createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toJson() => {
        'id': id,
        'student_name': studentName,
        'parent_name': parentName,
        'grade': grade,
        'roll_no': rollNo,
        'phone': phone,
        'login_id': loginId,
        'password': password,
        'is_active': isActive,
        'created_at': createdAt.toIso8601String(),
      };

  factory ParentAccountModel.fromJson(Map<String, dynamic> json) =>
      ParentAccountModel(
        id: json['id'] as String? ?? '',
        studentName: json['student_name'] as String? ?? 'Al-Qalam Student',
        parentName: json['parent_name'] as String? ?? 'Guardian',
        grade: json['grade'] as String? ?? 'Class 1',
        rollNo: json['roll_no']?.toString() ?? '1',
        phone: json['phone'] as String? ?? '',
        loginId: json['login_id'] as String?,
        password: json['password'] as String?,
        isActive: json['is_active'] as bool? ?? true,
        createdAt: json['created_at'] != null
            ? DateTime.tryParse(json['created_at'] as String) ?? DateTime.now()
            : DateTime.now(),
      );

  ParentAccountModel copyWith({
    String? id,
    String? studentName,
    String? parentName,
    String? grade,
    String? rollNo,
    String? phone,
    String? loginId,
    String? password,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return ParentAccountModel(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      parentName: parentName ?? this.parentName,
      grade: grade ?? this.grade,
      rollNo: rollNo ?? this.rollNo,
      phone: phone ?? this.phone,
      loginId: loginId ?? this.loginId,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
