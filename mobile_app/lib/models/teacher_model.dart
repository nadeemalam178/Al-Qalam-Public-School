class TeacherModel {
  final String id;
  final String name;
  final String subject;
  final String classAssigned;
  final String phone;
  final String email;
  final String qualification;
  final String loginId;
  final String password;
  final bool isActive;

  TeacherModel({
    required this.id,
    required this.name,
    required this.subject,
    required this.classAssigned,
    required this.phone,
    required this.email,
    this.qualification = 'B.Ed / Trained Graduate',
    String? loginId,
    String? password,
    this.isActive = true,
  })  : loginId = loginId ?? (phone.isNotEmpty ? phone : email),
        password = password ?? 'alqalam123';

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'subject': subject,
        'class_assigned': classAssigned,
        'phone': phone,
        'email': email,
        'qualification': qualification,
        'login_id': loginId,
        'password': password,
        'is_active': isActive,
      };

  factory TeacherModel.fromJson(Map<String, dynamic> json) => TeacherModel(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? json['full_name'] as String? ?? '',
        subject: json['subject'] as String? ??
            json['designation'] as String? ??
            'Primary Teacher',
        classAssigned: json['class_assigned'] as String? ?? 'All Classes',
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String? ?? '',
        qualification: json['qualification'] as String? ?? 'Trained Teacher',
        loginId: json['login_id'] as String?,
        password: json['password'] as String?,
        isActive: json['is_active'] as bool? ?? true,
      );

  TeacherModel copyWith({
    String? id,
    String? name,
    String? subject,
    String? classAssigned,
    String? phone,
    String? email,
    String? qualification,
    String? loginId,
    String? password,
    bool? isActive,
  }) {
    return TeacherModel(
      id: id ?? this.id,
      name: name ?? this.name,
      subject: subject ?? this.subject,
      classAssigned: classAssigned ?? this.classAssigned,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      qualification: qualification ?? this.qualification,
      loginId: loginId ?? this.loginId,
      password: password ?? this.password,
      isActive: isActive ?? this.isActive,
    );
  }
}
